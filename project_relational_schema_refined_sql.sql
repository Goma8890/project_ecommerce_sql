-- E-commerce_Refined Data Base Scenario
-- drop database ecommerce_refined;
create database ecommerce_refined;

use ecommerce_refined;

-- Create clients table

create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    MidName char(3),
    Lname varchar(20),
    CPF char(11) not null,
	Address varchar(45),
    constraint unique_cpf_client unique (CPF)
);
alter table clients auto_increment=1;

-- Create products table
-- size = product dimension
create table products(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum('Electronics', 'Clothing', 'Toys', 'Food', 'Furniture', 'Books') not null,
	evaluation float default 0,
    size varchar(10)
);

-- Create payments table
create table payments(
	idClient int,
    idPayment int,
    typePayment enum('ticket', 'card', 'two cards', 'cash'),
    limitAvailable float,
    primary key(idClient, idPayment)
);

-- Create requests table
-- drop table request;
create table requests(
	idRequest int auto_increment primary key,
    idRequestClient int,
    RequestStatus enum('Cancelled', 'Confirmed', 'Processing') default 'Processing',
    RequestDescription varchar(255),
    RequestShipping float default 10,
    paymentCash boolean default false,
    constraint fk_request_client foreign key (idRequestClient) references clients(idClient)
			on update cascade
);
alter table requests auto_increment=1;

-- Create stocks table
create table stocks(
	idStock int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- Create suppliers table
create table suppliers(
	idSupplier int auto_increment primary key,
    socialReason varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- Create sellers table
create table sellers(
	idSeller int auto_increment primary key,
    socialReason varchar(255) not null,
    AbsName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- Create product Seller
create table proSeller(
	idPseller int,
    idProduct int,
    proQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_pro_seller foreign key (idPseller) references sellers(idSeller),
    constraint fk_pro_product foreign key (idProduct) references products(idProduct)
);
alter table proSeller auto_increment=1;

-- Create product ordere table
create table proOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Available', 'No stock') default 'Available',
    primary key (idPOproduct, idPOorder),
    constraint fk_pro_order_seller foreign key (idPOproduct) references products(idProduct),
    constraint fk_pro_Order_product foreign key (idPOorder) references requests(idRequest)
);
alter table proOrder auto_increment=1;

-- Create storage location table
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references products(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references stocks(idStock)
);
alter table storageLocation auto_increment=1;

-- Create product supplier table
create table proSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references suppliers(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references products(idProduct)
);
desc proSupplier;

show tables;

show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce_refined';