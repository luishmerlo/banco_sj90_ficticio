import requests
import pandas as pd
from config import engine
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import text

try:
    response = requests.get("https://brasilapi.com.br/api/banks/v1")
    resultado = response.json()
except requests.exceptions.RequestException as e:
    print(f"Falha ao acessar API de bancos: {e}")
except Exception as e:
    print(f"Erro inesperado: {e}")
else:
    print("Bancos carregados com sucesso.")
    df_bancos = pd.DataFrame(resultado)
    df_bancos_filtrado = df_bancos.loc[:, ["code", "ispb", "name"]]
    df_bancos_filtrado = df_bancos_filtrado.rename(
        columns={"name": "nome", "code": "codigo"}
    )

    # Para excluir registros com valores nulos:
    df_bancos_filtrado = df_bancos_filtrado.dropna(subset=["nome", "codigo"])

    # Para excluir registros que tenham o mesmo código de outro banco (necessário pois estamos usando como PK)
    df_bancos_filtrado = df_bancos_filtrado.drop_duplicates(
        subset=["codigo"], keep="first"
    )

    try:
        df_bancos_filtrado.to_sql(
            schema="banco_sj90",
            name="bancos_parceiros",
            con=engine,
            if_exists="append",
            index=False,
        )
    except SQLAlchemyError as e:
        print(f"Erro inesperado na conexão com o banco de dados: {e}")
    except Exception as e:
        print(f"Erro inesperado: {e}")
    else:
        print("Bancos parceiros enviados ao banco de dados com sucesso.")
        try:
            with open("sql/03_dados_ficticios.sql", "r", encoding="utf-8") as file:
                comando_dados = file.read()

            with engine.begin() as conn:
                conn.execute(text(comando_dados))
        except FileNotFoundError as e:
            print(f"Arquivo SQL não encontrado: {e}")
        except SQLAlchemyError as e:
            print(f"Erro ao executar comando SQL: {e}")
        except Exception as e:
            print(f"Erro inesperado: {e}")
        else:
            print("Dados fictícios inseridos com sucesso.")
