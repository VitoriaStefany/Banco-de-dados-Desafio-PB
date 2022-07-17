CREATE DATABASE Service_of_cleaner;

USE Service_of_cleaner;

-- TABELA DE CADASTRO DE FAXINEIRAS
CREATE TABLE cleaner (
	id_cleaner SMALLINT AUTO_INCREMENT NOT NULL, 
	cleaner_name VARCHAR(50) NOT NULL, 
	cpf VARCHAR(11) NOT NULL UNIQUE,
	PRIMARY KEY (id_cleaner)
);

-- TABELA DE CADASTRO DE CLIENTES
CREATE TABLE tbclient (
	id_client SMALLINT AUTO_INCREMENT NOT NULL,
	client_name VARCHAR(50) NOT NULL,
	cpf VARCHAR (11) NOT NULL UNIQUE,
	PRIMARY KEY (id_client)
);

-- TABELA DE CADASTRO DE RESIDÊNCIAS
CREATE TABLE residence (
	responsible SMALLINT NOT NULL,
	id_residence SMALLINT AUTO_INCREMENT NOT NULL,
	city VARCHAR(50) NOT NULL,
	district VARCHAR (15) NOT NULL,
	street VARCHAR (50) NOT NULL,
	complement VARCHAR (50),
	house_number VARCHAR (5) NOT NULL,
	house_size VARCHAR (10) NOT NULL,
	PRIMARY KEY (id_residence),
	FOREIGN KEY (responsible) REFERENCES tbclient(id_client),
    UNIQUE KEY verification (city, district, house_number),
    CHECK (house_size = "p" or house_size = "m" or house_size = "g")
);

-- TABELA DE AGENDAMENTO DE SERVIÇO
CREATE TABLE service_schedule (
	order_service SMALLINT AUTO_INCREMENT NOT NULL,
	date_service DATE NOT NULL,
	id_cleaner SMALLINT NOT NULL,
	id_residence SMALLINT NOT NULL,
    service_done bit(1) NOT NULL,
	PRIMARY KEY (order_service),
	FOREIGN KEY (id_cleaner) REFERENCES cleaner(id_cleaner),
	FOREIGN KEY (id_residence) REFERENCES residence(id_residence),
    UNIQUE KEY viability (id_cleaner, date_Service)
);

-- TABELA DE AVALIAÇÃO DO CLIENTE
CREATE TABLE availability (
    order_service SMALLINT NOT NULL,
	stars SMALLINT,
	feedback VARCHAR(1000),
    FOREIGN KEY (order_service) REFERENCES service_schedule(order_service),
	CHECK (stars >= 0 AND stars <=5)
);

-- VIEW PARA RELATÓRIO DE PAGAMENTOS (SOMENTE AGENDAMENTOS DE SERVIÇOS REALIZADOS OU VENCIDOS)
CREATE VIEW `vw_payment` AS
	SELECT order_service, date_service, service_done, cleaner_name,
    CASE
		WHEN service_done = (true) AND residence.house_size = "g" THEN (200.00) 
		WHEN service_done = (true) AND residence.house_size = "m" THEN (150.00)
        WHEN service_done = (true) AND residence.house_size = "p" THEN (100.00)
	ELSE 0.00
	END AS Payment
FROM service_schedule service_schedule 
INNER JOIN residence residence ON service_Schedule.id_residence = residence.id_residence
INNER JOIN cleaner cleaner ON cleaner.id_cleaner = service_schedule.id_cleaner where date_service < current_date()
;