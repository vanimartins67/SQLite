-- =========================================
-- SISTEMA DE LOCADORA - MYSQL
-- =========================================

DROP DATABASE IF EXISTS locadora_saudade;

CREATE DATABASE IF NOT EXISTS locadora_saudade
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE locadora_saudade;

-- =========================================
-- 1) TABELA: clientes
-- =========================================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(150),
    data_cadastro DATE NOT NULL
);

-- =========================================
-- 2) TABELA: funcionarios
-- =========================================
CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_admissao DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

-- =========================================
-- 3) TABELA: categorias
-- =========================================
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(150)
);

-- =========================================
-- 4) TABELA: filmes
-- =========================================
CREATE TABLE filmes (
    id_filme INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    ano_lancamento INT NOT NULL,
    duracao_min INT NOT NULL,
    classificacao_indicativa VARCHAR(10),
    id_categoria INT NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- =========================================
-- 5) TABELA: atores
-- Aqui entram atores e atrizes
-- =========================================
CREATE TABLE atores (
    id_ator INT AUTO_INCREMENT PRIMARY KEY,
    nome_ator VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);

-- =========================================
-- 6) TABELA: filmes_atores
-- Relação N:N entre filmes e atores
-- =========================================
CREATE TABLE filmes_atores (
    id_filme INT NOT NULL,
    id_ator INT NOT NULL,
    personagem VARCHAR(100),
    PRIMARY KEY (id_filme, id_ator),
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme),
    FOREIGN KEY (id_ator) REFERENCES atores(id_ator)
);

-- =========================================
-- 7) TABELA: midias
-- Cada linha = uma cópia física
-- Ex.: um DVD, um VHS, um Blu-ray
-- =========================================
CREATE TABLE midias (
    id_midia INT AUTO_INCREMENT PRIMARY KEY,
    id_filme INT NOT NULL,
    tipo_midia VARCHAR(20) NOT NULL,
    numero_serie VARCHAR(50) NOT NULL UNIQUE,
    status_midia VARCHAR(20) NOT NULL DEFAULT 'Disponível',
    data_aquisicao DATE,
    FOREIGN KEY (id_filme) REFERENCES filmes(id_filme)
);

-- =========================================
-- 8) TABELA: locacoes
-- Cabeçalho da locação
-- =========================================
CREATE TABLE locacoes (
    id_locacao INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_locacao DATE NOT NULL,
    valor_total DECIMAL(10,2) DEFAULT 0,
    status_locacao VARCHAR(20) NOT NULL DEFAULT 'Aberta',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

-- =========================================
-- 9) TABELA: itens_locacao
-- Itens de cada locação
-- =========================================
CREATE TABLE itens_locacao (
    id_item_locacao INT AUTO_INCREMENT PRIMARY KEY,
    id_locacao INT NOT NULL,
    id_midia INT NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    data_devolucao DATE,
    valor_diaria DECIMAL(10,2) NOT NULL,
    multa DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (id_locacao) REFERENCES locacoes(id_locacao),
    FOREIGN KEY (id_midia) REFERENCES midias(id_midia)
);

-- =========================================
-- 10) TABELA: pagamentos
-- =========================================
CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_locacao INT NOT NULL,
    data_pagamento DATE NOT NULL,
    valor_pago DECIMAL(10,2) NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_locacao) REFERENCES locacoes(id_locacao)
);

