--String  Function Replace
--Replace Specific character with a new character

-- Remove dashesh  (-) from a phone number
SELECT 
'123-456-7890' as phone,
REPLACE('123-456-7890','-','/') as clean_phone

SELECT 
'report.txt' ,
REPLACE('report.txt','.txt','.csv' ) 

-- LEN COUNTS HOW many characters
-- Calculate the length of chatacters first name

use MyDatabase;

SELECT 
first_name,
LEN(first_name) as Len_name
from customers

--String EXtraction
-- LEFT :- EXtract specific number of characters from the start
-- RUGHT :- Extract specific number of characters from the end

SELect 
	first_name,
	LEFT(TRIM(first_name), 2) first_2_char
FROM customers

SELECT 
	first_name,
	LEFT(TRIM(first_name), 2) first_2_char,
	RIGHT(first_name,2) lst_2_char
FROM customers

--SUBSTRING 
-- EXTRACT a part of string at a specified postion
--Substring(value,start,length)
/* Retrive a list of customers first names removing
 the first character
 */

 SELECT
 first_name,
 SUBSTRING(TRIM(first_name), 2, LEN(first_name)) as sub_name
FROM customers

--NUMBER FUNCTIONS
SELECT
3.516,
ROUND(3.516,2) as round_2,
ROUND(3.516,1) as round_1,
ROUND(3.516,0) as round_0

-- Return a positive value of number, removing any negative sign
--ABS
SELECT
-10,
ABS(-10),
ABS(10)

Use SalesDB;
--DATE and TIME functions
SELECT
OrderID,
CreationTime,
'2025-08-20' hardcoded
FROM Sales.Orders

--GETDATE() : return the current date and time at the 
--moment when the query is executed.

SELECT
OrderID,
CreationTime,
'2025-08-20' hardcoded,
getdate() today
FROM Sales.Orders


--PART EXtractions

--Day() 
--return the day from a date

-- dateName
SELECT
OrderID,
CreationTime,
--DATETRUNC
DATETRUNC(year, CreationTime) as year_dt,
DATETRUNC(day, CreationTime) as day_dt,
DATETRUNC(MINUTE, CreationTime) as Minute_dt,
--Datename examples
DATENAME(month,CreationTIme) as month_dn,	
DATENAME(weekday,CreationTIme) as weekday_dn,
--Date part examples
DATEPART(year,CreationTime) as year_DP,
DATEPART(month,CreationTime) as month_dp,
DATEPART(day,CreationTime) as day_dp,
DATEPART(hour,CreationTime) as hour_dp,
DATEPART(QUARTER,CreationTime) as quater_dp,
DATEPART(week,CreationTime) as week_dp,
YEAR(CreationTime) YEAR,
MONTH(CreationTime) MONTH,
DAY(CreationTime) Day
FROM Sales.Orders;


SELECT
DATETRUNC(month, CreationTime) Creation,
COUNT(*)
from Sales.Orders
Group BY DATETRUNC(month, CreationTime)

--EOMONTH():- END of The MONTH  

SELECT
OrderID,
CreationTime,
EOMONTH(CreationTime) EndOfMonth,
CAST(DATETRUNC(month, CreationTime) AS DATE) StartOfMonth
FROM Sales.Orders

-- How Many Orders were placed each year?

