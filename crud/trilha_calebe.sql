create database clientes;
use clientes;

create table clientes(
id_cliente int primary key not null auto_increment,
nome varchar(100) not null,
email varchar(100) not null unique,
cpf varchar(14) not null unique,
telefone varchar(15),
data_nascimento date,
data_cadastro timestamp default current_timestamp
);

create table categorias(
id_categoria int primary key not null auto_increment,
nome varchar(50) not null,
descricao text,
ativo boolean default true
);

create table fornecedores(
id_fornecedores int primary key not null auto_increment,
razao_social varchar(150) not null,
cnpj varchar(18) unique not null,
email varchar(100),
telefone varchar(15),
cidade varchar(50),
estado char(2)
);

create table produtos(
id_produto int primary key auto_increment,
nome varchar(100) not null,
descricao text,
preco decimal(10,2) not null,
id_categoria int,
id_fornecedor int,
ativo boolean default true
);

create table funcionarios(
id_funcionario int primary key auto_increment,
nome varchar(100) not null,
ncargo varchar(50) not null,
salario decimal(10,2) not null,
data_admissao date not null,
departamento varchar(50),
ativo boolean default true
);

create table pedidos(
id_pedido int primary key auto_increment,
id_cliente int not null,
id_funcionario int,
data_pedido timestamp default current_timestamp,
valor_total decimal(10,2),
estatus varchar(20) default 'pendente' 
);

create table estoque(
id_estoque int primary key auto_increment,
id_produto int not null,
quantidade int default 0,
quantidade_minima int default 10,
localizacao varchar(50),
ultima_atualizacao timestamp default current_timestamp
);

create table pagamentos(
id_pagamento int primary key auto_increment,
id_pedido int not null,
valor decimal (10,2) not null,
metodo varchar(30) not null,
estatus varchar (20) default 'pendente',
data_pagamento datetime
);

insert into categorias(nome, descricao) values 
("Hardware", "Computadores, notebooks e componentes"), 
("Periféricos Gamer", "Mouses, teclados e controles"), 
("Dispositivos Móveis", "Smartphones e acessórios"), 
("Áudio", "Fones de ouvido e caixas de som"),
("Bebidas", "Destilados e bebidas para eventos");

INSERT INTO fornecedores (razao_social, cnpj, email, telefone, cidade, estado) VALUES
('Tech Importados MS LTDA', '12.345.678/0001-90', 'vendas@techms.com.br', '(67) 3344-7890', 'Campo Grande', 'MS'),
('Logi Distribuidora Nacional', '23.456.789/0001-11', 'contato@logidistribuidora.com.br', '(11) 3344-5566', 'São Paulo', 'SP'),
('Adega Central Distribuição LTDA', '34.567.890/0001-22', 'comercial@adegacentral.com.br', '(67) 3222-4455', 'Campo Grande', 'MS'),
('Eletro Componentes BR', '45.678.901/0001-33', 'atendimento@eletrobr.com.br', '(41) 3555-7788', 'Curitiba', 'PR');

INSERT INTO clientes (nome, email, cpf, telefone, data_nascimento, data_cadastro) VALUES
('Vanessa de Almeida Martins', 'vanessa.martins@email.com', '123.456.789-10', '(67) 99876-5432', '1980-08-15', '2026-03-01'),
('Ana Clara Souza', 'ana.souza@email.com', '234.567.890-21', '(67) 99765-4321', '1992-09-23', '2026-03-01'),
('Pedro Henrique Costa', 'pedro.costa@email.com', '345.678.901-32', '(67) 99654-3210', '1985-02-17', '2026-03-02'),
('Marcos Silva', 'marcos.silva@email.com', '456.789.012-43', '(67) 99543-2109', '1998-11-30', '2026-03-02'),
('Lucas Gabriel Martins', 'lucas.martins@email.com', '567.890.123-54', '(67) 99432-1098', '1995-07-08', '2026-03-03'),
('Carla Mendes Rocha', 'carla.rocha@email.com', '678.901.234-65', '(67) 99321-0987', '1990-03-14', '2026-03-03');

INSERT INTO funcionarios (nome, ncargo, salario, data_admissao, departamento) VALUES
('Carlos Alberto Mendes', 'Gerente de TI', 8500.00, '2021-03-15', 'Tecnologia da Informação'),
('Juliana Rocha Pereira', 'Analista de Suporte', 3200.00, '2023-06-10', 'Suporte Técnico'),
('Ricardo Fernandes Lima', 'Analista de Sistemas', 5500.00, '2022-01-20', 'Tecnologia da Informação'),
('Patricia Gomes Souza', 'Estoquista', 2400.00, '2024-02-05', 'Logística'),
('Marcos Vinicius Alves', 'Atendente', 2100.00, '2023-09-12', 'Atendimento'),
('Fernanda Cristina Duarte', 'Especialista em Geoprocessamento', 6300.00, '2022-11-28', 'Projetos e Dados');

