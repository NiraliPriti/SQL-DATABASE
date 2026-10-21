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


