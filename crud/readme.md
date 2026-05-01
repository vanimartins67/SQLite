# Sistema CRUD com Python e MySQL

Este projeto é uma atividade acadêmica que implementa as quatro operações básicas de banco de dados (CRUD: Create, Read, Update e Delete) utilizando a linguagem Python e o banco de dados MySQL.

## Tecnologias Utilizadas
* Python 3
* MySQL / MySQL Workbench
* Biblioteca `mysql-connector-python`

## Como configurar e executar

1. **Clone o repositório:**
   git clone [LINK_DO_SEU_REPOSITORIO]

2. **Instale a dependência necessária:**
   No terminal, execute o comando:
   pip install mysql-connector-python

3. **Configuração do Banco de Dados:**
   Abra o MySQL (ou MySQL Workbench) e execute os comandos SQL abaixo para criar o banco e a tabela:
   ```sql
   CREATE DATABASE db_usuario;
   USE db_usuario;
   CREATE TABLE usuarios (
       id INT AUTO_INCREMENT PRIMARY KEY,
       nome VARCHAR(100),
       email VARCHAR(100),
       endereco VARCHAR(255)
   );