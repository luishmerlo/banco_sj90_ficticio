import pandas as pd
from config import engine
from sqlalchemy.exc import SQLAlchemyError

# Criação do DataFrame vindo do arquivo csv / Processamento dos chunks e criação de nova tabela SQL:
try:
    df_fraud = pd.read_csv("data/fraudes_amostra.csv", chunksize=10000)

    df_cartoes = pd.read_sql(
        "SELECT id_cartao FROM banco_sj90.cartoes_credito", con=engine
    )
except FileNotFoundError as e:
    print(f"Arquivo CSV não encontrado: {e}")
except Exception as e:
    print(f"Erro inesperado: {e}")
else:
    print("CSV localizado com sucesso.")
    print()

    try:
        for idx, chunk in enumerate(df_fraud):
            print(f"Processando chunk número {idx + 1}...")

            # Merge com o id do cartão de crédito:
            chunk_bloco = pd.merge(chunk, df_cartoes, on="id_cartao", how="inner")

            print(f"Filtrando possíveis fraudes no chunk número {idx + 1}...")

            # Foi adotado um limite hipotético de valor superior a 1000 dólares e
            # determinadas categorias de transação como potencialmente suspeitas
            chunk_frauds = chunk_bloco[
                (chunk_bloco["amt"] > 1000)
                & (
                    chunk_bloco["category"].isin(
                        ["shopping_net", "shopping_pos", "travel"]
                    )
                )
            ]

            chunk_frauds.to_sql(
                schema="banco_sj90",
                name="fraudes",
                con=engine,
                if_exists="append",
                index=False,
            )
            print(f"Chunk número {idx + 1} enviado para o banco de dados.")
            print()
    except SQLAlchemyError as e:
        print(f"Erro inesperado na conexão com o banco de dados: {e}")
    except Exception as e:
        print(f"Erro inesperado: {e}")
    else:
        print(f"Envio ao banco de dados concluído.")

        # Exportando arquivo JSON com base na tabela de fraudes:
        try:
            query = """
                SELECT f.id, f.trans_num, f.merchant, f.category, f.amt, f.unix_time,
                f.id_cartao, c.numero_cartao, b.nome AS banco
                FROM banco_sj90.fraudes f
                JOIN banco_sj90.cartoes_credito c ON c.id_cartao = f.id_cartao
                JOIN banco_sj90.bancos_parceiros b ON b.codigo = c.id_banco
                ORDER BY f.id
            """

            df_relatorio = pd.read_sql(query, con=engine)
        except SQLAlchemyError as e:
            print(f"Erro inesperado na conexão com o banco de dados: {e}")
        except Exception as e:
            print(f"Erro inesperado: {e}")
        else:
            df_relatorio.to_json(
                "output/possiveis_fraudes.json", orient="records", indent=4
            )
            print("Relatório exportado com sucesso.")