-- =========================================
-- INSERTS: clientes
-- =========================================
INSERT INTO clientes (nome, cpf, telefone, email, endereco, data_cadastro) VALUES
('Ana Paula Ribeiro', '111.111.111-01', '(67) 99911-0001', 'ana.ribeiro@email.com', 'Rua das Palmeiras, 120', '2024-01-10'),
('Bruno Henrique Alves', '111.111.111-02', '(67) 99911-0002', 'bruno.alves@email.com', 'Av. Central, 455', '2024-01-12'),
('Camila Souza Lima', '111.111.111-03', '(67) 99911-0003', 'camila.lima@email.com', 'Rua Bahia, 88', '2024-01-15'),
('Diego Martins Costa', '111.111.111-04', '(67) 99911-0004', 'diego.costa@email.com', 'Rua dos Ipês, 230', '2024-01-18'),
('Eduarda Fernandes', '111.111.111-05', '(67) 99911-0005', 'eduarda.fernandes@email.com', 'Av. Mato Grosso, 710', '2024-01-20'),
('Felipe Araujo Mendes', '111.111.111-06', '(67) 99911-0006', 'felipe.mendes@email.com', 'Rua Ceará, 55', '2024-01-22'),
('Gabriela Nunes Rocha', '111.111.111-07', '(67) 99911-0007', 'gabriela.rocha@email.com', 'Rua Amazonas, 401', '2024-01-25'),
('Henrique Oliveira', '111.111.111-08', '(67) 99911-0008', 'henrique.oliveira@email.com', 'Rua da Paz, 96', '2024-01-27'),
('Isabela Cristina Melo', '111.111.111-09', '(67) 99911-0009', 'isabela.melo@email.com', 'Av. Afonso Pena, 1500', '2024-01-30'),
('João Victor Barros', '111.111.111-10', '(67) 99911-0010', 'joao.barros@email.com', 'Rua Treze de Maio, 640', '2024-02-01');

-- =========================================
-- INSERTS: funcionarios
-- =========================================
INSERT INTO funcionarios (nome, cargo, telefone, email, data_admissao, salario) VALUES
('Marcos Roberto Silva', 'Gerente', '(67) 99821-0001', 'marcos.silva@locadora.com', '2023-01-10', 3500.00),
('Patrícia Gomes', 'Atendente', '(67) 99821-0002', 'patricia.gomes@locadora.com', '2023-02-15', 1900.00),
('Ricardo Teixeira', 'Caixa', '(67) 99821-0003', 'ricardo.teixeira@locadora.com', '2023-03-01', 1800.00),
('Simone Carvalho', 'Atendente', '(67) 99821-0004', 'simone.carvalho@locadora.com', '2023-03-20', 1900.00),
('Thiago Batista', 'Estoquista', '(67) 99821-0005', 'thiago.batista@locadora.com', '2023-04-10', 1750.00),
('Vanessa Duarte', 'Auxiliar Administrativo', '(67) 99821-0006', 'vanessa.duarte@locadora.com', '2023-05-05', 2100.00),
('Wellington Prado', 'Atendente', '(67) 99821-0007', 'wellington.prado@locadora.com', '2023-06-12', 1900.00),
('Yasmin Freitas', 'Caixa', '(67) 99821-0008', 'yasmin.freitas@locadora.com', '2023-07-08', 1800.00),
('Carlos Eduardo', 'Suporte', '(67) 99821-0009', 'carlos.eduardo@locadora.com', '2023-08-01', 2200.00),
('Fernanda Lopes', 'Atendente', '(67) 99821-0010', 'fernanda.lopes@locadora.com', '2023-09-15', 1900.00);

-- =========================================
-- INSERTS: categorias
-- =========================================
INSERT INTO categorias (nome_categoria, descricao) VALUES
('Ficção Científica', 'Filmes com futuro, tecnologia e viagens no tempo'),
('Drama', 'Filmes com conflitos humanos e emocionais'),
('Ação', 'Filmes com perseguições, batalhas e adrenalina'),
('Suspense', 'Filmes com tensão e mistério'),
('Aventura', 'Filmes com jornadas e exploração'),
('Comédia', 'Filmes focados em humor'),
('Fantasia', 'Filmes com elementos mágicos'),
('Animação', 'Filmes animados para todas as idades'),
('Romance', 'Filmes com foco em relações amorosas'),
('Crime', 'Filmes sobre violência, máfia e investigação');

-- =========================================
-- INSERTS: filmes
-- =========================================
INSERT INTO filmes (titulo, ano_lancamento, duracao_min, classificacao_indicativa, id_categoria, valor_diaria) VALUES
('De Volta para o Futuro', 1985, 116, '12', 1, 7.50),
('Conta Comigo', 1986, 89, '14', 2, 6.50),
('Matrix', 1999, 136, '16', 1, 8.00),
('Pulp Fiction', 1994, 154, '18', 10, 8.50),
('Exterminador do Futuro', 1984, 107, '16', 3, 7.50),
('Jurassic Park', 1993, 127, '12', 5, 8.00),
('Ghost', 1990, 126, '14', 9, 6.50),
('Era do Gelo', 2002, 81, 'Livre', 8, 6.00),
('Os Goonies', 1985, 114, '10', 5, 7.00),
('Indiana Jones e os Caçadores da Arca Perdida', 1981, 115, '12', 5, 8.00);

