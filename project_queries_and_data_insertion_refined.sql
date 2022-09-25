-- queries and data inserion
use ecommerce_refined;

show tables;
-- idClient, Fname, MidName, Lname, CPF, Address
insert into Clients (Fname, MidName, Lname, CPF, Address)
		values('Antonio', 'M', 'Goma', 123456789, 'Rua Rocha, Gaia - Porto'),
			  ('Manuel', 'Z', 'Morais', 987654321, 'Rua Rocha, Gaia - Porto'),
              ('Dario', 'J', 'Goma', 45678913, 'Avenida Alemeda Vinha 1009, Centro - Criucima'),
              ('Arnicio', 'M', 'Goma', 789123456, '35 Bairro Znago, Viana - Luanda'),
              ('Zaki', 'M', 'Bado', 98745631, 'Avenida Koller 19, Geelsysie - Windhoek'),
              ('Marcelina', 'E', 'Goma', 654789123, '102 Bairro Zango, Viana - Luanda'),
              ('Johnny', 'N', 'Babutana', 521780923, '102 Bairro Zango, Viana - Luanda'),
              ('Leornard', 'N', 'vRIES', 953789073, '102 Bairro Zango, Viana - Luanda');
              
-- idProduct, Pname, classification_kids boolean, category('Electronic', 'Clothing', 'Toys', 'Food', 'Furniture', 'Books'), Evaluation, Size
insert into products (Pname, classification_kids, category, evaluation, size) values 
							   ('phones', false, 'Electronics', '4', null),
                               ('Barbie', true, 'Toys', '3', null),
                               ('I_Robot', false, 'Books', '2', null),
                               ('BoyCarters', true, 'Clothing', '5', null),
                               ('Microphone', false, 'Electronics', '4', null),
                               ('Sofa', false, 'Furniture', '3', '3x57x80'),
                               ('Rice', false, 'Food', '3', null),
                               ('Rich dad', false, 'Books', '2', null),
                               ('Firestick', false, 'Electronics', '3', null);
select * from clients;
select * from products;
-- idRequest, idRequestClient, RequestStatus, RequestDescription, RequestShipping, paymentCash

 delete from requests where idRequestClient in (1, 2, 3, 4, 5);
insert into requests (idRequestClient, RequestStatus, RequestDescription, RequestShipping, paymentCash) values 
							   (1, default, 'buy using app', null, 1),
                               (2, default, 'buy using app', 50, 0),
                               (3, 'Confirmed', null, null, 1),
                               (4, default, 'buy using website', 150, 0);
                               
-- idPOproduct, idPOorder, poQuantity, poStatus
select * from requests;
insert into proOrder (idPOproduct, idPOorder, poQuantity, poStatus) values 
						 (1,5,2,null),
                         (2,5,2,null),
                         (3,6,1,null);

-- storageLocation, quantity
insert into stocks (storageLocation, quantity) values 
							   ('Porto', 1000),
                               ('Criucima', 500),
                               ('Windhoek', 10),
                               ('Windhoek', 60),
                               ('Luanda', 100),
                               ('Luanda', 10),
                               ('Porto', 30);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values 
							   (1, 2, 'RJ'),
                               (2, 6, 'PT'),
                               (3, 5, 'Wk'),
                               (4, 3, 'LD');

-- idSupplier, socialReason, CNPJ, contact
insert into suppliers (socialReason, CNPJ, contact) values 
							   ('Goma e filhos', 123456789123456, '21985474'),
                               ('Electronics Silva', 854519649143457, '21985484'),
                               ('Bookshop Nafina', 0543515199143457, '20432484'),
                               ('Restaurante Nafina', 129519649143897, '21968943'),
                               ('Electronics Nana', 934567893934695, '21975474');
		
select * from suppliers;
-- idPsSupplier, idPsProduct, quantity
insert into proSupplier (idPsSupplier, idPsProduct, quantity) values 
							   (1, 1, 500),
                               (1, 2, 400),
                               (2, 4, 633),
                               (3, 3, 5),
                               (2, 5, 10);
  
-- idSeller, socialReason, AbsName, CNPJ, CPF, location, contact
insert into sellers (socialReason, AbsName, CNPJ, CPF, location, contact) values 
							   ('Tech electronics', null, 123456789456321, null, 'Riao de Janeiro', 219946287),
                               ('Boutique Durgas', null, null, 123456783, 'Porto', 219567895),
                               ('Kids World', null, 456789123654485, null, 'Luanda', 1198657484),
                               ('Book Store', null, 226745623654485, null, 'Criucima', 1198657484),
                               ('Sports shop', null, 159789063654485, null, 'Windhoek', 1198341484);

select * from sellers;
-- idPseller, idProduct, proQuantity
insert into proSeller (idPseller, idProduct, proQuantity) values 
							   (1, 6, 80),
                               (2, 5, 50),
                               (3, 4, 90),
                               (4, 7, 10);
select * from proSeller;

select count(*) from clients;
select * from clients c, requests o where c.idClient = idRequestClient;

select Fname, Lname, idRequest, RequestStatus from clients c, requests o where c.idClient = idRequestClient;
select concat(Fname, ' ' , Lname) as Clients, idRequest as Request, RequestStatus as RStatus from clients c, requests o where c.idClient = idRequestClient;

insert into requests (idRequestClient, RequestStatus, RequestDescription, RequestShipping, paymentCash) values 
							   (2, default, 'buy using app', null, 1);

select count(*) from clients c, requests o 
					where c.idClient = idRequestClient
					group by idRequest;
select * from requests;     

-- Recuperacao de pedido com produto associado
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
					inner join requests o on c.idClient = o.idRequestClient
					inner join proOrder p on p.idPOorder = o.idRequest
		group by idClient;
        
-- Recuperando quantos pedidos foram realizados pelos clientes              
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
					inner join requests o on c.idClient = o.idRequestClient
		group by idClient;
        
-- Using Select Statement
select * from clients;
select count(*) from clients;

-- Filter with where Statement
select count(*) from clients
	where Lname = 'Goma';
    
select * from clients
	where Lname = 'Goma';

-- Creating expressions to generate atributes
select * from products
	where 'idProduct Category'= 'idProduct';

-- Using Order BY
select Pname, category, count(*)
	from products
    where category = 'Electronics'
    group by Pname, category;

-- Using Having Statement
select count(*) as total
	from clients
    group by idClient
    having total >= 1;

-- Creating conjunctions
select concat(Fname, ' ', Lname) as Full_name, Address as Location from clients 
	inner join requests on RequestStatus = 'Processing'
    inner join suppliers on contact = '21985474'
    order by Lname
desc;