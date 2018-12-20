USE AdventureWorks2014;
GO
IF EXISTS (SELECT * FROM sys.objects
WHERE object_id = OBJECT_ID(N'dbo.demoSalesOrderDetail')
AND type in (N'U'))
DROP TABLE dbo.demoSalesOrderDetail;
GO
CREATE TABLE dbo.demoSalesOrderDetail(SalesOrderID INT NOT NULL,
SalesOrderDetailID INT NOT NULL, Processed BIT NOT NULL);
GO
SET ROWCOUNT 0;
INSERT INTO dbo.demoSalesOrderDetail(SalesOrderID,SalesOrderDetailID,Processed)
SELECT SalesOrderID, SalesOrderDetailID, 0
FROM Sales.SalesOrderDetail;
PRINT 'Populated work table';
SET ROWCOUNT 50000;
WHILE EXISTS(SELECT * From dbo.demoSalesOrderDetail WHERE Processed = 0) BEGIN
UPDATE dbo.demoSalesOrderDetail SET Processed = 1
WHERE Processed = 0;
PRINT 'Updated 50,000 rows';
END;
PRINT 'Done!';

-- razdelimo tabelo na 3 skupine
set ROWCOUNT 0
select	SalesOrderID, SalesOrderDetailID,
		ntile(3) over (order by SalesOrderID) as Skupina
from	sales.SalesOrderDetail

-- nested while
DECLARE @OuterCount INT = 1;
DECLARE @InnerCount INT;

WHILE @OuterCount < 10 BEGIN
	PRINT 'Outer Loop';
	SET @InnerCount = 1;

	WHILE @InnerCount < 5 BEGIN
		PRINT ' Inner Loop';
		SET @InnerCount += 1;
	END;

	SET @OuterCount += 1;
END;

-- continue, break

DECLARE @Count INT = 1;

WHILE @Count < 50 BEGIN
	PRINT @Count;

	IF @Count = 10 BEGIN
		PRINT 'Exiting the WHILE loop';
		BREAK;
	END;

	SET @Count += 1;
END;


DECLARE @Count INT = 1;

WHILE @Count < 10 BEGIN
	PRINT @Count;
	SET @Count += 1;

	IF @Count = 3 BEGIN
		PRINT 'CONTINUE';
		CONTINUE;
	END;

	PRINT 'Bottom of loop';
END;


-- vaje

-- 1 naloga
-- Write a script that contains a WHILE loop that prints out the letters A to Z.
-- Use the function CHAR to change a number to a letter. Start the loop with the value 65.
-- Here is an example that uses the CHAR function:
--   DECLARE @Letter CHAR(1);
--   SET @Letter = CHAR(65);
--   PRINT @Letter;
declare @intchar int = 65;

while (char(@intchar) != 'Z') begin
	print (char(@intchar))
	set @intchar = @intchar + 1
end


-- 2 naloga
-- Write a script that contains a WHILE loop nested inside another WHILE loop.
-- The counter for the outer loop should count up from 1 to 100. The counter for the inner loop
-- should count up from 1 to 5. Print the product of the two counters inside the inner loop.
declare @var1 int = 1;
declare @var2 int = 1;

while @var1 < 101 begin

	while @var2 < 6 begin
		print @var1 * @var2
		set @var2 = @var2 + 1
	end

	set @var1 = @var1 + 1
	set @var2 = 1
end


-- 3 naloga
-- Change the script in question 2 so the inner loop exits instead of printing when the counter
-- for the outer loop is evenly divisible by 5.
declare @var1 int = 1;
declare @var2 int = 1;

while @var1 < 101 begin

	while @var2 < 6 begin
		if (@var1 % 5 = 0) break
		print @var1 * @var2
		set @var2 = @var2 + 1
	end

	set @var1 = @var1 + 1
	set @var2 = 1
end


-- 4 naloga
-- Write a script that contains a WHILE loop that counts up from 1 to 100.
-- Print “Odd” or “Even” depending on the value of the counter.
declare @var int = 1;

while @var < 101 begin
	if (@var % 2 = 0) print 'even'
	else print 'odd'
	set @var = @var + 1
end

