-- Assignment {The .sql file should including a LEFT JOIN query
--that will display the profession, zip_code(postal_code, city and province),
-- status, interests and seeking.}

---------------------------------------------------------------------------------------------------------------------------------	
--CREATE TABLES - [ my_contacts | proffesion | zip_code | status | interests | seeking | contact_interest |   contact_interest ]
---------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE my_contacts (
	contact_id bigserial NOT NULL,
	first_name varchar(20) NOT NULL,
	last_name varchar(20) NOT NULL,
	phone varchar(10) NOT NULL,
	email varchar(40) NOT NULL,
	gender varchar(1) NOT NULL,
	birthday date NOT NULL,
	prof_id integer REFERENCES proffesion (prof_id),
	zip_code varchar REFERENCES zip_code (zip_code),
	status_id integer REFERENCES status (status_id),
	CONSTRAINT contact_id_key PRIMARY KEY (contact_id),
	CONSTRAINT phone_unique UNIQUE (phone),
	CONSTRAINT email_unique UNIQUE (email)
);

CREATE TABLE proffesion (
	prof_id bigserial,
	proffesion varchar(20),
	CONSTRAINT prof_id_key PRIMARY KEY (prof_id),
	CONSTRAINT proffesion_unique UNIQUE (proffesion)
);

CREATE TABLE zip_code (
	zip_code varchar(4) CHECK (LENGTH (zip_code) = 4),
	city varchar(20),
	province varchar(20),
	CONSTRAINT zip_code_key PRIMARY KEY (zip_code),
	CONSTRAINT city_unique UNIQUE (city)
);

CREATE TABLE status (
	status_id bigserial NOT NULL,
	status varchar(20) NOT NULL,
	CONSTRAINT status_key PRIMARY KEY (status_id),
	CONSTRAINT status_unique UNIQUE (status)
);

CREATE TABLE interests (
	interest_id bigserial NOT NULL,
	interest varchar(20) NOT NULL,
	CONSTRAINT interest_key PRIMARY KEY (interest_id),
	CONSTRAINT interest_unique UNIQUE (interest)
);

CREATE TABLE seeking (
	seeking_id bigserial NOT NULL,
	seeking varchar(1) NOT NULL,
	CONSTRAINT seeking_key PRIMARY KEY (seeking_id),
	CONSTRAINT seeking_unique UNIQUE (seeking)
);

CREATE TABLE contact_interest (
	contact_id integer REFERENCES my_contacts (contact_id),
	interest_id integer REFERENCES interests (interest_id)
);

CREATE TABLE contact_seeking (
	contact_id integer REFERENCES my_contacts (contact_id),
	seeking_id integer REFERENCES seeking (seeking_id)
);

SELECT pg_get_serial_sequence('my_contacts', 'contact_id');

ALTER SEQUENCE "my_contacts_contact_id_seq" START WITH 1;

SELECT * FROM my_contacts

---------------------------------------------------------------------------------------------------------------------------------
--INSERT INTO TABLES									
---------------------------------------------------------------------------------------------------------------------------------
																			--		24			18		9
