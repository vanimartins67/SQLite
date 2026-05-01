create database aula_17_03;
use aula_17_03;

create table clientes(
    id_cliente int primary key not null auto_increment,
    nome varchar(100) not null,
    email varchar(100) not null
);

create table pedidos(
    id_pedidos int primary key not null auto_increment,
    id_cliente int not null,
    produto varchar(100) not null,
    foreign key (id_cliente) references clientes(id_cliente)
);

insert into clientes(nome, email) values 
("João", "joao@icloud.com"),
("Maria", "maria@email.com"), 
("Carlos", "atiradorcs.com");

insert into pedidos(id_cliente, produto) values 
(1, "produto A"),
(1, "produto B"), 
(2, "produto C");

select clientes.id_cliente, clientes.nome, pedidos.produto
FROM clientes
left join pedidos on clientes.id_cliente = pedidos.id_cliente;

select clientes.id_cliente, clientes.nome, pedidos.produto
FROM clientes
right join pedidos on clientes.id_cliente = pedidos.id_cliente;

select clientes.nome, pedidos.produto
from clientes
cross join pedidos;




