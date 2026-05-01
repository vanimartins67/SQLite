create database aula;
use aula;
-- drop database aula;

CREATE TABLE clientes (

    id INT PRIMARY KEY auto_increment,

    nome VARCHAR(100) not null,

    cidade VARCHAR(100)

);
 
CREATE TABLE pedidos (

    id INT PRIMARY KEY auto_increment,

    cliente_id INT not null,

    data_pedido DATE,

    FOREIGN KEY (cliente_id) REFERENCES clientes(id)

);
 
CREATE TABLE produtos (

    id INT PRIMARY KEY auto_increment,

    nome VARCHAR(100) not null,

    preco DECIMAL(10,2) not null

);
 
CREATE TABLE itens_pedido (

    id INT PRIMARY KEY auto_increment not null,

    pedido_id INT not null,

    produto_id INT not null,

    quantidade INT not null,

    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),

    FOREIGN KEY (produto_id) REFERENCES produtos(id)

);
 
CREATE TABLE vendedores (

    id INT PRIMARY KEY auto_increment,

    nome VARCHAR(100) not null

);
 
CREATE TABLE pedidos_vendedores (
    pedido_id int not null,

    vendedor_id int not null,

    PRIMARY KEY (pedido_id, vendedor_id),

    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),

    FOREIGN KEY (vendedor_id) REFERENCES vendedores(id)

);

INSERT INTO clientes VALUES
(1, 'Ana', 'Campo Grande'),
(2, 'Carlos', 'Dourados'),
(3, 'Mariana', 'Três Lagoas');
 
INSERT INTO produtos VALUES
(1, 'Notebook', 3500.00),
(2, 'Mouse', 50.00),
(3, 'Teclado', 120.00);
 
INSERT INTO vendedores VALUES
(1, 'João'),
(2, 'Fernanda');
 
INSERT INTO pedidos VALUES
(1, 1, '2025-03-10'),
(2, 2, '2025-03-11'),
(3, 1, '2025-03-12');
 
INSERT INTO itens_pedido VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 2, 3);
 
INSERT INTO pedidos_vendedores VALUES
(1, 1),
(2, 2),
(3, 1);

-- lista todos os pedidos realizados com nome do cliente, e a data
select c.nome as nome_cliente, p.id as pedido_realizado, p.data_pedido from clientes c join pedidos p on c.id = p.cliente_id;

-- liste todos os pedidos e os respectivos vendedores responsáveis
select p.id as pedido, v.nome as nome_vendedor
from pedidos p
join pedidos_vendedores pv on p.id = pv.pedido_id
join vendedores v on pv.vendedor_id = v.id;

-- busque o total gaato por cada cliente considerando todos os seus pedidos e produtos comprados
select c.nome as nome_cliente,
sum(pr.preco * ip.quantidade) as total_gasto from clientes c
join pedido p on c.id = p.cliente_id
join itens_pedido ip on p.id = ip.pedido_id
join produtos pr on ip.produto_id = pr.id
group by c.nome;
