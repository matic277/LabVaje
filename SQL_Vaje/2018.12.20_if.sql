-- 1 naloga
-- Write a batch that declares an integer variable called @Count to save the count of all
-- the Sales.SalesOrderDetail records. Add an IF block that that prints “Over 100,000”
-- if the value exceeds 100,000. Otherwise, print “100,000 or less.”

declare @count int;

select	@count = count(*)
from	sales.SalesOrderDetail

if @count > 100000 print 'over 100,000'
else print '100,000 or less'


-- 2 naloga
-- Write a batch that contains nested IF blocks. The outer block should check to see whether
-- the month is October or November. If that is the case, print “The month is ” and the month name.
-- The inner block should check to see whether the year is even or odd and print the result.
-- You can modify the month to check to make sure the inner block fires.

declare @date varchar(50) = getdate()

declare @month varchar(50) = datename(month, @date)

if (@month = 'October' or @month = 'November') begin
	print ('The month is ' + @month)
	declare @year int = year(@date)

	if (@year % 2 = 0) print @year
end


-- 3 naloga
-- Write a batch that uses IF EXISTS to check to see whether there is a row in the Sales.
-- SalesOrderHeader table that has SalesOrderID = 1. Print “There is a SalesOrderID = 1” or
-- “There is not a SalesOrderID = 1” depending on the result.

if exists (
	select	*
	from	sales.SalesOrderHeader
	where	SalesOrderID = 1
) print 'There is salesorderID = 1'
else print 'There is not a SalesOrderID = 1'