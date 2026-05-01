CREATE DATABASE locadora;

USE locadora;



-- =========================

-- CLIENTES

-- =========================

CREATE TABLE clientes (

    id INT PRIMARY KEY AUTO_INCREMENT,

    nome VARCHAR(100) NOT NULL,

    cpf VARCHAR(14) UNIQUE NOT NULL,

    telefone VARCHAR(20),

    email VARCHAR(100)

);



-- =========================

-- CATEGORIAS DE VEÍCULOS

-- =========================

CREATE TABLE categorias (

    id INT PRIMARY KEY AUTO_INCREMENT,

    nome VARCHAR(50) NOT NULL

);



-- =========================

-- VEÍCULOS

-- =========================

CREATE TABLE veiculos (

    id INT PRIMARY KEY AUTO_INCREMENT,

    modelo VARCHAR(100) NOT NULL,

    marca VARCHAR(100),

    ano INT,

    categoria_id INT,

    disponivel BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (categoria_id) REFERENCES categorias(id)

);



-- =========================

-- FUNCIONÁRIOS

-- =========================

CREATE TABLE funcionarios (

    id INT PRIMARY KEY AUTO_INCREMENT,

    nome VARCHAR(100) NOT NULL,

    cargo VARCHAR(50)

);



-- =========================

-- LOCAÇÕES

-- =========================

CREATE TABLE locacoes (

    id INT PRIMARY KEY AUTO_INCREMENT,

    cliente_id INT,

    veiculo_id INT,

    funcionario_id INT,

    data_inicio DATE,

    data_fim DATE,

    valor_total DECIMAL(10,2),

    FOREIGN KEY (cliente_id) REFERENCES clientes(id),

    FOREIGN KEY (veiculo_id) REFERENCES veiculos(id),

    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)

);



-- =========================

-- PAGAMENTOS

-- =========================

CREATE TABLE pagamentos (

    id INT PRIMARY KEY AUTO_INCREMENT,

    locacao_id INT,

    forma_pagamento VARCHAR(50),

    valor DECIMAL(10,2),

    FOREIGN KEY (locacao_id) REFERENCES locacoes(id)

);



-- =========================

-- INSERINDO DADOS

-- =========================



INSERT INTO clientes (nome, cpf, telefone, email) VALUES

('João Silva', '111.111.111-11', '9999-1111', 'joao@email.com'),

('Maria Souza', '222.222.222-22', '9999-2222', 'maria@email.com'),

('Carlos Lima', '333.333.333-33', '9999-3333', 'carlos@email.com');



INSERT INTO categorias (nome) VALUES

('Econômico'),

('SUV'),

('Luxo');



INSERT INTO veiculos (modelo, marca, ano, categoria_id, disponivel) VALUES

('Onix', 'Chevrolet', 2022, 1, TRUE),

('HB20', 'Hyundai', 2023, 1, TRUE),

('Compass', 'Jeep', 2022, 2, FALSE),

('BMW X1', 'BMW', 2023, 3, TRUE);



INSERT INTO funcionarios (nome, cargo) VALUES

('Ana Paula', 'Atendente'),

('Bruno Costa', 'Gerente');



INSERT INTO locacoes (cliente_id, veiculo_id, funcionario_id, data_inicio, data_fim, valor_total) VALUES

(1, 1, 1, '2025-01-10', '2025-01-15', 500.00),

(2, 3, 2, '2025-02-01', '2025-02-05', 1200.00);



INSERT INTO pagamentos (locacao_id, forma_pagamento, valor) VALUES

(1, 'Cartão', 500.00),

(2, 'Pix', 1200.00);
-- 1
SELECT clientes.nome, locacoes.id
FROM clientes
JOIN locacoes ON clientes.id = locacoes.cliente_id
ORDER BY clientes.nome;
-- 2
SELECT clientes.nome, COUNT(locacoes.id) AS total_locacoes
FROM clientes
LEFT JOIN locacoes ON clientes.id = locacoes.cliente_id
GROUP BY clientes.nome;
-- 3
SELECT clientes.id, COUNT(locacoes.id) AS total_locacoes
FROM clientes
JOIN locacoes ON clientes.id = locacoes.cliente_id
GROUP BY clientes.id;
-- 4
SELECT clientes.nome, locacoes.id
FROM clientes
LEFT JOIN locacoes ON clientes.id = locacoes.cliente_id
ORDER BY locacoes.id;
-- 5
SELECT locacoes.id, COUNT(locacoes.cliente_id) AS total
FROM locacoes
GROUP BY locacoes.id;
-- 6
SELECT clientes.nome, locacoes.id
FROM clientes
JOIN locacoes ON clientes.id = locacoes.cliente_id
ORDER BY locacoes.valor_total DESC;
-- 7
SELECT clientes.nome, COUNT(locacoes.id) AS total_locacoes
FROM clientes
LEFT JOIN locacoes ON clientes.id = locacoes.cliente_id
GROUP BY clientes.nome
ORDER BY total_locacoes DESC;
-- 8
SELECT clientes.nome, COUNT(locacoes.id) AS total_locacoes
FROM clientes
JOIN locacoes ON clientes.id = locacoes.cliente_id
GROUP BY clientes.nome;
-- 9
SELECT clientes.nome, locacoes.id
FROM clientes
LEFT JOIN locacoes ON clientes.id = locacoes.cliente_id
ORDER BY clientes.nome;
-- 10
SELECT clientes.nome, COUNT(locacoes.id) AS total_locacoes
FROM clientes
LEFT JOIN locacoes ON clientes.id = locacoes.cliente_id
GROUP BY clientes.nome
ORDER BY total_locacoes DESC;
-- 11
SELECT clientes.nome, locacoes.id
FROM clientes
CROSS JOIN locacoes
ORDER BY clientes.nome;

