-- Advanced SQL Techniques

--Data warehouse :- Aspecial Database that collects and
--integrate data from different sources to enable analytics and support decision-making

--Disk Storage :- Long Term Memory,where data is stored permanently.

--Subquery
--Scalar Query :- return single value
use SalesDB
Select
Avg(Sales)
from sales.Orders

--Row SubQuery :- return Multiple values single column
Select
CustomerID
from Sales.Orders

--Table SubQuery Multiple rows and multiple columns
 Select
OrderID,
OrderDate
from Sales.Orders

--From Clause :- From Subquery
--Find the produts that have a price higher thsn the
-- average price of all products.

Select
ProductID,
Price
from
	--Subquery
	(Select
		ProductID,
		Price,
		Avg(Price) over() as Avgprice
	 from Sales.Products
	 )t
where Price > Avgprice 

--Rank Customers based on their total amount of sales

Select
*,
Rank() over (Order by TotalSales Desc) CutomerRank
from
(Select 
	CustomerID,
	Sum(Sales) TotalSales
from Sales.Orders
Group by CustomerID)t

--Subquery in select clause
-- Task:- Show the Product IDs, Names, Prices and
-- Total number of orders.
use SalesDB

Select
	ProductID,
	Product,
	Price,
	(Select count(*) from Sales.Orders) TotalOrders
from Sales.Products;

--13:27:39
--Show all customers details and find the total
--Orders for each customers

Select 
c.*,
o.TotalOrders
from Sales.Customers c
left Join(
	Select
	CustomerID,
	count(*) TotalOrders 
	from Sales.Orders
	group by CustomerID) o
on c.CustomerID = o.CustomerID

--Find the Products That have a price higher
-- Than the average price of all products.

Select
*,
(select avg(price) from Sales.Products) avgprice
from Sales.Products
where price > (select avg(price) from Sales.Products)

--Show the details of orders made by customers 
--in germany

Select
*
from Sales.Orders
where CustomerID IN (
			select
			CustomerID 
			from Sales.Customers
			where Country = 'Germany');
-- Any Operator
--Find female employees whose salaries are greter than
-- the salaries of any male employees

Select
	EmployeeID,
	FirstName,
	Gender,
	Salary
from Sales.Employees
where Gender = 'F'
and Salary > Any(Select Salary from Sales.Employees where Gender = 'M')
 
--Find female employees whose salaries are greter than
-- the salaries of all male employees

Select
	EmployeeID,
	FirstName,
	Gender,
	Salary
from Sales.Employees
where Gender = 'F'
and Salary > all (Select Salary from Sales.Employees where Gender = 'M')
 
 --Show all customer details and find the total
 --orders for each customer.

 Select
 *,
 (Select count(*) from Sales.Orders o where o.CustomerID = c.CustomerID) TotalSales
 from Sales.Customers c

 --Exist operator
 --Show the Details of orders made by customers 
 --in Germany
 Select
 *
 from Sales.Orders o
 where Exists (Select 1
				from Sales.Customers c
				where Country = 'Germany'
				and o.CustomerID = c.CustomerID)

--Good work Subqyery Concept Completed :)

--Comman Table Expression
-- Temporary, named result set virtual table that
--can be used multiple times within your query to 
-- simplify and organize complex query.

--CTE Types :- Non Recursive CTE and Recursive CTE
--Non-Recursive CTE :- Standalone CTE and Nested CTE

-- Standalone CTE:-
--Defined and Used Independently.
--Runs Independently as it is self-contaoned 
-- and doesn't rely  on other CTEs or Queries.
--Mini Project
--Task:- #1 :- find the total sales per customer.

with CTE_Total_Sales as 
(
Select
	CustomerID,
	Sum(Sales)  as TotalSales
from Sales.Orders
Group by CustomerID
)
 --Multiple Standalone CTE
