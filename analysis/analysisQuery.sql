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

CREATE TABLE number_data_types (
numeric_column numeric(20,5),
real_column real,
double_column double precision
);

INSERT INTO number_data_types
VALUES
(.7, .7, .7),
(2.13579, 2.13579, 2.13579),
(2.1357987654, 2.1357987654, 2.1357987654);

SELECT * FROM number_data_types;

--Chapter 5

CREATE TABLE departments (
	dept_id bigserial,
	dept varchar(100),
	city varchar(100),
	CONSTRAINT dept_key PRIMARY KEY (dept_id),
	CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
	emp_id bigserial,
	first_name varchar(100),
	last_name varchar(100),
	salary integer,
	dept_id integer REFERENCES departments (dept_id),
	CONSTRAINT emp_key PRIMARY KEY (emp_id),
	CONSTRAINT emp_dept_unique UNIQUE (emp_id, dept_id)
);

INSERT INTO departments (dept, city)
VALUES
	('Tax', 'Atlanta'),
	('IT', 'Boston');
	
INSERT INTO employees (first_name, last_name, salary, dept_id)
VALUES
	('Nancy', 'Jones', 62500, 1),
	('Lee', 'Smith', 59300, 1),
	('Soo', 'Nguyen', 83000, 2),
	('Janet', 'King', 95000, 2);

SELECT *
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id;

SELECT *
FROM employees FULL OUTER JOIN departments
ON employees.dept_id = departments.dept_id;

--schools

CREATE TABLE schools_left (
	id integer CONSTRAINT left_id_key PRIMARY KEY,
	left_school varchar(30)
);

CREATE TABLE schools_right (
	id integer CONSTRAINT right_id_key PRIMARY KEY,
	right_school varchar(30)
);

INSERT INTO schools_left (id, left_school) VALUES
	(1, 'Oak Street School'),
	(2, 'Roosevelt High School'),
	(5, 'Washington Middle School'),
	(6, 'Jefferson High School');

INSERT INTO schools_right (id, right_school) VALUES
	(1, 'Oak Street School'),
	(2, 'Roosevelt High School'),
	(3, 'Morrison Elementary'),
	(4, 'Chase Magnet Academy'),
	(6, 'Jefferson High School');
	
SELECT *
FROM schools_left JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left RIGHT JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left FULL OUTER JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left CROSS JOIN schools_right;

SELECT *
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id
WHERE schools_right.id IS NULL;

SELECT id
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id;



CREATE TABLE schools_enrollment (
	id integer,
	enrollment integer
);

CREATE TABLE schools_grades (
	id integer,
	grades varchar(10)
);

INSERT INTO schools_enrollment (id, enrollment)
VALUES
	(1, 360),
	(2, 1001),
	(5, 450),
	(6, 927);

INSERT INTO schools_grades (id, grades)
VALUES
	(1, 'K-3'),
	(2, '9-12'),
	(5, '6-8'),
	(6, '9-12');

SELECT lt.id, lt.left_school, en.enrollment, gr.grades
FROM schools_left AS lt LEFT JOIN schools_enrollment AS en
	ON lt.id = en.id
LEFT JOIN schools_grades AS gr
	ON lt.id = gr.id;
	

CREATE TABLE us_counties_2000 (
	geo_name varchar(90),
	state_us_abbreviation varchar(2),
	state_fips varchar(2),
	county_fips varchar(3),
	p0010001 integer,
	p0010002 integer,
	p0010003 integer,
	p0010004 integer,
	p0010005 integer,
	p0010006 integer,
	p0010007 integer,
	p0010008 integer,
	p0010009 integer,
	p0010010 integer,
	p0020002 integer,
	p0020003 integer
);

COPY us_counties_2000
	FROM 'C:\Users\jaden\Desktop\postgreSQL\practical-sql-master\practical-sql-master\Chapter_06\us_counties_2000.csv'
	WITH (FORMAT CSV, HEADER);
	
	SELECT c2010.geo_name,
			c2010.state_us_abbreviation AS state,
			c2010.p0010001 AS pop_2010,
			c2000.p0010001 AS pop_2000,
			c2010.p0010001 - c2000.p0010001 AS raw_change,
			round( (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001)
				/ c2000.p0010001 * 100, 1 ) AS pct_change
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
	AND c2010.county_fips = c2000.county_fips
	AND c2010.p0010001 <> c2000.p0010001
ORDER BY pct_change DESC;


--Chapter 8

--library 2014

CREATE TABLE pls_fy2014_pupld14a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2014_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl float NOT NULL,
    video_ph integer NOT NULL,
    video_dl float NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    elmatcir integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    yr_sub integer NOT NULL
);

