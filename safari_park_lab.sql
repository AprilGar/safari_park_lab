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
INSERT INTO animals (name, type, age, enclosure_Id) values ('Tanya', 'Tiger', 59, 1);
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

-- Extensions
-- The names of staff working in enclosures which are closed for maintenance
select staffs.name as staff, enclosures.name as enclosure_name
from staffs
inner join assignments
on staffs.id = assignments.employee_id
inner join enclosures
on assignments.enclosure_id = enclosures.id
where enclosures.closed_for_maintenance = 'true';

-- The name of the enclosure where the oldest animal lives. If there are two animals who are the same age choose the first one alphabetically.
select enclosures.name as enclosure_name, animals.name as animal, animals.age as age
from animals
inner join enclosures
on animals.enclosure_id = enclosures.id
order by animals.age desc, animals.name asc
limit 1;

-- The number of different animal types a given keeper has been assigned to work with.
-- ran out of time to add staff names
select count (distinct animals.type) name
from staffs
inner join assignments
on staffs.id = assignments.employee_id
inner join enclosures
on enclosures.id = assignments.enclosure_id
inner join animals
on enclosures.id = animals.enclosure_id
group by staffs.name;

-- The number of different keepers who have been assigned to work in a given enclosure

-- The names of the other animals sharing an enclosure with a given animal (eg. find the names of all the animals sharing the big cat field with Tony)