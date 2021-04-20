--Classwork

--Chapter 

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

SELECT
numeric_column * 10000000 AS "Fixed",
real_column * 10000000 AS "Float"

FROM number_data_types
WHERE numeric_column = .7;



CREATE TABLE date_time_types (
timestamp_column timestamp with time zone,
interval_column interval
);

INSERT INTO date_time_types
VALUES
('2018-12-31 01:00 EST','2 days'),
('2018-12-31 01:00 -8','1 month'),
('2018-12-31 01:00 Australia/Melbourne','1 century'),
(now(),'1 week');

SELECT * FROM date_time_types;

SELECT
timestamp_column,
interval_column,
timestamp_column - interval_column AS new_date
FROM date_time_types;

--Chapter 4

CREATE TABLE us_counties_2010 (
	geo_name varchar(90),
	state_us_abbreviation varchar(2),
	summary_level varchar(3),
	region smallint,
	division smallint,
	state_fips varchar(2),
	county_fips varchar(3),
	area_land bigint,
	area_water bigint,
	population_count_100_percent integer,
	housing_unit_count_100_percent integer,
	internal_point_lat numeric(10,7),
	internal_point_lon numeric(10,7),
	p0010001 integer,
	p0010002 integer,
	p0010003 integer,
	p0010004 integer,
	p0010005 integer,
	--snip--
	p0040049 integer,
	p0040065 integer,
	Importing and Exporting Data 45
	p0040072 integer,
	h0010001 integer,
	h0010002 integer,
	h0010003 integer
);

SELECT 2 + 2;
SELECT 9 - 1;
SELECT 3 * 4;

SELECT 11 / 6;
SELECT 11 % 6;
SELECT 11.0 / 6;
SELECT CAST (11 AS numeric(3,1)) / 6;

SELECT 3 ^ 4;
SELECT |/ 10;
SELECT sqrt(10);
SELECT ||/ 10;
SELECT 4 !;

SELECT 7 + 8 * 9;
SELECT (7 + 8) * 9;

SELECT 3 ^ 3 - 1;
SELECT 3 ^ (3 - 1);

CREATE TABLE percent_change (
	department varchar(20),
	spend_2014 numeric(10,2),
	spend_2017 numeric(10,2)
	);
	
INSERT INTO percent_change
VALUES
	('Building', 250000, 289000),
	('Assessor', 178556, 179500),
	('Library', 87777, 90001),
	('Clerk', 451980, 650000),
	('Police', 250000, 223000),
	('Recreation', 199000, 195000);
	
SELECT department,
	spend_2014,
	spend_2017,
	round( (spend_2017 - spend_2014) /
			spend_2014 * 100, 1) AS "pct_change"
FROM percent_change;

CREATE TABLE percentile_test (
	numbers integer
	);
	
INSERT INTO percentile_test (numbers) VALUES
	(1), (2), (3), (4), (5), (6);
	
SELECT
	percentile_cont(.5)
		WITHIN GROUP (ORDER BY numbers),
	percentile_disc(.5)

	WITHIN GROUP (ORDER BY numbers)
FROM percentile_test;

SELECT percentile_cont(array[.25,.5,.75])
		WITHIN GROUP (ORDER BY p0010001) AS "quartiles"
FROM us_counties_2010;

SELECT unnest(
		percentile_cont(array[.25,.5,.75])
		WITHIN GROUP (ORDER BY p0010001)
		) AS "quartiles"
FROM us_counties_2010;

--Median Function

CREATE OR REPLACE FUNCTION _final_median(anyarray)
	RETURNS float8 AS
$$
	WITH q AS
	(
		SELECT val
		FROM unnest($1) val
		WHERE VAL IS NOT NULL
		ORDER BY 1
	),
	cnt AS
	(
		SELECT COUNT(*) AS c FROM q
	)
	SELECT AVG(val)::float8
	FROM
	(
		SELECT val FROM q
		LIMIT 2 - MOD((SELECT c FROM cnt), 2)
		OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)
	) q2;
	$$
	LANGUAGE sql IMMUTABLE;
	
