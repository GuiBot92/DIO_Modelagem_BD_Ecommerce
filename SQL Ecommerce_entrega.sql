-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- Criando Tabela Cliente
create table client(
	idClient int auto_increment primary key,
	CEP char(8) not null,
    address varchar(100) not null,
    register_date date not null,
    client_type enum('PF','PJ') not null
);

-- Criando Tabela PF (Pessoa Física)
create table pessoaFisica(
	idPFClient int primary key,
    CPF char(11) not null unique,
    Pname varchar(45) not null,
    middle_name_initial varchar(3),
    Lname varchar(45) not null,
    birthday date,
    constraint fk_pf_client foreign key (idPFClient) references client(idClient) on delete cascade
);

-- Criando tabela PJ (Pessoa Jurídica)
create table pessoaJuridica(
	idPJClient int primary key,
    CNPJ char(14) not null unique,
    razao_social varchar(100) not null,
    Nfantasia varchar(200),
	constraint fk_pj_client foreign key (idPJClient) references client(idClient) on delete cascade
);

-- Criando Tabela Terceiro - Vendedor
create table third_party_supplier(
	idThirdPartySupplier int auto_increment primary key,
	CNPJ char(14) not null unique,
    razao_social varchar(100) not null,
    Nfantasia varchar(200) not null,
   	CEP char(8) not null
);

-- Criando Tabela Fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    CNPJ char(14) not null unique,
    razao_social varchar(100) not null,
    Nfantasia varchar(200)	
);

-- Criando Tabela Produto
create table product(
	idProduct int auto_increment primary key,
    category varchar (45) not null,
    Pdescription varchar(100) not null,
    price DECIMAL(10,2) not null	
);

-- Criando Tabela Pedido
create table orders(
	idOrders int auto_increment primary key,
	Ostatus enum('Em Andamento', 'Processando', 'Enviado', 'Entregue') not null default 'Processando', 
    Odescription varchar(100),
    shipping decimal(10,2) not null,
   	Oreturn boolean not null,
	OidClient int not null,
    constraint fk_order_client foreign key (OidClient) references client(idClient) on delete cascade
);

-- Criando Tabela Pagamentos
create table payments(
	idPayments int auto_increment primary key,
	Pstatus enum('Sob análise', 'Concluído', 'Rejeitado') not null default 'Sob Análise', 
    Pmethod enum('Crédito','Débito','Pix','Boleto') not null
);

-- Criando Tabela Estoque
create table stock(
	idStock int auto_increment primary key,
    Slocal varchar(45) not null,
    quantity int default 0
);

-- Criando Tabela Transportadora
create table carrier(
	idCarrier int auto_increment primary key,
	CNPJ char(14) not null unique,
    razao_social varchar(100) not null,
    Nfantasia varchar(200),
   	CEP char(8) not null,
    contactNumber varchar(20)
);

-- Criando Tabela Entrega
create table delivery(
	idDelivery int auto_increment primary key,
	Dstatus enum('Entregue', 'Em andamento') not null default 'Em andamento', 
    DShippingDate date not null,
    tracking varchar(45) not null unique,
   	Ddate date,
    DidCarrier int,
	constraint fk_delivery_carrier foreign key (DidCarrier) references Carrier (idCarrier) on delete set null
);

-- Criando Tabela Relacional Terceiro vs Produto
create table third_party_supplier_vs_product(
	idProduct int,
    idThirdPartySupplier int,
    primary Key (idProduct,idThirdPartySupplier),
    quantity int default 0,
    constraint fk_TSup_Product_S foreign key (idThirdPartySupplier) references third_party_supplier(idThirdPartySupplier) ON DELETE CASCADE,
    constraint fk_TSup_Product_P foreign key (idProduct) references product (idProduct) ON DELETE CASCADE
);

-- Criando Tabela Relacional Produto vs Fornecedor
CREATE TABLE supplier_vs_product (
    idProduct INT,
    idSupplier INT,
    PRIMARY KEY(idProduct, idSupplier),
    CONSTRAINT fk_Sup_Product_S FOREIGN KEY (idSupplier) REFERENCES supplier(idSupplier) ON DELETE CASCADE,
    CONSTRAINT fk_Sup_Product_P FOREIGN KEY (idProduct) REFERENCES product(idProduct) ON DELETE CASCADE
);

-- Criando Tabela Relacional Pedido vs Produto
CREATE TABLE orders_vs_product (
    idOrders INT,
    idProduct INT,
    PRIMARY KEY(idOrders, idProduct),
    quantity INT DEFAULT 0,
    CONSTRAINT fk_Orders_Product_O FOREIGN KEY (idOrders) REFERENCES orders(idOrders) ON DELETE CASCADE,
    CONSTRAINT fk_Orders_Product_P FOREIGN KEY (idProduct) REFERENCES product(idProduct) ON DELETE CASCADE
);

