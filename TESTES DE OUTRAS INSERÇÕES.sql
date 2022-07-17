-- TENTATIVA DE CADASTRO DE RESPONSÁVEIS PARA A MESMA RESIDÊNCIA
INSERT INTO residence (responsible, city, district, street, complement, house_number, house_size) values (10,"Inhangapi","Centro","Tv. Sandro Correa","APTO 17","964","g");
INSERT INTO residence (responsible, city, district, street, complement, house_number, house_size) values (9,"Inhangapi","Centro","Tv. Sandro Correa","APTO 17","964","g");

-- TENTATIVA DE AGENDAMENTO DE FAXINA COM A DIARISTA NO MESMO DIA
INSERT INTO service_schedule (date_service, id_cleaner, id_residence, service_done) values (20220621,1,1,0);
INSERT INTO service_schedule (date_service, id_cleaner, id_residence, service_done) values (20220621,1,7,0);