CREATE AGGREGATE median(anyelement) (
	SFUNC=array_append,
	STYPE=anyarray,
	FINALFUNC=_final_median,
	INITCOND='{}'
);









--TryItYourself

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

--TryItYourself_p22

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



--TryItYourself_p37

--1
 numeric(4,1)
 
--2
varchar

because of spaces between the name and surname can make it difficult

--3
It would give an error because there is no month added



-- TryItYourself_p54

COPY table_name
FROM 'C:\Directory\imaginary_file.csv'
WITH (FORMAT CSV, HEADER);

COPY (
	SELECT geo_name, state_us_abbreviation, housing_unit_count_100_percent
	FROM us_counties_2010
	ORDER BY housing_unit_count_100_percent DESC
	LIMIT 20
)
TO 'C:\Users\jaden\Desktop\postgreSQL\TryItYourSelf\us_counties_2010.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

--3
Nope, because the numbers on the left side of the comma cannot be more than 3.

--TryItYourself_p71
--1

SELECT 3.14 * 5 ^ 2;

yes, you need to get the answer of 5 to the power of 2 before you can multiply 
that with the value of pie.

--2
Franklin County, N.Y., with 7.4%. The county contains the St. Regis Mohawk

SELECT geo_name,
state_us_abbreviation AS "st",
(CAST (p0030005 AS numeric(8,1)) / p0010001) * 100 AS "pct_indian"
FROM us_counties_2010
ORDER BY "pct_indian" DESC
LIMIT 1;

--3

SELECT 


--TryItYourself_91

--1

SELECT c2010.geo_name,
       c2010.state_us_abbreviation,
       c2000.geo_name
FROM us_counties_2010 c2010 LEFT JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
   AND c2010.county_fips = c2000.county_fips
WHERE c2000.geo_name IS NULL;


--2

3.2%

SELECT percentile_cont(.5)
       WITHIN GROUP (ORDER BY round( (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001)
           / c2000.p0010001 * 100, 1 )) AS percentile_50th
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
   AND c2010.county_fips = c2000.county_fips;
   
--3

 St. Bernard Parish, La.
 
 SELECT c2010.geo_name,
       c2010.state_us_abbreviation,
       c2010.p0010001 AS pop_2010,
       c2000.p0010001 AS pop_2000,
       c2010.p0010001 - c2000.p0010001 AS raw_change,
       round( (CAST(c2010.p0010001 AS DECIMAL(8,1)) - c2000.p0010001)
           / c2000.p0010001 * 100, 1 ) AS pct_change
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000
ON c2010.state_fips = c2000.state_fips
   AND c2010.county_fips = c2000.county_fips
ORDER BY pct_change ASC;

--TryItYourSelf

--1

CREATE TABLE albums (
    album_id bigserial,
    album_catalog_code varchar(100) NOT NULL,
    album_title text NOT NULL,
    album_artist text NOT NULL,
    album_release_date date,
    album_genre varchar(40),
    album_description text,
    CONSTRAINT album_id_key PRIMARY KEY (album_id),
    CONSTRAINT release_date_check CHECK (album_release_date > '1/1/1925')
);

CREATE TABLE songs (
    song_id bigserial,
    song_title text NOT NULL,
    song_artist text NOT NULL,
    album_id bigint REFERENCES albums (album_id),
    CONSTRAINT song_id_key PRIMARY KEY (song_id)
);

--2

album_catalog_code

--3

Primary key columns get indexes by default, but we should add an index
to the album_id foreign key column in the songs table because we'll use
it in table joins. It's likely that we'll query these tables to search
by titles and artists, so those columns in both tables should get indexes
too. The album_release_date in albums also is a candidate if we expect
to perform many queries that include date ranges.



