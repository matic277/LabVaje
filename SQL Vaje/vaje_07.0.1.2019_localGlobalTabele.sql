-- local (en #)
-- glede na session (New Query = new session, bi lahko naredili novo)
use AdventureWorks2014
select	*
into	#tempLocal
from	[Person].Password

-- globalna (dva #)
-- glede na session (New Query = new session, bi že obstajala)
use AdventureWorks2014
select	*
into	##tempGlobal
from	[Person].Password

-- izpis
use tempdb
select	*
from	SYS.tables

-- vaje
use AdventureWorks2014

-- 1 naloga
-- Create a temp table called #CustomerInfo that contains CustomerID, FirstName, and LastName columns.
-- Include CountOfSales and SumOfTotalDue columns. Populate the table with a query using the
-- Sales.Customer, Person.Person, and Sales.SalesOrderHeader tables.

select	max(sc.CustomerID) as CustomerID, max(FirstName) as FirstName, max(LastName) as LastName,
		count(*) as CountOfSales, sum(TotalDue) as SumOfTotalDue 
into	#customerInfo
from	Sales.SalesOrderHeader as soh join Sales.Customer as sc
		on soh.CustomerID = sc.CustomerID
		join Person.Person as pp
		on pp.BusinessEntityID = sc.PersonID
group by sc.CustomerID


-- 2 naloga
-- Change the code written in question 1 to use a table variable instead of a temp table.

declare @tmp TABLE (
	CustomerID int,
	FirstName varchar(50),
	LastName varchar(50),
	CountOfSales int,
	SumOfTotalDue int
);

insert into @tmp 
	select	max(sc.CustomerID) as CustomerID, max(FirstName) as FirstName, max(LastName) as LastName,
			count(*) as CountOfSales, sum(TotalDue) as SumOfTotalDue 
	from	Sales.SalesOrderHeader as soh join Sales.Customer as sc
			on soh.CustomerID = sc.CustomerID
			join Person.Person as pp
			on pp.BusinessEntityID = sc.PersonID
	group by sc.CustomerID

select * from @tmp

-- 3 naloga
-- Create a table variable with two integer columns, one of them an IDENTITY column. Use a WHILE loop
-- to populate the table with 1,000 random integers using the following formula. Use a second WHILE loop
-- to print the values from the table variable one by one.
-- CAST(RAND() * 10000 AS INT) + 1







