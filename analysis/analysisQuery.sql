CREATE TABLE teachers (
id bigserial,
first_name varchar(25),
last_name varchar(50),
school varchar(50),
hire_date date,
salary numeric
);

SELECT first_name, last_name FROM teachers;

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);

SELECT * FROM teachers;

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Jeff', 'Bush', 'Myers Middle School', '2020-01-25', 10000),
('James', 'Botha', 'F.D. Roosevelt HS', '2009-12-05', 450),
('Jen', 'Smith', 'Myers Middle School', '2000-04-15', 9012);

SELECT * FROM teachers;

SELECT last_name, first_name, salary FROM teachers;

SELECT DISTINCT school FROM teachers;

SELECT first_name, last_name, salary
FROM teachers
ORDER BY salary DESC;

SELECT last_name, school, hire_date
FROM teachers
ORDER BY school ASC, hire_date DESC;

SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers MIddle School'
40 70

SELECT last_name, school, hire_date
From teachers
WHERE first_name = 'Janet'

SELECT * FROM teachers
WHERE salary BETWEEN 40000 AND 70000

SELECT * FROM teachers
WHERE last_name 
LIKE '%ol%';

SELECT * 
FROM teachers
ORDER BY school ASC, last_name ASC;

SELECT * 
FROM teachers
WHERE first_name 
LIKE 'S%' AND salary > 40000

SELECT * 
FROM teachers
WHERE hire_date > '2010-01-01' 
ORDER BY salary DESC


