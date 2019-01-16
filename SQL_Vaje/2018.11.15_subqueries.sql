-- 1 naloga
select	*
from	sales.SalesOrderDetail as sod
		join (
			select	SalesOrderID
			from	sales.SalesOrderHeader
		) as soh
		on soh.SalesOrderID=sod.SalesOrderID

-- 2 naloga
with tmpTable as (
	select	*
	from	sales.SalesOrderHeader
)
select	t.SalesOrderID, t.OrderDate
from	sales.SalesOrderDetail as sod
		join tmpTable as t
		on t.SalesOrderID=sod.SalesOrderID

-- 3 naloga
with customers as (
	select	*
	from	person.person
)
select	*
from	sales.SalesOrderHeader as soh
		join customers as c
		on c.BusinessEntityID = soh.CustomerID
where	year(soh.OrderDate) = 2011

