--- Listing 11-8. Using the MERGE Statement
--1
IF OBJECT_ID('dbo.CustomerSource') IS NOT NULL BEGIN
DROP TABLE dbo.CustomerSource;
END;
IF OBJECT_ID('dbo.CustomerTarget') IS NOT NULL BEGIN
DROP TABLE dbo.CustomerTarget;
END;
--2
CREATE TABLE dbo.CustomerSource (CustomerID INT NOT NULL PRIMARY KEY,
Name VARCHAR(150), PersonID INT NOT NULL);
CREATE TABLE dbo.CustomerTarget (CustomerID INT NOT NULL PRIMARY KEY,
Name VARCHAR(150), PersonID INT NOT NULL);
--3
INSERT INTO dbo.CustomerSource(CustomerID,Name,PersonID)
SELECT CustomerID,
p.FirstName + ISNULL(' ' + p.MiddleName,'') + ' ' + p.LastName,
PersonID
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID IN (29485,29486,29487,10299);
--4
INSERT INTO dbo.CustomerTarget(CustomerID,Name,PersonID)
SELECT CustomerID, p.FirstName + ' ' + p.LastName, PersonID
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID IN (29485,29486,21139);
--5
SELECT CustomerID, Name, PersonID
FROM dbo.CustomerSource
ORDER BY CustomerID;
--6
SELECT CustomerID, Name, PersonID
FROM dbo.CustomerTarget
ORDER BY CustomerID;

-- merge statement
MERGE	dbo.CustomerTarget AS t
USING	dbo.CustomerSource AS s
		ON (s.CustomerID = t.CustomerID)
WHEN MATCHED -- AND s.Name != t.Name
THEN UPDATE SET Name = s.Name
WHEN NOT MATCHED BY TARGET
THEN INSERT (CustomerID, Name, PersonID) VALUES (CustomerID, Name, PersonID)
WHEN NOT MATCHED BY SOURCE
THEN DELETE
OUTPUT $action, DELETED.*, INSERTED.*;--semi-colon is required
--8
SELECT CustomerID, Name, PersonID
FROM dbo.CustomerTarget
ORDER BY CustomerID;


-- naloge

-- prerequirement
IF OBJECT_ID('Department_Source', 'U') IS NOT NULL
   DROP TABLE dbo.Department_Source;
IF OBJECT_ID('Department_Target', 'U') IS NOT NULL
   DROP TABLE dbo.Department_Target;

CREATE TABLE [dbo].[Department_Source]
(
   [DepartmentID] [SMALLINT] NOT NULL,
   [Name] VARCHAR(50) NOT NULL,
   [GroupName] VARCHAR(50) NOT NULL,
   [ModifiedDate] [DATETIME] NOT NULL
) ON [PRIMARY];
GO
CREATE TABLE [dbo].[Department_Target]
(
   [DepartmentID] [SMALLINT] NOT NULL,
   [Name] VARCHAR(50) NOT NULL,
   [GroupName] VARCHAR(50) NOT NULL,
   [ModifiedDate] [DATETIME] NOT NULL
) ON [PRIMARY];
GO
---Insert some test values
INSERT INTO [dbo].[Department_Source]
(
   [DepartmentID],
   [Name],
   [GroupName],
   [ModifiedDate]
)
VALUES
(
   1, 'Engineering', 'Research and Development', GETDATE()
);

---Checking the Source Table Data
SELECT  * FROM  [Department_Source];
SELECT  * FROM  [Department_Target];

---For excercise number 5
--Inserting records into target table
INSERT INTO [dbo].[Department_Target]
(
   [DepartmentID],
   [Name],
   [GroupName],
   [ModifiedDate]
)
VALUES
( 3, 'Sales', 'Sales & Marketing', GETDATE()),
( 1, 'Engineering', 'IT', GETDATE());

--Inserting  records into target table
INSERT INTO [dbo].[Department_Source]
(
   [DepartmentID],
   [Name],
   [GroupName],
   [ModifiedDate]
)
VALUES
(   2, 'Marketing', 'Sales & Marketing', GETDATE()),
(   1, 'Engineering', 'IT', GETDATE());

---Checking the Source Table
SELECT  * FROM  [Department_Source];

---Checking the Target Table
SELECT  * FROM  [Department_Target];


------

-- 1 naloga
-- Capture OUTPUT Clause Results for WHEN NOT MATCHED THEN
merge	dbo.department_target as t
using	dbo.department_source as s
		on t.DepartmentID = s.DepartmentID
when	not matched by target
then	insert (DepartmentID, Name, GroupName, ModifiedDate) values (DepartmentID, Name, GroupName, ModifiedDate)
output	$action, inserted.*;

-- 2 naloga
-- UPDATE  [Department_Source] SET GroupName = 'IT' WHERE  DepartmentID = 1;
-- Capture OUTPUT clause Results for WHEN MATCHED THEN
UPDATE  [Department_Source] SET GroupName = 'IT' WHERE  DepartmentID = 1;

merge	dbo.department_target as t
using	dbo.department_source as s
		on t.DepartmentID = s.DepartmentID
when	matched
then	update set GroupName = s.GroupName
output	$action, deleted.*, inserted.*;

-- 3 naloga
-- Insert into [dbo].[Department_Target]([DepartmentID],[Name],[GroupName],[ModifiedDate])
-- Values(3, 'Sales', 'Sales & Marketing', getdate())
-- Capture OUTPUT Clause Results for WHEN MATCHED BY SOURCE THEN

-- 4 naloga
-- delete the records from target table which does not exists in source table.
merge	dbo.department_target as t
using	dbo.department_source as s
		on t.DepartmentID = s.DepartmentID
when	not matched by source
then	delete
output	$action, deleted.*, inserted.*;

-- 5 naloga
-- insert, update, and delete records in the target table as per the MERGE conditions.
merge	dbo.department_target as t
using	dbo.department_source as s
		on t.DepartmentID = s.DepartmentID and t.GroupName = s.GroupName
		-- joinami tudi po group name, ker sta dva zapisa z istim imenom in razlicnim groupname-om
when	not	matched by target
then	insert (DepartmentID, Name, GroupName, ModifiedDate) values (DepartmentID, Name, GroupName, ModifiedDate)
when	not matched by source
then	delete
output	$action, deleted.*, inserted.*;