SELECT
 YEAR(OrderDate),
 COUNT(*) NrOfOrders
 FROM Sales.Orders
 Group by YEAR(OrderDate)

 use SalesDB;
 SELECT
 DateName(month, OrderDate) as OrderDate,
 COUNT(*) NrOfOrders
 FROM Sales.Orders
 Group by DateName(month,OrderDate)

 /* Show all orders that were placed during
 month of february
 */

 SELECT
 *
 FROM Sales.Orders
 Where MOnth(OrderDate) = 2
 
 /* Best Practise :-  Filtering data using an 
 INteger is faster than using a string
 */
 use SalesDB;

 SELECT
 OrderID,
 CreationTime,
 FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format,
 FORMAT(CreationTime, 'dd-MM-yyyy')EURO_Formate ,
 FORMAT(CreationTime, 'dd') dd,
 FORMAT(CreationTime, 'ddd') ddd,
 FORMAT(CreationTime, 'dddd') dddd,
 FORMAT(CreationTime, 'MM') MM,
 FORMAT(CreationTime, 'MMM') MMM,
 FORMAT(CreationTime, 'MMMM') MMMM
 FROM Sales.Orders

 /* SHOW craetion time using the format:
 Day WED JAN Q1 2025 12:34:56 PM
 */

 SELECT
 OrderID,
 CreationTime,
 'Day ' + FORMAT(CreationTime, 'ddd MMM ') +
 'Q'+ DateName(quarter, CreationTime) +
 FORMAT(CreationTime, ' yyyy hh:mm:ss tt')  CustomFormat 
 FROM Sales.Orders

 SELECT
 FORMAT(OrderDate, 'MMM yy') OrderDate,
 COUNT(*)
 FROM Sales.Orders
 GROUP BY FORMAT(OrderDate, 'MMM yy')

 -- IN convert we can do both formating and casting  
 SELECT
 CreationTime,
 CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],
 CONVERT(VARCHAR, CreationTime, 32) as [USA Std. Style:32],
 CONVERT(VARCHAR, CreationTime, 34) as [EURO Std. Style:34]
 FROM Sales.Orders

 --CAST () 
 -- CONVERTs a value to a specified data type.

 SELECT
 CAST('123' AS INT) AS [String to interger],
 CAST (123 as VARCHAR) AS [Int to String],
 CAST('2025-08-20' AS DATE) AS [String to Date],
 CAST('2025-08-20' AS DATETIME2) AS [String to Datetime],
 CreationTime,
 CAST(CreationTime as DATE) as [Datetime to Date]
 From Sales.Orders

 -- DATEADD ()
 -- Adds or substracts a specific time interval to from a date.

 SELECT 
 OrderId,
 OrderDate,
  DATEADD( day, -10, OrderDate)  AS TenDaysBefore,
  DATEADD( month, 3, OrderDate)  AS ThreemonthLater,
 DATEADD( year, 2, OrderDate)  AS TWOYEARSLater
 FROM Sales.Orders

 -- DATEDIFF()
 -- Find the difference between two dates.
 -- CAlculate the age of employees

 SELECT
 EmployeeID,
 BirthDate,
 DATEDIFF(year, BirthDate, GETDATE()) Age
 FROM Sales.Employees
 
 --Find the average shipping duration in days for each month
 SELECT
 MONTH(OrderDate) AS OrderDate,
 AVG(DATEDIFF(day, OrderDate, ShipDate)) AvgShip
 FROM Sales.Orders
 GROUP BY MONTH(OrderDate)

 --find the number of days between each order and previous order.
 --LAG() ACCESS a value form the previous row
 SELECT
 Orderdate CurrentOrderDate,
 LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,
 DATEDIFF(day,LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) Nrofdays
 FROM Sales.Orders

 --Date Validation
 --Is Date()
 -- check if value is a date.
 --return 1 if the string value is a valid date.

 SELECT 
 ISDATE('123') DateCheck1,
 ISDATE('2025-08-20') DateCheck2,
  ISDATE('1998') DateCheck3


  -- ISNULL and COALESCE
SELECT 
ISNULL(Shipaddress,'unknown')
from Sales.Orders;

SELECT 
Coalesce(Shipaddress,BillAddress, 'unknown')
from Sales.Orders;

-- isnull is limited to two values, but it is fast
-- Coalesce unlimited values but it is slow.
-- Coalesce is available in all databases.
-- isnull is changed as per databases.

use SalesDB

SELECT * 
from Sales.Orders

-- Find the average score for the customers
-- OVER() is window function we can use to show average value
-- in each row.


SELECT 
CustomerID,
Score, 
AVG(Score) over() Avgscore,
AVG(Coalesce(Score,0))over() Avgscore2
From Sales.Customers;


-- ISNULL | COALESCE
-- USE CASE :- Habdle the null before doing mathematical operations.
-- NULL + 5 -> NULL
--NULL + 'b' -> NULL


/*Display the fulll name of customers in a single field
by merging their first and last names,
and add 10 bonus points to each customer's score.
*/
SELECT*
from Sales.Customers;

SELECT 
CustomerID,
FirstName + ' ' + COALESCe(LastName, '') as fullname,
SCORE,
COALESCE(Score, 0 ) + 10 as NewScore
From Sales.Customers;

-- use case:- handle the null before joining tables.
-- uSE CASE:- handle the null before shorting the data.

-- SORT the customers from lowest to highest scores,
--with nulls appearing last