-- =========================================
-- INSERTS: atores (atores e atrizes)
-- =========================================
INSERT INTO atores (nome_ator, nacionalidade, data_nascimento) VALUES
('Michael J. Fox', 'Canadense', '1961-06-09'),
('Christopher Lloyd', 'Americana', '1938-10-22'),
('Lea Thompson', 'Americana', '1961-05-31'),
('River Phoenix', 'Americana', '1970-08-23'),
('Wil Wheaton', 'Americana', '1972-07-29'),
('Corey Feldman', 'Americana', '1971-07-16'),
('Keanu Reeves', 'Canadense', '1964-09-02'),
('Carrie-Anne Moss', 'Canadense', '1967-08-21'),
('Laurence Fishburne', 'Americana', '1961-07-30'),
('John Travolta', 'Americana', '1954-02-18'),
('Uma Thurman', 'Americana', '1970-04-29'),
('Samuel L. Jackson', 'Americana', '1948-12-21'),
('Arnold Schwarzenegger', 'Austríaca', '1947-07-30'),
('Linda Hamilton', 'Americana', '1956-09-26'),
('Michael Biehn', 'Americana', '1956-07-31'),
('Sam Neill', 'Neozelandesa', '1947-09-14'),
('Laura Dern', 'Americana', '1967-02-10'),
('Jeff Goldblum', 'Americana', '1952-10-22'),
('Patrick Swayze', 'Americana', '1952-08-18'),
('Demi Moore', 'Americana', '1962-11-11'),
('Whoopi Goldberg', 'Americana', '1955-11-13'),
('Ray Romano', 'Americana', '1957-12-21'),
('John Leguizamo', 'Colombiana', '1960-07-22'),
('Denis Leary', 'Americana', '1957-08-18'),
('Sean Astin', 'Americana', '1971-02-25'),
('Josh Brolin', 'Americana', '1968-02-12'),
('Kerri Green', 'Americana', '1967-01-14'),
('Harrison Ford', 'Americana', '1942-07-13'),
('Karen Allen', 'Americana', '1951-10-05'),
('Paul Freeman', 'Britânica', '1943-01-18');

-- =========================================
-- INSERTS: filmes_atores
-- 3 pessoas no elenco por filme
-- =========================================
INSERT INTO filmes_atores (id_filme, id_ator, personagem) VALUES
(1, 1, 'Marty McFly'),
(1, 2, 'Dr. Emmett Brown'),
(1, 3, 'Lorraine Baines McFly'),

(2, 4, 'Chris Chambers'),
(2, 5, 'Gordie Lachance'),
(2, 6, 'Teddy Duchamp'),

(3, 7, 'Neo'),
(3, 8, 'Trinity'),
(3, 9, 'Morpheus'),

(4, 10, 'Vincent Vega'),
(4, 11, 'Mia Wallace'),
(4, 12, 'Jules Winnfield'),

(5, 13, 'Terminator'),
(5, 14, 'Sarah Connor'),
(5, 15, 'Kyle Reese'),

(6, 16, 'Dr. Alan Grant'),
(6, 17, 'Dr. Ellie Sattler'),
(6, 18, 'Dr. Ian Malcolm'),

(7, 19, 'Sam Wheat'),
(7, 20, 'Molly Jensen'),
(7, 21, 'Oda Mae Brown'),

(8, 22, 'Manny'),
(8, 23, 'Sid'),
(8, 24, 'Diego'),

(9, 25, 'Mikey Walsh'),
(9, 26, 'Brand Walsh'),
(9, 27, 'Andy Carmichael'),

(10, 28, 'Indiana Jones'),
(10, 29, 'Marion Ravenwood'),
(10, 30, 'Dr. René Belloq');

