--CREATE TABLES--

CREATE TABLE Employees (
	emp_id bigserial,
	first_name varchar(25),
	last_name varchar(25),
	gender varchar(6),
	address varchar(50),
	email varchar (35),
	depart_id integer REFERENCES Departments (depart_id),
	role_id integer REFERENCES Roles (role_id),
	salary_id integer REFERENCES Salaries (salary_id),
	overtime_id integer REFERENCES Overtime_Hours (overtime_id),
	CONSTRAINT emp_id PRIMARY KEY (emp_id),
	CONSTRAINT email UNIQUE (email)
);

CREATE TABLE Departments (
	depart_id bigserial,
	depart_name varchar(30),
	depart_city varchar(30),
	CONSTRAINT depart_id PRIMARY KEY (depart_id)
);

CREATE TABLE Roles (
	role_id bigserial,
	role varchar(30),
	CONSTRAINT role_id PRIMARY KEY (role_id)
);

CREATE TABLE Salaries (
	salary_id bigserial,
	salary_pa numeric(8,2),
	CONSTRAINT salary_id PRIMARY KEY (salary_id)
);

CREATE TABLE Overtime_Hours (
	overtime_id bigserial,
	overtime_hours bigint,
	CONSTRAINT overtime_id PRIMARY KEY (overtime_id)
);

--INSERT--

INSERT INTO overtime_hours (overtime_hours)
VALUES (5),
	(3),
	(2),
	(1),
	(4),
	(7);
	
INSERT INTO departments (depart_name, depart_city)
VALUES ('Marketing', 'Mafikeng'),
	('Finance', 'Nelspruit'),
	('Sales', 'Durban'),
	('Human Resources', 'Alberton'),
	('Operations', 'Hammanskraal');
	
INSERT INTO salaries (salary_pa)
VALUES 				--1		
	(750000),			
	(123896),					
	(100100),			
	(500120),				--5			
	(100000),			
	(500100),			
	(900000),			
	(230000),			
	(550000);				--10			
	
INSERT INTO roles (role)
VALUES ('Marketing analyst'),		--1
	('Marketing manager'),
	('Marketing specialist'),
	('Accountant'),
	('Auditor'),					--5
	('Budget analyst'),
	('Sales Manager'),
	('Sales Specialist'),
	('Sales Development Rep'),
	('Safety and Health'),			--10
	('Staffing'),
	('Development'),
	('Product Design'),
	('Forecasting'),
	('Delivery Management'); 		--15
	
	
INSERT INTO employees (first_name, last_name, gender, address, email, depart_id, role_id, salary_id, overtime_id)
VALUES ('Nancy', 'Harris', 'female', '683 Bodenstein St, Alberton', 'NancyRHarris@jourrapide.com', 4, 12, 9, 1),			--1
	('William', 'Mahle', 'male', '1334 Gray Pl, Durban', 'WilliamPMahle@dayrep.com', 3, 7, 4, 6),
	('Agnes', 'McBee', 'female', '539 Ireland St, Nelspruit', 'AgnesCMcBee@armyspy.com', 2, 4, 3, 3),
	('Adolph', 'Boyd', 'male', '1 North Street, Mafikeng', 'AdolphBoyd@jourrapide.com', 1, 1, 7, 5  ),
	('George', 'Sloan', 'male', '2230 Amos St, Hammanskraal', 'GeorgeDSloan@rhyta.com', 5, 13, 4, 3  ),						--5
	('Glenda', 'Urias', 'female', '693 Wolmarans St, Alberton', 'GlendaJUrias@teleworm.us', 4, 11, 10, 1),
	('Louise', 'Parkinson', 'female', '2581 Stuart Street, Durban', 'LouiseJParkinson@armyspy.com', 3, 8, 9, 2),
	('Tony', 'Bloom', 'male', '387 Oranje St, Nelspruit', 'TonyDBloom@armyspy.com', 2, 5, 8, 4),
	('Christine', 'Villalta', 'female', '1170 Heuvel St, Mafikeng', 'ChristineCVillalta@teleworm.us', 1, 2, 7, 6),
	('Dorothea', 'Garcia', 'female', '1245 Schoeman St, Hammanskraal', 'DorotheaDGarcia@rhyta.com', 5, 14, 6, 1),			--10
	('Francis', 'Olguin', 'male', '1288 Albert St, Alberton', 'FrancisKOlguin@teleworm.us', 4, 10, 5, 2),		
	('Justin', 'Mendoza', 'male', '2458 Diesel Street, Durban', 'JustinMMendoza@armyspy.com', 3, 9, 4, 3 ),
	('Richard', 'Pollock', 'male', '1787 Wit Rd, Nelspruit', 'RichardDPollock@jourrapide.com', 2, 6, 3, 4  ),
	('Steve', 'Hagberg', 'male', '2270 Roger St, Mafikeng', 'SteveDHagberg@armyspy.com', 1, 3, 2, 5 ),
	('Thomas', 'Keith', 'male', '383 Glyn St, Hammanskraal', 'ThomasKeith@dayrep.com', 5, 15, 1, 6 );						--15
	
SELECT emp.first_name, emp.last_name, emp.gender, emp.address, emp.email, dept.depart_name, dept.depart_city,
	overt.overtime_hours, roles.role, sal.salary_pa
FROM employees AS emp LEFT JOIN departments AS dept
	ON emp.depart_id = dept.depart_id
LEFT JOIN overtime_hours AS overt
	ON emp.overtime_id = overt.overtime_id
LEFT JOIN roles 
	ON emp.role_id = roles.role_id
LEFT JOIN salaries AS sal
	ON emp.salary_id = sal.salary_id;