select * from categorias;
select * from fornecedores;

INSERT INTO produtos (nome, descricao, preco, id_categoria, id_fornecedor) VALUES
('Notebook Predator Helios Neo 16', 'Notebook gamer de alta performance', 7899.90, 1, 1),
('Kit Arduino Uno R3', 'Kit de desenvolvimento com componentes para automação', 189.00, 1, 4),
('Controle Flydigi Vader 3 Pro', 'Gamepad sem fio com gatilhos ajustáveis', 459.90, 2, 1),
('Mouse Logitech Lift', 'Mouse ergonômico vertical para produtividade', 349.90, 2, 2),
('Mouse Logitech G305', 'Mouse gamer sem fio com sensor Hero', 249.90, 2, 2),
('Galaxy S23+', 'Smartphone Samsung 256GB', 4199.00, 3, 1),
('Carregador UGREEN 30W Dual Port', 'Carregador rápido com cabo de 2 metros', 159.90, 3, 1),
('Fone Soundcore Sport X10', 'Fone bluetooth intra-auricular com gancho para academia', 429.00, 4, 1),
('Galaxy Buds2 Pro', 'Fone de ouvido TWS com cancelamento de ruído ativo', 699.00, 4, 1),
('Jameson Irish Whiskey', 'Garrafa de whiskey irlandês 750ml', 119.90, 5, 3);

select * from produtos;

INSERT INTO estoque (id_produto, quantidade, quantidade_minima, localizacao, ultima_atualizacao) VALUES
(1, 15, 5, 'A-01', '2026-03-05'),
(2, 40, 10, 'A-02', '2026-03-05'),
(3, 25, 5, 'B-01', '2026-03-05'),
(4, 30, 10, 'B-02', '2026-03-05'),
(5, 50, 15, 'B-03', '2026-03-05'),
(6, 20, 5, 'C-01', '2026-03-05'),
(7, 80, 20, 'C-02', '2026-03-05'),
(8, 35, 10, 'D-01', '2026-03-05'),
(9, 40, 10, 'D-02', '2026-03-05'),
(10, 120, 24, 'E-01', '2026-03-05');

select * from estoque;

INSERT INTO pedidos (id_cliente, id_funcionario, data_pedido, valor_total, estatus) VALUES
(1, 2, '2026-03-01', 7899.90, 'concluido'),
(2, 3, '2026-03-01', 119.90, 'enviado'),
(3, 5, '2026-03-02', 459.90, 'pendente'),
(4, 2, '2026-03-02', 4199.00, 'processando'),
(1, 4, '2026-03-03', 1048.90, 'concluido'), -- Compra conjunta do G305, Lift e Sport X10
(6, 1, '2026-03-03', 189.00, 'enviado'),
(1, 3, '2026-03-04', 159.90, 'pendente'), -- Compra do Carregador UGREEN
(2, 6, '2026-03-04', 699.00, 'processando'),
(3, 2, '2026-03-05', 249.90, 'concluido'),
(4, 5, '2026-03-05', 119.90, 'enviado'); -- Outro Jameson para o bloco

select * from pedidos;

INSERT INTO pagamentos (id_pedido, valor, metodo, estatus, data_pagamento) VALUES
(1, 7899.90, 'cartao_credito', 'aprovado', '2026-03-01'),
(2, 119.90, 'pix', 'aprovado', '2026-03-01'),
(3, 459.90, 'boleto', 'pendente', '2026-03-02'),
(4, 4199.00, 'cartao_debito', 'aprovado', '2026-03-02'),
(5, 1048.90, 'pix', 'aprovado', '2026-03-03'),
(6, 189.00, 'cartao_credito', 'aprovado', '2026-03-03'),
(7, 159.90, 'boleto', 'pendente', '2026-03-04'),
(8, 699.00, 'cartao_debito', 'aprovado', '2026-03-04'),
(9, 249.90, 'pix', 'aprovado', '2026-03-05'),
(10, 119.90, 'cartao_credito', 'pendente', '2026-03-05');

select * from pagamentos;

-- aula em 12/03/2026
-- exercicio 01
select count(*) as total_clientes from clientes; -- resposta 6 clientes

-- exercicio 02
select sum(valor_total) as receita_total from pedidos;

-- exercicio 03
select id_categoria, round(avg(preco),2) as media from produtos group by id_categoria;

-- exercicio 04
select max(preco) as Maior_Valor, min(preco) as menor_valor from produtos;

-- exercicio 05
select count(*) as total_pedidos, estatus from pedidos group by estatus;

-- exercicio 06
select departamento, sum(salario) as total_salario, count(*) as num_funcionarios from funcionarios group by departamento;

-- exercicio 07
select id_estoque, localizacao, count(*) as total from estoque group by id_estoque, localizacao;

-- exercicio 08
select metodo, sum(valor) as total, COUNT(*) as transacoes from pagamentos where estatus = 'aprovado' group by metodo;

select * from clientes;