INSERT INTO my_contacts (first_name, last_name, phone, birthday, gender, email, prof_id, zip_code, status_id)
VALUES
	('Riley', 'Hayes', '0843871480', '1988-09-06', 'F', 'Makenzie@ashlee.name', 2, '7600', 2),						--1
	('Shayna', 'Toy', '0834197818', '2001-01-05', 'F', 'Kadin.Gerhold@tabitha.tv', 4, '8001', 1),
	('Mandy', 'Luettgen', '0822633299' , '1992-04-27', 'F', 'Teagan@enrico.co.uk', 6, '8301', 3),
	('Charley', 'Goodwin' , '0847444551', '2000-10-08', 'M', 'Lane_Abbott@wilfredo.org', 8, '1201', 2),
	('Priscilla' ,'Welch', '0851519651' , '2002-04-28', 'F' , 'Pink@norwood.name', 10, '0699', 4),								--5		
	
	('Jaqueline', 'Johnston', '0857836128', '2001-03-02', 'F', 'Daniella.Hessel@marion.biz', 12, '9301', 5),
	('Cullen', 'Thiel' , '0827300144', '2018-12-01', 'M', 'Jordane.Robel@mariano.biz', 14, '5201', 2),
	('Waylon', 'Dickens','0832356650','2003-02-17', 'M', 'Royce@gaston.us', 16, '4001', 6),
	('Maiya', 'Gutkowski', '0855891463', '1982-08-05', 'F', 'Alexa@dortha.tv', 18, '0250', 7),
	('Zander', 'Goldner', '0841579104', '1983-04-24', 'M' , 'Arvid@samara.org', 20, '0002', 2),										--10
	
	('Lacey', 'Ziemann', '0822995353', '1982-07-05', 'F', 'Jakayla.Zieme@will.biz', 22, '7600', 8),
	('Sister', 'Herzog', '0835933047', '1984-02-14', 'F', 'Jay_Bradtke@delphia.name', 24, '8801', 9),
	('Maria', 'Mills', '0858825382', '1997-12-23', 'F', 'Sherman_Greenholt@houston.us', 1, '1120', 2),
	('Viola', 'Mueller', '0824438180', '2001-02-11', 'F', 'Alvina_Strosin@alessandro.net',3 , '0850', 9),
	('Kyler', 'Daniel', '0855486100', '2016-12-31', 'M', 'Earl.Rutherford@ebba.name', 5, '9585', 8),						--15
	
	('Maci', 'Muller', '0857786606', '1996-03-10','F', 'Cory.Hilll@leola.net', 7, '6024', 2),
	('Toby', 'Stokes', '0841881410', '1982-06-01', 'M', 'Bruce@cleve.info', 9, '4275', 7),
	('Raymundo', 'Armstrong', '0835997808', '2002-02-27', 'M', 'Hope@pink.biz', 11, '2571', 6),
	('Casandra', 'Hagenes', '0845492473', '2001-12-28', 'F', 'Lindsay_Zulauf@russell.net', 13, '2001', 2),
	('Adelia', 'Howe', '0821738422', '1999-09-21', 'F', 'Garnett@sidney.ca', 15, '9301', 5);										--20
	
INSERT INTO proffesion (proffesion)
VALUES
	('Database administrator'),
	('Electrician'),
	('IT Manager'),
	('Librarian'),
	('Physician'),
	('Computer Systems Analyst'),
	('Speech-Language Pathologist'),
	('Referee'),
	('Anthropologist'),
	('Interpreter & Translator'),
	('Cashier'),
	('Medical Assistant'),
	('Drafter'),
	('Economist'),
	('Electrical Engineer'),
	('Market Research Analyst'),
	('Human Resources Assistant'),
	('Dental Hygienist'),
	('Desktop publisher'),
	('Physical Therapist'),
	('Educator'),
	('Veterinarian'),
	('Preschool Teacher'),
	('Auto Mechanic'); --24
	
INSERT INTO zip_code (zip_code, city, province)
VALUES
	('0002','Pretoria','Gauteng'),			--1
	('2001','Johannesburg','Gauteng'),		--2
	('0250','Brits','North West'),			--3
	('2571','Klerksdorp','North West'),		--4
	('4001','Durban','KwaZulu-Natal'),		--5
	('4275','Margate','KwaZulu-Natal'),		--6
	('5201','East London','Eastern Cape'),	--7
	('6024','Gqeberha','Eastern Cape'),		--8
	('9301','Bloemfontein','Free State'),	--9
	('9585','Parys','Free State'),			--10
	('0699','Polokwane','Limpopo'),			--11
	('0850','Tzaneen','Limpopo'),			--12
	('1201','Mbombela','Mpumalanga'),		--13
	('1120','Lydenburg','Mpumalanga'),		--14
	('8301','Kimberley','Northern Cape'),	--15
	('8801','Upington','Northern Cape'),	--16
	('8001','Cape Town','Western Cape'),	--17
	('7600','Stellenbosch','Western Cape'); --18
	
