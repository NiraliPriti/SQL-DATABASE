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


