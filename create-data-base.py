import pandas as pd
from sqlalchemy import create_engine
import os

# Criando DataFrame da planilha de dados
df = pd.read_excel("C:/Users/levyr/Documents/Portfolio/Database-Analytics-with-SQL/data/E-Commerce-Dataset.xlsx", sheet_name="E Comm")
# Resgatando variáveis de ambientes e construindo conexão com mysql
usuario = os.environ.get('MYSQL_USER')
password = os.environ.get('MYSQL_PASS')
host = "localhost"
nome_banco = "ecommerce"
nome_tabela = "ecommercechurn"

engine = create_engine(f'mysql+mysqlconnector://{usuario}:{password}@{host}/{nome_banco}')

# Enviando o dataframe para o MySQL

df.to_sql(nome_tabela, con=engine, if_exists='replace', index=False)

print(f'DataFrame transformado em tabela {nome_tabela} no MySQL com sucesso!')