-- =========================================
-- INSERTS: midias
-- Controle real do estoque por unidade física
-- =========================================
INSERT INTO midias (id_filme, tipo_midia, numero_serie, status_midia, data_aquisicao) VALUES
(1, 'DVD',     'DVD-0001', 'Disponível', '2024-02-01'),
(1, 'VHS',     'VHS-0002', 'Disponível', '2024-02-01'),
(2, 'DVD',     'DVD-0003', 'Disponível', '2024-02-02'),
(3, 'Blu-ray', 'BR-0004',  'Alugada',    '2024-02-03'),
(3, 'DVD',     'DVD-0005', 'Disponível', '2024-02-03'),
(4, 'DVD',     'DVD-0006', 'Disponível', '2024-02-04'),
(5, 'VHS',     'VHS-0007', 'Disponível', '2024-02-05'),
(5, 'DVD',     'DVD-0008', 'Manutenção', '2024-02-05'),
(6, 'DVD',     'DVD-0009', 'Disponível', '2024-02-06'),
(6, 'Blu-ray', 'BR-0010',  'Alugada',    '2024-02-06'),
(7, 'DVD',     'DVD-0011', 'Disponível', '2024-02-07'),
(8, 'DVD',     'DVD-0012', 'Alugada',    '2024-02-08'),
(9, 'VHS',     'VHS-0013', 'Disponível', '2024-02-09'),
(10,'Blu-ray', 'BR-0014',  'Disponível', '2024-02-10'),
(10,'DVD',     'DVD-0015', 'Disponível', '2024-02-10');

-- =========================================
-- INSERTS: locacoes
-- =========================================
INSERT INTO locacoes (id_cliente, id_funcionario, data_locacao, valor_total, status_locacao) VALUES
(1, 2,  '2024-03-01',  7.50, 'Fechada'),
(2, 2,  '2024-03-02',  6.50, 'Fechada'),
(3, 4,  '2024-03-03',  8.00, 'Aberta'),
(4, 4,  '2024-03-04', 15.00, 'Fechada'),
(5, 7,  '2024-03-05',  7.50, 'Fechada'),
(6, 10, '2024-03-06',  8.00, 'Fechada'),
(7, 2,  '2024-03-07', 10.00, 'Fechada'),
(8, 7,  '2024-03-08',  6.00, 'Aberta'),
(9, 10, '2024-03-09', 15.00, 'Fechada'),
(1, 4,  '2024-03-10',  8.00, 'Aberta');

-- =========================================
-- INSERTS: itens_locacao
-- =========================================
INSERT INTO itens_locacao (id_locacao, id_midia, data_prevista_devolucao, data_devolucao, valor_diaria, multa) VALUES
(1, 1,  '2024-03-03', '2024-03-03', 7.50, 0.00),
(2, 3,  '2024-03-04', '2024-03-04', 6.50, 0.00),
(3, 4,  '2024-03-05', NULL,         8.00, 0.00),
(4, 6,  '2024-03-06', '2024-03-06', 8.50, 0.00),
(4, 11, '2024-03-06', '2024-03-06', 6.50, 0.00),
(5, 7,  '2024-03-07', '2024-03-07', 7.50, 0.00),
(6, 9,  '2024-03-08', '2024-03-08', 8.00, 0.00),
(7, 5,  '2024-03-09', '2024-03-11', 8.00, 2.00),
(8, 12, '2024-03-10', NULL,         6.00, 0.00),
(9, 13, '2024-03-11', '2024-03-11', 7.00, 0.00),
(9, 14, '2024-03-11', '2024-03-11', 8.00, 0.00),
(10,10, '2024-03-12', NULL,         8.00, 0.00);

-- =========================================
-- INSERTS: pagamentos
-- =========================================
INSERT INTO pagamentos (id_locacao, data_pagamento, valor_pago, forma_pagamento) VALUES
(1,  '2024-03-01',  7.50, 'Cartão de Débito'),
(2,  '2024-03-02',  6.50, 'Dinheiro'),
(3,  '2024-03-03',  8.00, 'Cartão de Crédito'),
(4,  '2024-03-04', 15.00, 'Pix'),
(5,  '2024-03-05',  7.50, 'Dinheiro'),
(6,  '2024-03-06',  8.00, 'Pix'),
(7,  '2024-03-07', 10.00, 'Cartão de Débito'),
(8,  '2024-03-08',  6.00, 'Cartão de Crédito'),
(9,  '2024-03-09', 15.00, 'Dinheiro'),
(10, '2024-03-10',  8.00, 'Pix');

