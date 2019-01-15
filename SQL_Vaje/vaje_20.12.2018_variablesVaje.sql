-- 1 naloga
-- Write a script that declares an integer variable called @myInt.
-- Assign 10 to thevariable, and then print it.

declare @myInt INT;
set @myInt = 10;
print @myInt


-- 2 naloga
-- Write a script that declares a VARCHAR(20) variable called @myString.
-- Assign “This is a test” to the variable, and print it.
declare @myString VARCHAR(20);
set @myString = 'This is a test';
print @myString

-- 3 naloga
-- Write a script that declares two integer variables called @MaxID and @MinID.
-- Use the variables to print the highest and lowest SalesOrderID values from the Sales.SalesOrderHeader table.
declare @maxid int;
declare @minid int;

set @maxid = (
	select	max(h.SalesOrderID)
	from	sales.SalesOrderHeader as h
)

set @minid = (
	select	min(h.SalesOrderID)
	from	sales.SalesOrderHeader as h
)

print @maxid
print @minid



-- 4 naloga
-- Write a script that declares an integer variable called @ID.
-- Assign the value 70000 to the variable. Use the variable in a SELECT statement that returns all the rows
-- from the Sales.SalesOrderHeader table that have a SalesOrderID greater than the value of the variable.

declare @id int = 70000;

select	*
from	sales.SalesOrderHeader
where	SalesOrderID >= @id


-- 5 naloga
-- Write a script that declares three variables, one integer variable called @ID, a NVARHCAR(50)
-- variable called @FirstName, and a VARCHAR(50) variable called @LastName. Use a SELECT statement
-- to set the value of the variables with the row from the Person.Person table with BusinessEntityID = 1.
-- Print a statement in the “BusinessEntityID: FirstName LastName” format.

declare @id int;
declare @firstName varchar(50);
declare @lastName varchar(50);

select	@firstName = p.FirstName,
		@lastName = p.LastName,
		@id = p.BusinessEntityID
from	person.person as p
where	p.BusinessEntityID = 1

print (cast(@id as varchar) + ': ' + @firstName + ' ' + @lastName)


-- 6 naloga
-- Write a script that declares an integer variable called @SalesCount.
-- Set the value of the variable to the total count of sales in the Sales.SalesOrderHeader table.
-- Use the variable in a SELECT statement that shows the difference between the @SalesCount and
-- the count of sales by customer.

declare @salesCount int;

set @salesCount = (
	select	count(SalesOrderID)
	from	sales.SalesOrderHeader
)

print @salesCount

select	CustomerID,
		count(CustomerID) as StNakupou,
		(@salesCount - count(CustomerID)) as Razlika,
		@salesCount as salesCount
from	sales.SalesOrderHeader
group by CustomerID
order by StNakupou desc

