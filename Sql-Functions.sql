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

