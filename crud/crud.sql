CREATE DATABASE db_usuario;
USE db_usuario;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    endereco VARCHAR(100)
);
INSERT INTO usuarios (nome, email, endereco)
VALUES ("Vanessa", "teste@email.com", "Campo Grande");

SELECT * FROM usuarios;