-- =========================================
-- CONSULTAS SQL
-- =========================================

-- 1) Listar todos os clientes
SELECT * FROM clientes;

-- 2) Filtrar filmes lançados antes de 1990
SELECT titulo, ano_lancamento, valor_diaria
FROM filmes
WHERE ano_lancamento < 1990
ORDER BY ano_lancamento;

-- 3) INNER JOIN entre filmes e categorias
SELECT f.titulo, c.nome_categoria, f.valor_diaria
FROM filmes f
INNER JOIN categorias c ON f.id_categoria = c.id_categoria
ORDER BY f.titulo;

-- 4) LEFT JOIN para mostrar clientes com ou sem locações
SELECT c.id_cliente, c.nome, COUNT(l.id_locacao) AS qtd_locacoes
FROM clientes c
LEFT JOIN locacoes l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY c.nome;

-- 5) COUNT: quantidade de mídias por tipo
SELECT tipo_midia, COUNT(*) AS quantidade
FROM midias
GROUP BY tipo_midia
ORDER BY quantidade DESC;

-- 6) SUM: total arrecadado em pagamentos
SELECT SUM(valor_pago) AS total_arrecadado
FROM pagamentos;

-- 7) AVG: média do valor das locações
SELECT AVG(valor_total) AS media_valor_locacoes
FROM locacoes;

-- 8) GROUP BY: total arrecadado por forma de pagamento
SELECT forma_pagamento, SUM(valor_pago) AS total_por_forma
FROM pagamentos
GROUP BY forma_pagamento
ORDER BY total_por_forma DESC;

-- 9) Clientes que fizeram mais de 1 locação (simplificado)
SELECT c.nome, COUNT(l.id_locacao) AS qtd_locacoes
FROM clientes c
INNER JOIN locacoes l ON c.id_cliente = l.id_cliente
GROUP BY c.nome
HAVING COUNT(l.id_locacao) > 1;

-- 10) Filmes mais alugados (ajustado)
SELECT f.titulo, COUNT(il.id_item_locacao) AS vezes_alugado
FROM filmes f
INNER JOIN midias m ON f.id_filme = m.id_filme
INNER JOIN itens_locacao il ON m.id_midia = il.id_midia
GROUP BY f.titulo
ORDER BY vezes_alugado DESC;

-- 11) Elenco de cada filme
SELECT f.titulo, a.nome_ator, fa.personagem
FROM filmes f
INNER JOIN filmes_atores fa ON f.id_filme = fa.id_filme
INNER JOIN atores a ON fa.id_ator = a.id_ator
ORDER BY f.titulo, a.nome_ator;

-- 12) Locação com cliente e filme (SIMPLIFICADO)
SELECT 
    l.id_locacao,
    c.nome AS cliente,
    f.titulo AS filme
FROM locacoes l
INNER JOIN clientes c ON l.id_cliente = c.id_cliente
INNER JOIN itens_locacao il ON l.id_locacao = il.id_locacao
INNER JOIN midias m ON il.id_midia = m.id_midia
INNER JOIN filmes f ON m.id_filme = f.id_filme;

-- 13) Condições compostas
SELECT titulo, ano_lancamento, valor_diaria, classificacao_indicativa
FROM filmes
WHERE (ano_lancamento < 1995 AND valor_diaria >= 7.50)
   OR classificacao_indicativa = 'Livre'
ORDER BY ano_lancamento;

-- 14) Mídias que nunca foram alugadas
SELECT m.id_midia, f.titulo, m.tipo_midia, m.status_midia
FROM midias m
INNER JOIN filmes f ON m.id_filme = f.id_filme
LEFT JOIN itens_locacao il ON m.id_midia = il.id_midia
WHERE il.id_item_locacao IS NULL
ORDER BY m.id_midia;

-- 15) Total de mídias por filme (SIMPLIFICADO)
SELECT 
    f.titulo,
    COUNT(m.id_midia) AS total_midias
FROM filmes f
LEFT JOIN midias m ON f.id_filme = m.id_filme
GROUP BY f.titulo
ORDER BY f.titulo;