INSERT INTO status (status)
VALUES
	('Not Saying'),
	('Single'),
	('Married'),
	('Divorced'),
	('Engaged'),
	('In Relationship'),
	('Complicated'),
	('Widowed'),
	('Open relationship');--9
	
INSERT INTO interests (interest)
VALUES
	('Music'),
	('Gaming'),
	('Travel'),
	('Art'),
	('Nature'),
	('Social causes'),
	('Foreign languages'),
	('History'),
	('Theater'); --9
	
INSERT INTO seeking (seeking)
VALUES
	('M'),
	('F'),
	('O'),
	('B');

INSERT INTO contact_interest (contact_id, interest_id)
VALUES
	('1', '1'),
	('2', '9'),
	('3', '6'),
	('4', '1'),
	('5', '3'),
	('6', '4'),
	('7', '8'),
	('8', '7'),
	('9', '9'),
	('10', '4'),
	('11', '1'),
	('12', '3'),
	('13', '6'),
	('14', '8'),
	('15', '5'),
	('16', '6'),
	('17', '1'),
	('18', '9'),
	('19', '8'),
	('20', '5'),
	
	('1', '2'),
	('2', '8'),
	('3', '5'),
	('4', '5'),
	('5', '5'),
	('6', '5'),
	('7', '5'),
	('8', '5'),
	('9', '6'),
	('10', '8'),
	('11', '6'),
	('12', '4'),
	('13', '2'),
	('14', '4'),
	('15', '9'),
	('16', '4'),
	('17', '3'),
	('18', '5'),
	('19', '4'),
	('20', '2'),
	
	('1', '3'),
	('2', '7'),
	('3', '4'),
	('4', '9'),
	('5', '7'),
	('6', '6'),
	('7', '2'),
	('8', '3'),
	('9', '2'),
	('10', '7'),
	('11', '8'),
	('12', '9'),
	('13', '7'),
	('14', '3'),
	('15', '1'),
	('16', '5'),
	('17', '7'),
	('18', '6'),
	('19', '3'),
	('20', '9');
	
INSERT INTO contact_seeking (contact_id, seeking_id)
VALUES
	('1', '1'),
	('2', '1'),
	('3', '1'),
	('4', '2'),
	('5', '1'),
	('6', '1'),
	('7', '2'),
	('8', '2'),
	('9', '1'),
	('10', '2'),
	('11', '1'),
	('12', '2'),
	('13', '1'),
	('14', '1'),
	('15', '1'),
	('16', '1'),
	('17', '2'),
	('18', '4'),
	('19', '1'),
	('20', '1');
	
---------------------------------------------------------------------------------------------------------------------------------	
--OUTPUT || SELECT + JOIN
---------------------------------------------------------------------------------------------------------------------------------

SELECT cont.first_name, cont.last_name, cont.phone, cont.email, cont.gender, cont.birthday,
	prof.proffesion, zip.zip_code, zip.city, zip.province, stat.status, STRING_AGG (inte.interest, ', ') AS interests, seek.seeking 
FROM my_contacts AS cont LEFT JOIN proffesion AS prof
	ON cont.prof_id = prof.prof_id
LEFT JOIN zip_code AS zip
	ON cont.zip_code = zip.zip_code
LEFT JOIN status AS stat
	ON cont.status_id = stat.status_id
LEFT JOIN contact_interest as cont_inte
	ON cont.contact_id = cont_inte.contact_id
LEFT JOIN interests AS inte
	ON cont_inte.interest_id = inte.interest_id
LEFT JOIN contact_seeking as cont_seek
	ON cont.contact_id = cont_seek.contact_id
LEFT JOIN seeking AS seek
	ON cont_seek.seeking_id = seek.seeking_id
GROUP BY
	cont.first_name, cont.last_name, cont.phone, cont.email, cont.gender, cont.birthday,
	prof.proffesion, zip.zip_code, zip.city, zip.province, stat.status, seek.seeking;
