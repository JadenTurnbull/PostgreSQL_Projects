#TryItYourself_p10

CREATE TABLE animals (
id bigserial,
animal varchar(25)
);

CREATE TABLE animal_info (
id bigserial,
species varchar(25),
height numeric,
weight numeric,
origin varchar(30)
);

DROP Table animal_info
 
INSERT INTO animals (animal)
VALUES ('Lion'),
('Elephant'),
('Giraffe');

INSERT INTO animal_info (species, height, weight, origin)
VALUES ('Lion', 2, 100, 'Africa'),
('Elephant', 4, 500, 'Africa'),
('Giraffe', 6, 200, 'Africa');

SELECT * FROM animal_info;

TryItYourself_p22

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

--CLASSWORK

CREATE TABLE char_data_types (
varchar_column varchar(10),
char_column char(10),
text_column text
);

INSERT INTO char_data_types
VALUES
('abc', 'abc', 'abc'),
('defghi', 'defghi', 'defghi');
COPY char_data_types TO 'C:\Users\jaden\Desktop\postgreSQL\Classwork\typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');
