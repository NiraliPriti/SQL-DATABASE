-- Range oprator
-- Between
/*Retrive all customers whose 
score falls in the range between 100 and 500 */
USE MyDatabase;
SELECT *
from customers
WHERE score >= 100 AND score <= 500

SELECT *
from customers
WHERE score BETWEEN 100 AND 500

-- MEMBErship oprator
-- IN :- check if value exist in a list
/* Retrive all customers from either 
Germany or USA */

SELECT *
from customers
WHERE country  ='Germany' 
	OR country = 'USA'
	OR country = 'france'
	OR country = 'Canada';

	-- For comparing multiple values , we can use IN operator
SELECT *
from customers
WHERE country IN ('Germany', 'USA','france','Canada')

-- Search Operator :- LIKE 
-- search for pattern in a text
-- Find all customers who start first name witn 'M'
SELECT * from customers
where first_name LIKE 'M%'

SELECT * from customers
where first_name LIKE '%n'

--First name contains 'r'
SELECT *
from customers
where first_name LIKE '%r%'

/* Find all customers whose first name has 'r'
in the 3rd postion */
SELECt *
from customers
where first_name LIKE '__r%'

--  Combining Data
-- No Joins
--Return hdata from tables without combining them

SELECT * from customers;
SELECt * from orders;

-- INNER JOINS  ONLY Matching records from both tables
-- Default type of join is INNER JOIN
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from customers as c
INNER JOIN orders as o
ON c.id= o.customer_id;

/* add the table name before the column to 
avoid confusion in join with same-named columns 
we can give table name in short characters so that 
we can small syntex*/

-- LEFT JOIN 
-- The order of tables Important
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers as c 
LEFT JOIN  orders as o
ON c.id = o.customer_id;

-- RIGHT JOIN
/*Return All rows from the right table 
and matching rows from the left table */
-- The Order of tables is important

select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from customers as c
right join orders as o
ON c.id = o.customer_id;


select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from orders as o
LEFT join customers as c
ON c.id = o.customer_id;

 -- FULL JOIN  Return ALL Rows from both tables

 select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales,
	o.order_date
from orders as o
FULL join customers as c
ON c.id = o.customer_id;   

-- LEFT Any Anti join
-- Return all rows from left that has no match in right

SELECT *
FROM customers as c
LEFT JOIN orders as o
ON c.id = o.customer_id
where o.customer_id IS NULL

--Right anti join
-- Return rows from the roight table that has no match non left 

/* Get all orders without matching customers */
SELECT *
FROM orders as o
LEFT JOIN customers as c 
ON c.id = o.customer_id
where c.id IS NULL

--  FULL Anti join
-- Return only rows that don't match in either tables

SELECT *
FROM orders as o
FULL JOIN customers as c 
ON c.id = o.customer_id
where c.id IS  NULL OR o.customer_id IS  NULL
/* Get all customers alomg with their orders,
but only for customers who have placed an order*/

SELECT *
FROM orders as o
FULL JOIN customers as c 
ON c.id = o.customer_id
where c.id IS NOT NULL 
AND o.customer_id IS NOT NULL

-- CROSS JOIN
/* Combine Every ROw from left with every row 
from right all possible combination - Cartesian Join
*/

/* Generate all possible combination 
of customers and order. */

SELECT *
FROM customers
CROSS JOIN orders

-- Multi-Table Join

/*Task: Using Sales DB Retirve a list of all orders, along 
with the related customer, product, and employee details  for each order, Display :
Order ID, Customer's Name, Product Name, Sales, Price, Sales person's name */

USE SalesDB;

SELECT 
o.OrderID,
o.Sales,
c.FirstName As CustomerfirstName,
c.LastName as CustomerlastName,
p.Product AS ProductName,
p.Price,
e.FirstName AS SalesPersonFirstName,
e.LastName AS SalesPersonLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID 
LEFT JOIN Sales.Products AS p
ON o.ProductID = p.ProductID
LEFT JOIN  Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID

 -- Set OPerators 
 /* #1 Rule | SQL Clauses
 - Set operator can be used almost in all caluses.
  where, join , group by, having
 - Odrder By Is allowed only Once at the end of query

 #2 Rule  | Number of COLUMNS
 - The number of columns in each query must be the same  
 */

 SELECT 

 FIrstName,
 LastName
 FROM Sales.Customers

 UNION

 SELECT 
 FirstName,
 LastName
 FROM Sales.Employees