CREATE INDEX libname2014_idx ON pls_fy2014_pupld14a (libname);
CREATE INDEX stabr2014_idx ON pls_fy2014_pupld14a (stabr);
CREATE INDEX city2014_idx ON pls_fy2014_pupld14a (city);
CREATE INDEX visits2014_idx ON pls_fy2014_pupld14a (visits);

COPY pls_fy2014_pupld14a
FROM 'C:\Users\jaden\Desktop\postgreSQL\practical-sql-master\practical-sql-master\Chapter_08\pls_fy2014_pupld14a.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM  pls_fy2014_pupld14a

--library 2009

CREATE TABLE pls_fy2009_pupld09a (
    stabr varchar(2) NOT NULL,
    fscskey varchar(6) CONSTRAINT fscskey2009_key PRIMARY KEY,
    libid varchar(20) NOT NULL,
    libname varchar(100) NOT NULL,
    address varchar(35) NOT NULL,
    city varchar(20) NOT NULL,
    zip varchar(5) NOT NULL,
    zip4 varchar(4) NOT NULL,
    cnty varchar(20) NOT NULL,
    phone varchar(10) NOT NULL,
    c_relatn varchar(2) NOT NULL,
    c_legbas varchar(2) NOT NULL,
    c_admin varchar(2) NOT NULL,
    geocode varchar(3) NOT NULL,
    lsabound varchar(1) NOT NULL,
    startdat varchar(10),
    enddate varchar(10),
    popu_lsa integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    master numeric(8,2) NOT NULL,
    libraria numeric(8,2) NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    locgvt integer NOT NULL,
    stgvt integer NOT NULL,
    fedgvt integer NOT NULL,
    totincm integer NOT NULL,
    salaries integer,
    benefit integer,
    staffexp integer,
    prmatexp integer NOT NULL,
    elmatexp integer NOT NULL,
    totexpco integer NOT NULL,
    totopexp integer NOT NULL,
    lcap_rev integer NOT NULL,
    scap_rev integer NOT NULL,
    fcap_rev integer NOT NULL,
    cap_rev integer NOT NULL,
    capital integer NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio integer NOT NULL,
    video integer NOT NULL,
    databases integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    referenc integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    loanto integer NOT NULL,
    loanfm integer NOT NULL,
    totpro integer NOT NULL,
    totatten integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    yr_sub integer NOT NULL,
    obereg varchar(2) NOT NULL,
    rstatus integer NOT NULL,
    statstru varchar(2) NOT NULL,
    statname varchar(2) NOT NULL,
    stataddr varchar(2) NOT NULL,
    longitud numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL,
    fipsst varchar(2) NOT NULL,
    fipsco varchar(3) NOT NULL
);

CREATE INDEX libname2009_idx ON pls_fy2009_pupld09a (libname);
CREATE INDEX stabr2009_idx ON pls_fy2009_pupld09a (stabr);
CREATE INDEX city2009_idx ON pls_fy2009_pupld09a (city);
CREATE INDEX visits2009_idx ON pls_fy2009_pupld09a (visits);

COPY pls_fy2009_pupld09a
FROM 'C:\Users\jaden\Desktop\postgreSQL\practical-sql-master\practical-sql-master\Chapter_08\pls_fy2009_pupld09a.csv'
WITH (FORMAT CSV, HEADER);

--SELECT's

SELECT * FROM pls_fy2009_pupld09a

SELECT count(*)
FROM pls_fy2014_pupld14a;

SELECT count(*)
FROM pls_fy2009_pupld09a;

SELECT count(salaries)
FROM pls_fy2014_pupld14a;

SELECT count(libname)
FROM pls_fy2014_pupld14a;

SELECT count(DISTINCT libname)
FROM pls_fy2014_pupld14a;

SELECT max(visits), min(visits)
FROM pls_fy2014_pupld14a;

SELECT stabr
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY stabr;

SELECT city, stabr
FROM pls_fy2014_pupld14a
GROUP BY city, stabr
ORDER BY city, stabr;

SELECT stabr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr
ORDER BY count(*) DESC;

SELECT stabr, stataddr, count(*)
FROM pls_fy2014_pupld14a
GROUP BY stabr, stataddr
ORDER BY stabr ASC, count(*) DESC;

SELECT sum(visits) AS visits_2014
FROM pls_fy2014_pupld14a
WHERE visits >= 0;

SELECT sum(visits) AS visits_2009
FROM pls_fy2009_pupld09a
WHERE .visits >= 0;

SELECT  sum(pls_fy2009_pupld09a.visits) AS "2009_visits",
	sum(pls_fy2014_pupld14a.visits) AS "2014_visits",
	sum(pls_fy2014_pupld14a.visits) - sum(pls_fy2009_pupld09a.visits) AS "Difference"
FROM pls_fy2009_pupld09a, pls_fy2014_pupld14a
WHERE  pls_fy2009_pupld09a.visits >= 0 AND pls_fy2014_pupld14a.visits >= 0

