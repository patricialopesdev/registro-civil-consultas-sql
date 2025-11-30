import pandas as pd
import mysql.connector

# LEITURA DO ARQUIVO CSV
df = pd.read_csv("registro_civil_2023.csv", sep=";", encoding="latin1")
df.columns = ['id', 'titulo_tabela']

# CATEGORIZAÇÃO
def categorizar(titulo):
    titulo = str(titulo).lower()
    if "nascimento" in titulo:
        return "nascimento"
    elif "casamento" in titulo:
        return "casamento"
    elif "óbito" in titulo or "obito" in titulo:
        return "óbito"
    elif "divórcio" in titulo or "divorcio" in titulo:
        return "divórcio"
    else:
        return "outros"

df["categoria"] = df["titulo_tabela"].apply(categorizar)

# CONEXÃO COM O BANCO DE DADOS
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="9644",
    database="registro_civil_2023"
)

cursor = conn.cursor()

# CRIAÇÃO DA TABELA SE NÃO EXISTIR
cursor.execute("""
CREATE TABLE IF NOT EXISTS registro_civil (
    id INT PRIMARY KEY,
    titulo_tabela VARCHAR(500),
    categoria VARCHAR(50)
)
""")

# INSERÇÃO COM ATUALIZAÇÃO EM CASO DE DUPLICATA
for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO registro_civil (id, titulo_tabela, categoria)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE
            titulo_tabela = VALUES(titulo_tabela),
            categoria = VALUES(categoria)
    """, (int(row['id']), row['titulo_tabela'], row['categoria']))

conn.commit()
cursor.close()
conn.close()