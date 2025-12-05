import sqlite3
banco = sqlite3.connect('ADS2025.db')
cursor = banco.cursor()

# cursor.execute("CREATE TABLE produtos (nome text, qtd intenger, valor float)")

# nome = "Carnes"
# qtd = 2
# valor = 100.00

nome = input("Digite o nome do produto: ")
qtd = int(input("Digite a quantidade do produto: "))
valor = float(input("Digite o valor do produto: "))

# cursor.execute("INSERT INTO produtos VALUES ('Fruta', 25, 10.00)")
cursor.execute("INSERT INTO produtos VALUES ('"+nome+"', "+str(qtd)+", "+str(valor)+")")

cursor.execute("SELECT * FROM produtos")
print(cursor.fetchall())
banco.commit()