--#2 Find the last order date per customer.
, CTE_Last_Order as
(
Select
	CustomerID,
	max(OrderDate) as Last_Order
from Sales.Orders
group by CustomerID
)
-- #3 Rank the customers based on total sales per cusotmer.(Nested CTE)
, CTE_Customer_Rank as
(
Select
CustomerID,
TotalSales,
Rank() over(order by TotalSales desc) as CustomerRank
from CTE_Total_Sales
)
--Step #4 Segment customers based on their total sales.(Nested CTE)
,CTE_Customer_Segments as
(
Select 
CustomerID,
TotalSales,
case when TotalSales > 100 then 'High'
     when TotalSales > 50 then 'Medium'
	 else 'Low'
End CustomerSegments
from CTE_Total_Sales
)
--Main Query
Select
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
clo.Last_Order,
ccr.CustomerRank,
ccs.CustomerSegments
from Sales.Customers c
Left join CTE_Total_Sales cts
on cts.CustomerID = c.CustomerID
Left join CTE_Last_Order clo
on clo.CustomerID = c.CustomerID
left join CTE_Customer_Rank ccr
on ccr.CustomerID = c.CustomerID
left join CTE_Customer_Segments ccs
on ccs.CustomerID = c.CustomerID

--CTE Stores table in cache memory
--we  cannot use ORDER BY directly within CTE.
 
 --Nested CTE
 --CTE inside another CTE so it can't run independently

 --Rank the customers based on total sales per cusotmer.

 --Best Practise 
 -- Rethinck and refactor your CTEs Before starting a new one.
 --Don't use More than 5 CTEs in one query; Otherwise, you code will be hard to understand and maintain.
 
 --Recursive CTE
 --Task:- Generate a recursive numbers from 1 to 20
 WITH Series as (
	--Anchor query
	SELECT
	1 as MyNumber
	UNION ALL
	--Recursive query
	SELECT
	MyNumber + 1
	From Series
	WHERE MyNumber < 20
)
--Main query
SELECT *
FROM Series
Option (MAXRECURSION 20)

--TASK :- SHOW THE EMPLOYEE Heirarchy by displaying 
--each employee's level within the organization.

With CTE_Emp_Hierarchy as
(
	--Anchor query
	Select
		EmployeeID,
		FirstName,
		ManagerID,
		1 as Level 
	from Sales.Employees
	where ManagerID is null
	UNION All
	--Recursive Query
	Select
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		Level +1
	from Sales.Employees as e
	Inner join CTE_Emp_Hierarchy ceh
	on e.ManagerID= ceh.EmployeeID
)

--Main Query
Select
*
from CTE_Emp_Hierarchy

--Chapter  9 . 3 Views
-- Create /Update / Drop

--Find The running total of sales for each month