GROUP BY  pls_fy2009_pupld09a.visits, pls_fy2014_pupld14a.visits;

--Chapter 9

CREATE TABLE meat_poultry_egg_inspect (
    est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
    company varchar(100),
    street varchar(100),
    city varchar(30),
    st varchar(2),
    zip varchar(5),
    phone varchar(14),
    grant_date date,
    activities text,
    dbas text
);

COPY meat_poultry_egg_inspect
FROM 'C:\Users\jaden\Desktop\postgreSQL\practical-sql-master\practical-sql-master\Chapter_09\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

CREATE INDEX company_idx ON meat_poultry_egg_inspect (company);

-- Count the rows imported:
SELECT count(*) FROM meat_poultry_egg_inspect;

SELECT * FROM meat_poultry_egg_inspect

SELECT company,
street,
city,
st,
count(*) AS address_count
FROM meat_poultry_egg_inspect
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

SELECT st,
count(*) AS st_count
FROM meat_poultry_egg_inspect
GROUP BY st
ORDER BY st;

SELECT est_number,
company,
city,
st,
zip
FROM meat_poultry_egg_inspect
WHERE st IS NULL;

SELECT st, city
FROM meat_poultry_egg_inspect
WHERE city = 'Blaine' AND zip = '55449';

SELECT st, city, zip
FROM meat_poultry_egg_inspect
WHERE zip = '36671' OR zip = '53538';

SELECT company,
count(*) AS company_count
FROM meat_poultry_egg_inspect
GROUP BY company
ORDER BY company ASC;

SELECT length(zip),
count(*) AS length_count
FROM meat_poultry_egg_inspect
GROUP BY length(zip)
ORDER BY length(zip) ASC;

SELECT st,
	count(*) AS st_count
FROM meat_poultry_egg_inspect
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;

UPDATE meat_poultry_egg_inspect
SET st = 'MN'
WHERE city = 'Blaine' AND st = Null

SELECT * 
FROM meat_poultry_egg_inspect
WHERE city = 'Blaine'

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT * FROM meat_poultry_egg_inspect;

SELECT
(SELECT count(*) FROM meat_poultry_egg_inspect) AS original,
(SELECT count(*) FROM meat_poultry_egg_inspect_backup) AS backup;

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN st_copy varchar(2);
UPDATE meat_poultry_egg_inspect
SET st_copy = st;

SELECT st,
st_copy
FROM meat_poultry_egg_inspect
ORDER BY st;

UPDATE meat_poultry_egg_inspect
SET st = 'MN'
WHERE est_number = 'V18677A';

UPDATE meat_poultry_egg_inspect
SET st = 'AL'
WHERE est_number = 'M45319+P45319';

UPDATE meat_poultry_egg_inspect
SET st = 'WI'
WHERE est_number = 'M263A+P263A+V263A';

UPDATE meat_poultry_egg_inspect
SET st = st_copy;

UPDATE meat_poultry_egg_inspect original
SET st = backup.st
FROM meat_poultry_egg_inspect_backup backup
WHERE original.est_number = backup.est_number;

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN company_standard varchar(100);

UPDATE meat_poultry_egg_inspect
SET company_standard = company;

UPDATE meat_poultry_egg_inspect
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%';

SELECT company, company_standard
FROM meat_poultry_egg_inspect
WHERE company LIKE 'Armour%';

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN zip_copy varchar(5);
UPDATE meat_poultry_egg_inspect
SET zip_copy = zip;

UPDATE meat_poultry_egg_inspect
SET zip = '00' || zip
WHERE st IN('PR','VI') AND length(zip) = 3;

UPDATE meat_poultry_egg_inspect
SET zip = '0' || zip
WHERE st IN('CT','MA','ME','NH','NJ','RI','VT') AND length(zip) = 4;

CREATE TABLE state_regions (
	st varchar(2) CONSTRAINT st_key PRIMARY KEY,
	region varchar(20) NOT NULL
);

COPY state_regions
FROM 'C:\Users\jaden\Desktop\postgreSQL\practical-sql-master\practical-sql-master\Chapter_09\state_regions.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN inspection_date date;

UPDATE meat_poultry_egg_inspect inspect
SET inspection_date = '2019-12-01'
WHERE EXISTS (SELECT state_regions.region
	FROM state_regions
	WHERE inspect.st = state_regions.st
		AND state_regions.region = 'New England');

SELECT st, inspection_date
FROM meat_poultry_egg_inspect
GROUP BY st, inspection_date
ORDER BY st;

DELETE FROM meat_poultry_egg_inspect
WHERE st IN('PR','VI');

DROP TABLE meat_poultry_egg_inspect_backup;

UPDATE meat_poultry_egg_inspect
SET poultry_proccesing = True
WHERE activities = 'Poultry Processing';
