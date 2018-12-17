-- Listing 11-6. Viewing the Manipulated Data with OUTPUT
USE AdventureWorks2014;
GO
--1
IF OBJECT_ID('dbo.Customers') IS NOT NULL BEGIN
DROP TABLE dbo.Customers;
END;
--2
CREATE TABLE dbo.Customers (CustomerID INT NOT NULL PRIMARY KEY,
Name VARCHAR(150),PersonID INT NOT NULL)
GO
--3
INSERT INTO	dbo.Customers(CustomerID, Name, PersonID)
OUTPUT		inserted.CustomerID, inserted.Name
SELECT		c.CustomerID, p.FirstName + ' ' + p.LastName, PersonID
FROM		Sales.Customer AS c
			INNER JOIN Person.Person AS p
			ON c.PersonID = p.BusinessEntityID;
-- 4
UPDATE c
SET		Name = p.FirstName + ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName
OUTPUT	deleted.CustomerID, deleted.Name AS OldName, inserted.Name AS NewName
FROM	dbo.Customers AS c
		INNER JOIN Person.Person AS p
		on c.PersonID = p.BusinessEntityID;
--5
DELETE FROM dbo.Customers
OUTPUT deleted.CustomerID, deleted.Name, deleted.PersonID
WHERE CustomerID = 11000;


--- Listing 11-7. Saving the Results of OUTPUT
USE AdventureWorks2014;
--1
IF OBJECT_ID('dbo.Customers') IS NOT NULL BEGIN
DROP TABLE dbo.Customers;
END;
IF OBJECT_ID('dbo.CustomerHistory') IS NOT NULL BEGIN
DROP TABLE dbo.CustomerHistory;
END;
--2
CREATE TABLE dbo.Customers (CustomerID INT NOT NULL PRIMARY KEY,
Name VARCHAR(150),PersonID INT NOT NULL)
CREATE TABLE dbo.CustomerHistory(CustomerID INT NOT NULL PRIMARY KEY,
OldName VARCHAR(150), NewName VARCHAR(150),
ChangeDate DATETIME);
GO
--3
INSERT INTO dbo.Customers(CustomerID, Name, PersonID)
SELECT c.CustomerID, p.FirstName + ' ' + p.LastName,PersonID
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p
ON c.PersonID = p.BusinessEntityID;
--4
UPDATE c SET Name = p.FirstName +
ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName
OUTPUT deleted.CustomerID,deleted.Name, inserted.Name, GETDATE()
INTO dbo.CustomerHistory
FROM dbo.Customers AS c
INNER JOIN Person.Person AS p on c.PersonID = p.BusinessEntityID;
--5
SELECT CustomerID, OldName, NewName,ChangeDate
FROM dbo.CustomerHistory;

-- naloge

-- 1 naloga
-- DECLARE @MyTableVar table( NewScrapReasonID smallint, Name varchar(50), ModifiedDate datetime).
-- Insert 'Operator error', GETDATE() into Production.ScrapReason and capture the output values into variable.
-- Display the result set of the table variable. Display the result set of the table.
declare @MyTableVar table( NewScrapReasonID smallint, Name varchar(50), ModifiedDate datetime)

insert into	Production.ScrapReason (Name, ModifiedDate)
output		inserted.ScrapReasonID, inserted.Name, inserted.ModifiedDate
	into	@MyTableVar
select		'Operation Error', GETDATE()

select	*
from	@MyTableVar

-- 2 naloga
-- DELETE ShoppingCartID = 20621 FROM Sales.ShoppingCartItem and show deleted records; 
DELETE FROM sales.ShoppingCartItem
output	deleted.*
WHERE	ShoppingCartID = 20621

-- 3 naloga
-- DECLARE @MyTableVar table( EmpID int NOT NULL, OldVacationHours int, NewVacationHours int, ModifiedDate datetime)
-- Increase VacationHours for 25 % for top 10 HumanResources.Employee. Capture result into @MyTableVar
declare @MyTableVar2 table( EmpID int NOT NULL, OldVacationHours int, NewVacationHours int, ModifiedDate datetime)

update	top (10) hre 
set		VacationHours = VacationHours * 1.25
output	inserted.BusinessEntityID, inserted.VacationHours, deleted.VacationHours, GETDATE()
	into @MyTableVar2
from	HumanResources.Employee as hre

select	*
from	@MyTableVar2



