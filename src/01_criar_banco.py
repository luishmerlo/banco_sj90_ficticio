from config import engine
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError

try:
    with open("sql/01_schema.sql", "r", encoding="utf-8") as file:
        comando_schema = file.read()

    with engine.begin() as conn:
        conn.execute(text(comando_schema))

    with open("sql/02_tabelas.sql", "r", encoding="utf-8") as file:
        comando_tabelas = file.read()

    with engine.begin() as conn:
        conn.execute(text(comando_tabelas))

except FileNotFoundError as e:
    print(f"Arquivo SQL não encontrado: {e}")
except SQLAlchemyError as e:
    print(f"Erro ao executar comando SQL: {e}")
except Exception as e:
    print(f"Erro inesperado: {e}")
else:
    print("Schema e tabelas criados com sucesso.")