-- Criando Tabela Relacional Estoque vs Produto
CREATE TABLE stock_vs_product (
    idStock INT,
    idProduct INT,
    PRIMARY KEY (idStock, idProduct),
    quantity INT DEFAULT 0,
    CONSTRAINT fk_Stock_Product_S FOREIGN KEY (idStock) REFERENCES stock(idStock) ON DELETE CASCADE,
    CONSTRAINT fk_Stock_Product_P FOREIGN KEY (idProduct) REFERENCES product(idProduct) ON DELETE CASCADE
);

-- Criando Tabela Relacional Pagamento vs Pedido
CREATE TABLE payment_vs_orders (
    idOrders INT,
    idPayment INT,
    PRIMARY KEY(idOrders ,idPayment),
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_Payment_Orders_O FOREIGN KEY (idOrders) REFERENCES orders(idOrders) ON DELETE CASCADE,
    CONSTRAINT fk_Payment_Orders_P FOREIGN KEY (idPayment) REFERENCES payments(idPayments) ON DELETE CASCADE
);

-- Criando Tabela Relacional Pedido vs Entrega
create table delivery_vs_orders(
	idOrders int,
    idDelivery int,
    primary key (idOrders, idDelivery),
    deliveryAddress varchar(100) not null,
    CEP char(8) not null,
    constraint fk_Delivery_Orders_O foreign key (idOrders) references orders(idOrders) ON DELETE CASCADE,
    constraint fk_Delivery_Orders_D foreign key (idDelivery) references delivery(idDelivery)ON DELETE CASCADE
);

--------------------------------------



-- Inserindo Clientes
INSERT INTO client (CEP, address, register_date, client_type) VALUES
('01001000', 'Rua das Flores, 123', '2024-01-10', 'PF'),
('02002000', 'Av. Paulista, 1500', '2024-02-15', 'PF'),
('03003000', 'Rua da Liberdade, 75', '2024-03-20', 'PJ'),
('04004000', 'Av. Brasil, 500', '2024-04-05', 'PF'),
('05005000', 'Rua Augusta, 250', '2024-05-12', 'PJ');

-- Inserindo Pessoa Física
INSERT INTO pessoaFisica (idPFClient, CPF, Pname, middle_name_initial, Lname, birthday) VALUES
(1, '12345678901', 'Carlos', 'A', 'Silva', '1990-05-12'),
(2, '98765432109', 'Mariana', 'B', 'Oliveira', '1985-07-23'),
(4, '45678912300', 'Pedro', 'C', 'Santos', '1992-11-30');

-- Inserindo Pessoa Jurídica
INSERT INTO pessoaJuridica (idPJClient, CNPJ, razao_social, Nfantasia) VALUES
(3, '11223344556677', 'Tech Solutions LTDA', 'TechSol'),
(5, '99887766554433', 'Comercial ABC', 'ABC Vendas');

-- Inserindo Terceiros - Vendedores
INSERT INTO third_party_supplier (CNPJ, razao_social, Nfantasia, CEP) VALUES
('11112222333344', 'Loja XPTO', 'XPTO Eletrônicos', '06006000'),
('55556666777788', 'Gadget Store', 'GStore', '07007000'),
('99990000111122', 'MegaShop', 'Mega Compras', '08008000');

-- Inserindo Fornecedores
INSERT INTO supplier (CNPJ, razao_social, Nfantasia) VALUES
('11110000222233', 'Fornecedor Alpha', 'Alpha Distribuidora'),
('44445555666677', 'Global Supply', 'GSupply'),
('88889999000011', 'Tech Parts', 'TechParts Fornecimento');

-- Inserindo Produtos
INSERT INTO product (category, Pdescription, price) VALUES
('Eletrônicos', 'Smartphone Android 128GB', 2999.99),
('Eletrônicos', 'Notebook Gamer i7', 7599.90),
('Casa', 'Aspirador de Pó 2000W', 399.90),
('Moda', 'Jaqueta de Couro Preta', 499.90),
('Moda', 'Tênis Esportivo Running', 349.90);

-- Inserindo Pedidos
INSERT INTO orders (Ostatus, Odescription, shipping, Oreturn, OidClient) VALUES
('Em Andamento', 'Pedido de celular e jaqueta', 15.00, false, 1),
('Processando', 'Pedido de notebook', 25.00, false, 2),
('Enviado', 'Aspirador de pó e tênis', 20.00, false, 3),
('Entregue', 'Pedido de jaqueta', 18.00, false, 4),
('Entregue', 'Notebook e smartphone', 30.00, false, 5);

-- Inserindo Pagamentos
INSERT INTO payments (Pstatus, Pmethod) VALUES
('Concluído', 'Crédito'),
('Concluído', 'Pix'),
('Sob análise', 'Boleto'),
('Rejeitado', 'Débito'),
('Concluído', 'Crédito');

-- Inserindo Estoque
INSERT INTO stock (Slocal, quantity) VALUES
('Galpão Norte', 100),
('Galpão Sul', 200),
('Centro de Distribuição Leste', 150),
('Depósito Oeste', 180),
('Armazém Central', 300);

-- Inserindo Transportadoras
INSERT INTO carrier (CNPJ, razao_social, Nfantasia, CEP, contactNumber) VALUES
('12345678000199', 'Translog', 'Translog Entregas', '09999000', '11999998888'),
('22334455000188', 'Rápido Express', 'RapEx', '08888000', '11888887777'),
('33445566000177', 'FreteMax', 'FreteMax Logística', '07777000', '11777776666');

