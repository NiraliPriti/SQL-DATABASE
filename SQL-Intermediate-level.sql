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

 /* #3 RULE|Data TYPES
 Data types in each column must be compatible.
*/

SELECT 
CustomerID,
LastName
FROM Sales.Customers

UNION

SELECT 
EmployeeID,
LastName
FROM Sales.Employees

/*4 RULE | ORDER PF COLUMNS 
The order of the column in each query must be the same

5 RULE | COLUMN ALIASES
The column names in the result set are determined
by the column names specified in the first query.

*/
SELECT 
CustomerID AS ID,
LastName AS Last_Name
FROM Sales.Customers

UNION

SELECT 
EmployeeID,
LastName 
FROM Sales.Employees

/*  # 6 RULE | CORRECT COLUMNS

- Even if all rules are met and sql shows no error,
the result may be incorrect.

-Incorrect Column selection leads to inaccurate results.
*/
use SalesDB;
SELECT 
FirstName,
LastName
From Sales.Customers

UNION

SELECT 
LastName,
FirstName 
FROM Sales.Employees

-- SET OPerator UNION
-- Return ALl distinct rows from both queries.
-- Remove duplicate rows from the result.

SELECT
FIRSTName,
LastName
from  Sales.Customers
UNION
SELECT 
FIRSTName,
LastName
FROM Sales.Employees;

-- UNION ALl 
--Return All Rows form both querie, Including Duplicates.
-- UNION ALl is generally faster than UNION
SELECT
FIRSTName,
LastName
from  Sales.Customers
UNION ALL
SELECT 
FIRSTName,
LastName
FROM Sales.Employees;

-- SET  oprator :- EXCEPT
-- Return all distinct rows from the first query
-- That are not found in the second query.

-- IT Is the only one where the order of quiries affect the final result.
SELECT
FIRSTName,
LastName
from  Sales.Employees
EXCEPT
SELECT 
FIRSTName,
LastName
FROM Sales.Customers;

-- SET OPERATor :- INTERSECT
-- Return only rows that are common in both queries.
-- FIND The empoyees  who are also customers

SELECT
FIRSTName,
LastName
from  Sales.Employees
INTERSECT
SELECT 
FIRSTName,
LastName
FROM Sales.Customers;

-- MOST IMPORTANT USE CASES FOR SET OPRATORS
-- COMBINATION 
-- COMBINING aal the data before sub query.


-- Order are stored in seprate tables(ORDERS and OrderArchives).
-- Combine all oreder into one report without duplicates.

SELECT*
 FROM Sales.Orders
 UNION
 SELECT * 
 FROM Sales.OrdersArchive

 -- BEST Practices
 -- Never use an asterisk(*) to combine tables;list needed columns insted
 use SalesDB;

SELECT
[ProductID]
,[OrderID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
 FROM Sales.Orders
 UNION
 SELECT 
 [OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
 FROM Sales.OrdersArchive

 -- Source Flag 
 -- Include additional column to indicate the source of each row
 SELECT
 'Orders' AS SourceTable
 ,[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
 FROM Sales.Orders
 UNION
 SELECT 
'OrderArchives' AS SourceTable
,[OrderID]
,[ProductID]
,[CustomerID]
,[SalesPersonID]
,[OrderDate]
,[ShipDate]
,[OrderStatus]
,[ShipAddress]
,[BillAddress]
,[Quantity]
,[Sales]
,[CreationTime]
 FROM Sales.OrdersArchive
 Order by OrderID

 --EXCEPT USE CASES
 /* DELTA DETECTION
 IDENTIFING the difference or changes (delta) 
  between two batches of data.

  DATA COMPLETENESS CHECK
  */
  -- Set Oprators are done here :)