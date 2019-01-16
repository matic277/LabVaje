-- deleting rows
-- DONT RUN THIS STATEMENT
/*
delete from Person.Person
where PersonType = 'something'
*/

-- deleting by pages

-- creating
--- Listing 6-9. Creating Demo Tables - deleting
USE AdventureWorks2014;
GO
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoProduct]')
AND type in (N'U'))
DROP TABLE [dbo].[demoProduct];
GO
SELECT * INTO dbo.demoProduct FROM Production.Product;
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoCustomer]')
AND type in (N'U'))
DROP TABLE [dbo].[demoCustomer];
GO
SELECT * INTO dbo.demoCustomer FROM Sales.Customer;
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoAddress]')
AND type in (N'U'))
DROP TABLE [dbo].[demoAddress];
GO
SELECT * INTO dbo.demoAddress FROM Person.Address;
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoSalesOrderHeader]')
AND type in (N'U'))
DROP TABLE [dbo].[demoSalesOrderHeader];
GO
SELECT * INTO dbo.demoSalesOrderHeader FROM Sales.SalesOrderHeader;
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoSalesOrderDetail]')
AND type in (N'U'))
DROP TABLE [dbo].[demoSalesOrderDetail];
GO
SELECT * INTO dbo.demoSalesOrderDetail FROM Sales.SalesOrderDetail;

-- naloge
-- Use the AdventureWorks2014 database to complete this exercise. Before starting the exercise,
-- run Listing 6-9 to recreate the demo tables. You can find the solutions in the Appendix.

-- 1 naloga
-- Write a query that deletes the rows from the dbo.demoCustomer table
-- where the LastName values begin with the letter S.


--select	pp.lastName, pp.BusinessEntityID
delete	dc
from	dbo.demoCustomer as dc
		join person.person as pp on pp.BusinessEntityID = dc.personID
where	pp.LastName like 's%'

-- 2 naloga
-- Delete the rows from the dbo.demoCustomer table if the customer has not placed an order or
-- if the sum of the TotalDue from the dbo.demoSalesOrderHeader table for the customer is less than $1,000
-- NEDELA PRAVILNO?

with tmp as (
	select	CustomerID
	from	sales.SalesOrderHeader as soh
	group by soh.CustomerID
	having	 sum(soh.TotalDue) < 1000
)
select	soh.CustomerID
from	sales.SalesOrderHeader as soh
where	not exists (
			select	CustomerID
			from	tmp
			where	tmp.CustomerID = soh.CustomerID
		)
group by soh.CustomerID

-- 3 naloga
-- Delete the rows from the dbo.demoProduct table that have never been ordered.

--select	*
delete dp
from	dbo.demoProduct as dp 
where not exists (
		select	ProductID
		from	sales.SalesOrderDetail as sod
		where	sod.ProductID = dp.ProductID
	)


-- UPDATING

-- povecamo nek stolpec (vse vrstice) za faktor 1.22
update	demoSalesOrderHeader
set		TotalDue = TotalDue * 1.22,
		SubTotal = SubTotal * 1.22
where	CustomerID = 30000


-- setting up database
--- Listing 6-13. Updating Data in a Table
USE AdventureWorks2014;
GO
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoPerson]')
AND type in (N'U'))
DROP TABLE [dbo].[demoPerson]
GO
SELECT * INTO dbo.demoPerson
FROM Person.Person
WHERE Title in ('Mr.', 'Mrs.', 'Ms.')
--1
SELECT BusinessEntityID, NameStyle, Title
FROM dbo.demoPerson
ORDER BY BusinessEntityID;


USE AdventureWorks2014;
GO
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoPersonStore]')
AND type in (N'U'))
DROP TABLE [dbo].[demoPersonStore]
GO
CREATE TABLE [dbo].[demoPersonStore] (
[FirstName] [NVARCHAR] (60),
[LastName] [NVARCHAR] (60),
[CompanyName] [NVARCHAR] (60)
);
INSERT INTO dbo.demoPersonStore (FirstName, LastName, CompanyName)
SELECT a.FirstName, a.LastName, c.Name
FROM Person.Person a
JOIN Sales.SalesPerson b
ON a.BusinessEntityID = b.BusinessEntityID
JOIN Sales.Store c
ON b.BusinessEntityID = c.SalesPersonID
--1
SELECT FirstName,LastName, CompanyName,
LEFT(FirstName,3) + '.' + LEFT(LastName,3) AS NewCompany
FROM dbo.demoPersonStore;


USE AdventureWorks2014;
GO
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'[dbo].[demoCustomerSummary]')
AND type in (N'U'))
DROP TABLE [dbo].[demoCustomerSummary];
GO
CREATE TABLE dbo.demoCustomerSummary (CustomerID INT NOT NULL PRIMARY KEY,
SaleCount INTEGER NULL,
TotalAmount MONEY NULL);
GO
INSERT INTO dbo.demoCustomerSummary (CustomerID, SaleCount,TotalAmount)
SELECT BusinessEntityID, 0, 0
FROM dbo.demoPerson;
GO

-- naloge
-- Use the AdventureWorks2014 database to complete this exercise.
-- Run the code in Listing 6-9 to recreate tables used in this exercise. 

-- 1 naloga
-- Write an UPDATE statement that changes all NULL values of the AddressLine2 column
-- in the dbo.demoAddress table to N/A.
update	da
set		AddressLine2 = 'N/A'
from	dbo.demoAddress as da
where	AddressLine2 is null

select * from dbo.demoAddress

-- 2 naloga
-- Write an UPDATE statement that increases the ListPrice of every product in the dbo.demoProduct table by 10 percent.
update	dp
set		ListPrice = ListPrice * 1.1
from	dbo.demoProduct as dp

-- 3 naloga
-- Write an UPDATE statement that corrects the UnitPrice and LineTotal of each row of the
-- dbo.demoSalesOrderDetail table by joining the table on the dbo.demoProduct table.

-- (setting the unitprice from salesorderdetail to listpride from demoproduct)
update	sod
set		sod.UnitPrice = dp.ListPrice
from	dbo.demoSalesOrderDetail as sod join dbo.demoProduct as dp
		on dp.ProductID = sod.ProductID

-- (recalculating linetotal in salesorderdetail)
update	sod
set		sod.Linetotal = sod.OrderQty * sod.UnitPrice
from	dbo.demoSalesOrderDetail as sod

select * from dbo.demoSalesOrderDetail

-- 4 naloga
-- Write an UPDATE statement that updates the SubTotal column of each row of the dbo.demoSalesOrderHeader
-- table with the sum of the LineTotal column of the dbo.demoSalesOrderDetail table.
with tmp as (
	select	sum(LineTotal) as ssum, SalesOrderID
	from	dbo.demoSalesOrderDetail
	group by SalesOrderID
)
update	soh
set		soh.SubTotal = tmp.ssum
from	dbo.demoSalesOrderHeader as soh join
		tmp on tmp.SalesOrderID = soh.SalesOrderID

select * from dbo.demoSalesOrderHeader

select * from dbo.demoSalesOrderDetail