-- Inserindo Entregas
INSERT INTO delivery (Dstatus, DShippingDate, tracking, Ddate, DidCarrier) VALUES
('Entregue', '2024-06-01', 'TRK12345', '2024-06-05', 1),
('Em andamento', '2024-06-10', 'TRK67890', NULL, 2),
('Entregue', '2024-06-03', 'TRK11223', '2024-06-06', 3);

-- Relacionando Terceiros com Produtos
INSERT INTO third_party_supplier_vs_product (idProduct, idThirdPartySupplier, quantity) VALUES
(1, 1, 50),
(2, 2, 30),
(3, 3, 20);

-- Relacionando Produtos com Fornecedores
INSERT INTO supplier_vs_product (idProduct, idSupplier) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Relacionando Pedidos com Produtos
INSERT INTO orders_vs_product (idOrders, idProduct, quantity) VALUES
(1, 1, 1),
(1, 4, 1),
(2, 2, 1),
(3, 3, 1),
(3, 5, 1),
(4, 4, 1),
(5, 2, 1),
(5, 1, 1);

-- Relacionando Estoque com Produtos
INSERT INTO stock_vs_product (idStock, idProduct, quantity) VALUES
(1, 1, 20),
(2, 2, 30),
(3, 3, 40),
(4, 4, 50),
(5, 5, 60);

-- Relacionando Pagamento com Pedido
INSERT INTO payment_vs_orders (idOrders, idPayment, price) VALUES
(1, 1, 3514.90),
(2, 2, 7599.90),
(3, 3, 719.80),
(4, 4, 499.90),
(5, 5, 10599.89);

-- Relacionando Pedido com Entrega
INSERT INTO delivery_vs_orders (idOrders, idDelivery, deliveryAddress, CEP) VALUES
(1, 1, 'Rua das Flores, 123', '01001000'),
(2, 2, 'Av. Paulista, 1500', '02002000'),
(3, 3, 'Rua da Liberdade, 75', '03003000');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Calculando o valor total de cada pedido (produto x quantidade + frete).
SELECT 
    o.idOrders,
    SUM(p.price * op.quantity) + o.shipping AS total_order_value
FROM orders o
JOIN orders_vs_product op ON o.idOrders = op.idOrders
JOIN product p ON op.idProduct = p.idProduct
GROUP BY o.idOrders;


-- Lista dos fornecedores que fornecem mais de um produto.
SELECT 
    s.razao_social,
    COUNT(sp.idProduct) AS total_products
FROM supplier s
JOIN supplier_vs_product sp ON s.idSupplier = sp.idSupplier
GROUP BY s.razao_social
HAVING COUNT(sp.idProduct) > 1;


-- Quantos pedidos foram feitos por cada cliente?
SELECT 
    c.idClient, 
    COUNT(o.idOrders) AS total_orders
FROM client c
LEFT JOIN orders o ON c.idClient = o.OidClient
GROUP BY c.idClient;


-- Algum vendedor também é fornecedor?
SELECT 
    t.razao_social AS vendedor, 
    s.razao_social AS fornecedor
FROM third_party_supplier t
JOIN supplier s ON t.CNPJ = s.CNPJ;

-- Relação de produtos, fornecedores e estoques.
SELECT 
    p.Pdescription AS produto,
    s.razao_social AS fornecedor,
    st.Slocal AS estoque,
    stp.quantity AS quantidade_estoque
FROM product p
JOIN supplier_vs_product sp ON p.idProduct = sp.idProduct
JOIN supplier s ON sp.idSupplier = s.idSupplier
JOIN stock_vs_product stp ON p.idProduct = stp.idProduct
JOIN stock st ON stp.idStock = st.idStock;

-- Relação de nomes dos fornecedores e nomes dos produtos fornecidos.
SELECT 
    s.razao_social AS fornecedor,
    p.Pdescription AS produto
FROM supplier s
JOIN supplier_vs_product sp ON s.idSupplier = sp.idSupplier
JOIN product p ON sp.idProduct = p.idProduct;

-- Quais são os pedidos que tiveram pagamento rejeitado?
SELECT 
    o.idOrders, 
    o.Odescription, 
    p.Pstatus AS status_pagamento
FROM orders o
JOIN payment_vs_orders po ON o.idOrders = po.idOrders
JOIN payments p ON po.idPayment = p.idPayments
WHERE p.Pstatus = 'Rejeitado';

-- Quais clientes fizeram pedidos acima de R$5000?
SELECT 
    c.idClient, 
    SUM(p.price * op.quantity) + SUM(o.shipping) AS total_gasto
FROM client c
JOIN orders o ON c.idClient = o.OidClient
JOIN orders_vs_product op ON o.idOrders = op.idOrders
JOIN product p ON op.idProduct = p.idProduct
GROUP BY c.idClient
HAVING SUM(p.price * op.quantity) + SUM(o.shipping) > 5000;