SELECT
CustomerID,
CASE WHEN SCORE IS NULL THEN 1 ELSE 0 END Flag,
SCORE
FROM Sales.Customers
ORDER BY CASE WHEN SCORE IS NULL THEN 1 ELSE 0 END,
SCORE ASC;


--NULLIF() function
-- COMPARE two expressions return:- 
-- -null ,if they are equal.
-- -first expression, if they are not equal.

-- --USE CASE
-- Preventing the error of dividing by zero.

/* Find the sales price for each order by dividing the
sales by quantity.
*/
SELECT *
from Sales.Orders;

SELECT 
OrderID,
Sales,
Quantity,
Sales/NULLIF(Quantity,0) as Price
FROM Sales.Orders;

-- IS NULL () function
-- Return TRUE if the  value IS NULL,
-- otherwise it returns FALSE.

-- Isentify the customers who have no score
SELECT * 
from Sales.Customers
where score is null 

--list all customers who have scores 
SELECT * 
from Sales.Customers
where score is not null 

--list all details for customers who have not placed any orders
Select 
c.*,
o.OrderID
from Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
where o.CustomerID is null

use SalesDB
select * from Sales.Orders
select * from Sales.Customers

-- Null vs empty string vs blank spaces 

With Orders AS (
SELECT  1 Id, 'A' Category UNION 
Select 2, NULL UNION
Select 3, '' union
select 4, '  ' 
)
Select 
*,
TRIM(Category) Policy1,
NULLIF(TRIM(Category) ,'') Policy2,
COALESCE(NULLIF(TRIM(Category) ,'') , 'unknown') Policy3
from Orders

/*
null means unknown , special marker , very minimal ,  Best ,is null 
empty string known empty values, string(0),  occupies memory , fast, = ''
blank space values,  string(1 or more), occupies memory each space , slow on performance, = ' '
*/

--Data Policies
 -- Set of rules that defines how data should be handled
 --  #1 Data Policy
 -- only use null and empty string but avoid blank spaces.

-- Trim remove unwanted leading and trailing spaces from a string

--#2 Data Policy
-- Only use NULLS and avoid empty strings and blank spaces

--#3 Data policy
-- Use the default value 'unknown '
--and avoid using , nulls, empty strings and blank spaces.

-- #2 Data policy use case
-- replacing empty strings and blanks with null during data preparation before inserting into a database to optimize storage and performance.

-- #3  Data policy use case 
-- replacing empty strings, blanks , null with default value during data preparation before using it in reporting to improve readibility and reduce confusion

-- Case statements:- 


-- TASK:- Generate a report showing the total sales for each category:
-- High :- if the sales higher than 50
-- Medium :- if the sales between 20 and 50
-- Low :- if the sales equal or lower than 20
-- Sort the result from lowest to highest.

Select 
Category,
Sum(Sales) as TotalSales
from(
	SELECT 
	OrderID,
	Sales,
	CASE
		When Sales > 50 THEN 'High'
		When Sales > 20 Then 'Medium'
		Else 'Low'
	ENd Category
	FROM Sales.Orders
)t
GROUP BY Category
Order By TotalSales DESC

-- The Data Type of the result must be matching
-- Mapping:- Transform the values from one form to another

-- Task :- retrive employees details with gender displayed as full text

SELECT
EmployeeID,
FirstName,
LastName,
Gender,
Case
	when Gender = 'F' THEN 'Female'
	WHEN Gender = 'M' THEN 'Male'
	Else 'Not Available'
END GenderFullText
FROM Sales.Employees

-- Retrive customer details with abbreviated country code
  
SELECT
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE 
		WHEN Country = 'Germany' Then 'DE'
		when Country = 'USA' THEN 'US'
		Else 'N/A'
	END CountryAbbr
FROM Sales.Customers

SELECT Distinct Country FROM Sales.Customers   

--Handling nulls :- Replace Nulls with a specific value.

-- TASk :- Find the average scores of customers and treat nulls as O
--and additionally provide details such CustomerID & LastName.

Select 
CustomerID,
LastName,
Score,
CASE 
	when score is null then 0
	else score
END Scoreclean,
AVG(CASE 
		when score is null then 0
		else score
	END) over() AvgCustomerClean,
AVG(Score) over() AvgCustomer
from Sales.Customers

--Conditional Aggregation
--Apply aggregate functions only on subsets of data that fulfill certain conditions 

--Count how many times each customer has made an order with sales greater than 30.
SELECT
OrderID,
CustomerID,
Sales
from 



