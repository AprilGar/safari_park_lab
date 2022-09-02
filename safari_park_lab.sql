-- Drop tables
DROP TABLE animals;
DROP TABLE enclosures;
DROP TABLE staffs;
DROP TABLE assignments;

-- Create tables
CREATE TABLE animals (id SERIAL PRIMARY KEY, name varchar(255), type varchar(255), age int, enclosure_id int);
CREATE TABLE enclosures (id SERIAL PRIMARY KEY, name varchar(255), capacity int, closed_For_Maintenance boolean);
CREATE TABLE staffs (id SERIAL PRIMARY KEY, name varchar(255), employee_Number int);
CREATE TABLE assignments (id SERIAL PRIMARY KEY, employee_Id int, enclosure_Id int, day varchar(255));

-- Content
INSERT INTO animals (name, type, age, enclosure_Id) values ('Tony', 'Tiger', 59, 1);
INSERT INTO animals (name, type, age, enclosure_Id) values ('Tanya', 'Tiger', 35, 1);
INSERT INTO animals (name, type, age, enclosure_Id) values ('Stripey', 'Zebra', 17, 2);
INSERT INTO animals (name, type, age, enclosure_Id) values ('C6', 'Otter', 28, 3);

INSERT INTO enclosures (name, capacity, closed_For_Maintenance) values ('Big Cat Field', 20, false);
INSERT INTO enclosures (name, capacity, closed_For_Maintenance) values ('Grazing Field', 35, true);
INSERT INTO enclosures (name, capacity, closed_For_Maintenance) values ('Aquatic Centre', 12, false);

INSERT INTO staffs (name, employee_Number) values ('Captain Rik', 12345);
INSERT INTO staffs (name, employee_Number) values ('Madam Sue', 12346);

INSERT INTO assignments (employee_Id, enclosure_Id, day) values (1, 1, 'Tuesday');
INSERT INTO assignments (employee_Id, enclosure_Id, day) values (1, 2, 'Tuesday');
INSERT INTO assignments (employee_Id, enclosure_Id, day) values (2, 3, 'Wednesday');

-- Solutions
-- MVP
-- The names of the animals in a given enclosure
select animals.name, enclosures.name
from animals
inner join enclosures
on animals.enclosure_id = enclosures.id;

-- The names of the staff working in a given enclosure
select staffs.name as staff, enclosures.name as enclosure_name
from staffs
inner join assignments
on staffs.id = assignments.employee_id
inner join enclosures
on assignments.enclosure_id = enclosures.id;
