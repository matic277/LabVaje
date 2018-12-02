-- 1 naloga
-- Write a query using a WHERE clause that displays all the employees listed in the
-- HumanResources.Employee table who have the job title Research and
-- Development Engineer. Display the business entity ID number, the login ID, and the title for each one
SELECT	businessEntityID, LoginID, JobTitle
FROM	HumanResources.Employee
WHERE 	JobTitle = 'Research and Development Engineer'

-- 2 naloga
-- Write a query using a WHERE clause that displays all the names in Person.Person
-- with the middle name J. Display the first, last, and middle names along with the ID
-- numbers.
SELECT	[FirstName], [MiddleName], [LastName], [BusinessEntityID]
FROM	Person.Person
WHERE	MiddleName = 'J.'

-- 3 naloga
-- Rewrite the query you wrote in question 1, changing it so that the employees who
-- do not have the title Research and Development Engineer are displayed
SELECT	businessEntityID, LoginID, JobTitle
FROM	HumanResources.Employee
WHERE	JobTitle != 'Research and Development Engineer'

-----------------------------------------------------------

-- 1 naloga
-- Write a query that displays the product ID and name for each product from the
-- Production.Product table with a name starting with Chain
select	[ProductID], [Name]
from	Production.Product
where name like 'CHAIN%'

-- 2 naloga
-- Write a query like the one in question 1 that displays the products with Paint in   the name
select	[ProductID], [Name]
from	Production.Product
where name like '%paint%'

-- 3 naloga
-- Change the last query so that the products without Paint in the name are displayed
select	[ProductID], [Name]
from	Production.Product
where name not like '%paint%'

-----------------------------------------------------------

-- 1 naloga
-- Write a query displaying the ProductID, Name, and Color columns from rows in the Production.Product table.
-- Display only those rows where no color has been assigned
SELECT	ProductID, Name, Color
FROM	Production.Product
WHERE	color IS NULL

-- 2 naloga
-- Write a query displaying the ProductID, Name, and Color columns from rows in the Production.Product table.
-- Display only those rows in which the color is known not to be blue.
SELECT	ProductID, Name, Color
FROM	Production.Product
WHERE	color != 'blue' AND color IS NOT NULL

-- 3 naloga
-- Write a query displaying ProductID, Name, Style, Size, and Color from the
-- Production.Product table. Include only the rows where at least one of the Style, Size, or 
-- Color columns contains a value
SELECT	ProductID, Style, SIZE, Color
FROM	Production.Product
WHERE	color IS NOT NULL OR
		style IS NOT NULL OR
		SIZE  IS NOT NULL


select	*
from	Production.ProductReview
where	contains (Comments, 'overall')


-----------------------------------------------------------

-- 1 naloga
-- Write a query that returns the business entity ID and name columns from the Person.Person table.
-- Sort the results by LastName, FirstName, and MiddleName.

select	BusinessEntityID, FirstName, MiddleName, LastName
from	person.person
order by FirstName, MiddleName, LastName

-- 2 naloga
-- Modify the query written in question 1 so that the data is returned in the opposite order
select	BusinessEntityID, FirstName, MiddleName, LastName
from	person.person
order by FirstName desc, MiddleName desc, LastName desc

-- 3 naloga
-- Modify the query written in question 1 so that you return only 10 rows starting at row 20
select	BusinessEntityID, FirstName, MiddleName, LastName
from	person.person
order by FirstName, MiddleName, LastName
offset 19 rows
fetch next 10 rows only
*

-- prva ne null vrednost
select coalesce(null, 1, null, 2) as value