WITH CTE_Monthly_Summary as (
	Select 
	DateTrunc(month, OrderDate) OrderMonth,
	Sum(Sales) TotalSales,
	Count(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	from Sales.Orders
	Group by DateTrunc(month, OrderDate)
)
Select
OrderMonth,
TotalSales,
Sum(TotalSales) over(Order by OrderMonth) as RunningTotal
from CTE_Monthly_Summary


Create VIEW Sales.V_Monthly_Summary as 
(
	Select 
	DateTrunc(month, OrderDate) OrderMonth,
	Sum(Sales) TotalSales,
	Count(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	from Sales.Orders
	Group by DateTrunc(month, OrderDate)
) 
 Select 
 *
 from V_Monthly_Summary 

SELECT 
OrderMonth,
TotalSales,
Sum(TotalSales) over(Order by OrderMonth) as RunningTotal
from V_Monthly_Summary

Drop View V_Monthly_Summary

--Create  or Replace VIEW Sales.V_Monthly_Summary as  -- this will not work in Sql server THis will work on Postgre sql Server 

-- for sql server  therer two ways first drop view and recreate or using TSQL
-- Tsql stands for transaction sql 
if Object_ID ('Sales.V_Monthly_Summary','V') is not null
	drop view Sales.V_Monthly_Summary;
Go 
Create VIEW Sales.V_Monthly_Summary as 
(
	Select 
	DateTrunc(month, OrderDate) OrderMonth,
	Sum(Sales) TotalSales,
	Count(OrderID) TotalOrders,
	SUM(Quantity) TotalQuantities
	from Sales.Orders
	Group by DateTrunc(month, OrderDate)
) 


--Task:-   Provide a view that combine details from
--Orders, products, customers and employees
CREATE VIEW Sales.V_Order_Details as (
	SELECT
	o.OrderID,
	o.OrderDate,
	p.Product,
	p.Category,
	Coalesce(c.FirstName, ' ') + ' ' + Coalesce(c.LastName, ' ') CustomerName,
	c.Country CustomerCountry,
	Coalesce(e.FirstName, ' ') + ' ' + Coalesce(e.LastName, ' ') SalesName,
	e.Department,
	o.Sales,
	o.Quantity
	from Sales.Orders o
	left join Sales.Products p
	on p.ProductID = o.ProductID
	left join Sales.Customers c
	on c.CustomerID = o.CustomerID
	Left Join Sales.Employees e
	on e.EmployeeID = o.SalesPersonID
)

Select * from
Sales.V_Order_Details

--# 3 use case views security
--Task :- Provide a view for the EU Sales team
--That combine details from all tables 
--and excludes data related to the usa.
create view Sales.V_OrderDetails_EU as (
	SELECT
	o.OrderID,
	o.OrderDate,
	p.Product,
	p.Category,
	Coalesce(c.FirstName, ' ') + ' ' + Coalesce(c.LastName, ' ') CustomerName,
	c.Country CustomerCountry,
	Coalesce(e.FirstName, ' ') + ' ' + Coalesce(e.LastName, ' ') SalesName,
	e.Department,
	o.Sales,
	o.Quantity
	from Sales.Orders o
	left join Sales.Products p
	on p.ProductID = o.ProductID
	left join Sales.Customers c
	on c.CustomerID = o.CustomerID
	Left Join Sales.Employees e
	on e.EmployeeID = o.SalesPersonID
	where c.Country != 'USA'
)

SELECT * FROM Sales.V_OrderDetails_EU

--#4 Use case Flexibility & dynamic
-- # 5 Use vase :- Multiple language
--# 6 Use case :- Virtual Sata Marts in DWH

--ch 9 - 4 CTAs Tables & Temp Tables

-- CTAS :- Create table as per query
--Create/Insert vs CTAS

--Create :- Define the structure of table
-- Insert | Insert data into the table.

--#1 Step create empty table
--#2 Step Insert data 

 -- In ctas #1 step 


 --Create Table Name as 
 --(
	--SELECT
	--FROM
	--WHERE
--)
-- MY SQL | POSTGRES | ORACLE
--SQL SERVER

SELECT
INTO NEW TABLE
FROM
WHERE

--#1 usecase
-- Optimize Performance

SELECT
	DATENAME(MONTH, OrderDate) OrderMonth,
	count(OrderID) TotalOrders
into Sales.MonthlyOrders
from Sales.Orders
group by DateName(Month, OrderDate)

SELECT * from Sales.MonthlyOrders

DROP table Sales.MonthlyOrders

--TSQL 
If OBJECT_ID ('Sales.MonthlyOrders' , 'U') is not null
	DROP Table Sales.MonthlyOrders;
GO
SELECT
	DATENAME(MONTH, OrderDate) OrderMonth,
	count(OrderID) TotalOrders
into Sales.MonthlyOrders
from Sales.Orders
group by DateName(Month, OrderDate)

-- #2 Use case 
--Creating a SnapShot
-- #3 Usecase :- Physical Data Marts in DWH
--Temparary tables
