-- THIS IS SQL NOTES
-- we write single line comment -- 
/* using /* */ we can write multiple line comments.*/
/* Below is the example of writing static value and give name to column
as per our requirement*/
SELECT 123 AS static_number

SELECT 'HELLOO' AS static_string

SELECT id,
first_name,
'New Customer' AS customer_type
from customers

SELECT *
from customers
where country ='germany'

select* from orders

--Data Defination language - DDL commands
/* Create a new table called persons
with columns: id, person_name, birth_date, and phone */

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY(id) 
)

--IT will just create a structure no output will going to display in execution

SELECT * from persons
-- DATA Defination language - DDL
-- add a new column in table callled email 
Alter table persons 
add email varchar(50) NOT NULL

select * from persons

-- remove column phone from the person table
ALTER TABLE persons
DROP column phone 

--DROP table
DROP TABLE persons

--Data Manipulation language
-- INSERT SYNTEX
INSERT INTO customers(id, first_name) 
values
	(10,'Sahra')

select* from customers

--INSERT USING SELECT
-- INSERT DATA from 'customers' table into 'persons'CREATE TABLE [dbo].[persons](
	CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY(id) 
)
INSERT INTO persons(id,person_name,birth_date, phone)
SELECT 
id,
first_name,
NULL,
'unknown'
from customers



/*Database never compare column name it will only care about 
constraints*/
-- DATA manipulation language (DML) :- UPDATE
-- change the score of customer 6 to 0
UPDATE customers
SET score = 0
where id = 6

select * from customers
/*change the score of customer 10 to 0 
and update the country to UK */
UPDATE customers
SET score = 100
where id = 7

select * from customers 

UPDATE customers
SET score =0

-- DATA manipulation language (DML)
-- DELETE

/*ALWAYS USE where to avoid deleting all rows 
unintetionally */
-- DELET all the customers with an id ID greater than 5

DELETE FROM customers
where id >5

select*from customers

select * from persons
-- Delete all data from the table
-- for large data set it is ebneficial to use truncate
-- because it will tack less time 
Truncate Table persons

-- Begineer level completed Congratulations 🎉 :) 

-- Intermediate level we will figure out how to filter our data.
-- Comparison operator

Select* from
customers
where country != 'germany'

select * from customers
where score >= 500

select * from customers
where score <= 500
-- AND Logical Opratore
-- Retrive  all the customers who are from usa 
-- and have score greater than 500
select * from customers
where country= 'USA' AND
score>500;


