/*
-- 1 naloga
SELECT businessEntityID, LoginID, JobTitle
FROM HumanResources.Employee
WHERE  JobTitle = 'Research and Development Engineer'

-- 2 naloga
SELECT [FirstName], [MiddleName], [LastName], [BusinessEntityID]
FROM Person.Person
WHERE MiddleName = 'J.'

-- 3 naloga
SELECT businessEntityID, LoginID, JobTitle
FROM HumanResources.Employee
WHERE  JobTitle != 'Research and Development Engineer'
*/
-----------------------------------------------------------
/*
-- 1 naloga
select [ProductID], [Name]
from Production.Product
where name like 'CHAIN%'

-- 2 naloga
select [ProductID], [Name]
from Production.Product
where name like '%paint%'

-- 3 naloga
select [ProductID], [Name]
from Production.Product
where name not like '%paint%'
*/
-----------------------------------------------------------
/*
-- 1 naloga
SELECT	ProductID, Name, Color
FROM	Production.Product
WHERE	color IS NULL

-- 2 naloga
SELECT	ProductID, Name, Color
FROM	Production.Product
WHERE	color != 'blue' AND color IS NOT NULL

-- 3 naloga
SELECT	ProductID, Style, SIZE, Color
FROM	Production.Product
WHERE	color IS NOT NULL OR
		style IS NOT NULL OR
		SIZE  IS NOT NULL
*/

/*
select	*
from	Production.ProductReview
where	contains (Comments, 'overall')
*/

-----------------------------------------------------------
/*
-- 1 naloga
select	BusinessEntityID, FirstName, MiddleName, LastName
from	person.person
order by FirstName, MiddleName, LastName

-- 2 naloga
select	BusinessEntityID, FirstName, MiddleName, LastName
from	person.person
order by FirstName desc, MiddleName desc, LastName desc

-- 3 naloga
select	BusinessEntityID, FirstName, MiddleName, LastName
from	person.person
order by FirstName, MiddleName, LastName
offset 19 rows
fetch next 10 rows only
*/

-- prva ne null vrednost
select coalesce(null, 1, null, 2) as value

