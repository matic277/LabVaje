/*
	1 naloga
	Using a derived table, join the Sales.SalesOrderHeader table to the Sales.SalesOrderDetail table.
	Display the SalesOrderID, OrderDate, and ProductID columns in the results. The Sales.SalesOrderDetail
	table should be inside the derived table query.
*/
select	*
from	sales.SalesOrderDetail as sod
		join (
			select	SalesOrderID
			from	sales.SalesOrderHeader
		) as soh
		on soh.SalesOrderID=sod.SalesOrderID

-- 2 naloga
-- Rewrite the query in question 1 with a common table expression.
with tmpTable as (
	select	*
	from	sales.SalesOrderHeader
)
select	t.SalesOrderID, t.OrderDate
from	sales.SalesOrderDetail as sod
		join tmpTable as t
		on t.SalesOrderID=sod.SalesOrderID

/*
	3 naloga
	Write a query that displays all customers along with the orders placed in 2005.
    Use a common table expression to write the query and include the CustomerID,
    SalesOrderID, and OrderDate columns in the results.
*/
with customers as (
	select	*
	from	person.person
)
select	*
from	sales.SalesOrderHeader as soh
		join customers as c
		on c.BusinessEntityID = soh.CustomerID
where	year(soh.OrderDate) = 2011

