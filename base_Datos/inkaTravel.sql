-- -- Incluyendo libreria para generar un ID unico randomizado
CREATE EXTENSION pgcrypto;
--Creación de tablas para la base de datos relacional
CREATE TABLE clients(
	idClient UUID DEFAULT gen_random_uuid(),
	name VARCHAR(100),
	email VARCHAR(100),
	password VARCHAR(100),
	type VARCHAR(15),
	PRIMARY KEY(idClient)
);
CREATE TABLE tourists(
	idTourist UUID DEFAULT gen_random_uuid(),
	idClient UUID REFERENCES clients(idclient) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(idTourist)
);
CREATE TABLE affiliates(
	idAffiliate UUID DEFAULT gen_random_uuid(),
	ruc VARCHAR(11),
	idClient UUID REFERENCES clients(idclient) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (idAffiliate)
);
CREATE TABLE transports(
	idTransport UUID DEFAULT gen_random_uuid(),
	nameTransport VARCHAR(100),
	price INT,
	placeDeparture VARCHAR(100),
	placeArrival VARCHAR(100),
	numSeats INT,
	urlImageTransport TEXT,
	description TEXT,
	idAffiliate UUID REFERENCES affiliates(idAffiliate) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (idTransport)
);
CREATE TABLE accommodations(
	idaccommodation UUID DEFAULT gen_random_uuid(),
	nameAccommodation VARCHAR(100),
	price INT,
	ubication VARCHAR (100),
	capacity INT,
	urlImageAccommodation TEXT,
	description TEXT,
	idAffiliate UUID REFERENCES affiliates(idAffiliate) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (idAccommodation)
);

CREATE TABLE travelPackages(
	idTravelPackage UUID DEFAULT gen_random_uuid(),
	arrayAccommodations JSON,
	arrayTransports JSON,
	ubication VARCHAR(20),
	price INT,
	type VARCHAR(50),
	idAffiliate UUID REFERENCES affiliates(idAffiliate) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY(idTravelPackage)
);
CREATE TABLE buys(
	idBuy UUID DEFAULT gen_random_uuid(),
	dateBuy DATE,
	numPersons INT,
	price INT,
	dateStart DATE,
	dateEnd DATE,
	idTourist UUID REFERENCES tourists(idTourist) ON UPDATE CASCADE ON DELETE CASCADE,
	idTravelPackage UUID REFERENCES travelPackages(idTravelPackage) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (idBuy)
);
--
--mostrar tabla <nombre_tabla>:
select * from clients
select * from tourists
select * from affiliates
select * from transports
select * from accommodations
select * from buys
select * from travelPackages

SELECT * FROM transports WHERE idaffiliate = '89f4f1af-ba90-4dfd-b827-f0860d329b03'
--
--Ejemplo de query para insertar datos de una tabla a otra:
--INSERT INTO tourists (idclient) SELECT idclient FROM clients WHERE type='turista' AND idclient NOT IN (SELECT idclient FROM tourists)
--
--INSERT INTO affiliates (ruc, idclient) SELECT 'ruc123',idclient FROM clients WHERE type='afiliado' AND idclient NOT IN (SELECT idclient FROM affiliates)
--
-- Ejemplo de actualización de cliente
--UPDATE clients SET name = 'prueba previa', email ='ejm.prev@email.com', password='contra123' WHERE idclient=5

--Ejemplo de borrado en cascada de un cliente:
--DELETE FROM clients WHERE idclient = 'f29f26d4-c729-42e9-86f7-564ef06194c8';
--
-- Modificar clave foranea para poder hacer un borrado en cascada desde la tabla cliente
-----------------------------------
--ALTER TABLE buys ADD FOREIGN KEY(idTravelPackage)
--REFERENCES travelPackages(idTravelPackage) on update cascade ON DELETE CASCADE;
-----------------------------------
-- Modificar primary key para que sea de tipo UUID:
-- Alterando columna de idclient:
--ALTER TABLE clients ALTER COLUMN idclient SET DEFAULT gen_random_uuid();
--ALTER TABLE "tourists" ALTER COLUMN "idtourist" SET DEFAULT gen_random_uuid();
--ALTER TABLE affiliates ALTER COLUMN idAffiliate SET DEFAULT gen_random_uuid();
--ALTER TABLE transports ALTER COLUMN idTransport SET DEFAULT gen_random_uuid();
--ALTER TABLE accommodations ALTER COLUMN idAccommodation SET DEFAULT gen_random_uuid();
--ALTER TABLE touristPlaces ALTER COLUMN idTouristPlace SET DEFAULT gen_random_uuid();
--ALTER TABLE buys ALTER COLUMN idBuy SET DEFAULT gen_random_uuid();
--ALTER TABLE travelPackages ALTER COLUMN idTravelPackage SET DEFAULT gen_random_uuid();
--
--
--ALTER TABLE travelPackages DROP COLUMN description
--ALTER TABLE travelPackages RENAME COLUMN belong TO ubication
--Testeo previo:
--borrar tablas:
--drop table clients CASCADE;
--drop table tourists CASCADE;
--drop table affiliates CASCADE;
--drop table transports CASCADE;
--drop table accommodations CASCADE;
--drop table touristPlaces CASCADE;
--drop table buys CASCADE;
--drop table travelPackages CASCADE;