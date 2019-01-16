select	*
from	dbo.demoProduct

-- 1 naloga
insert into dbo.demoProduct  (ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)

select	ProductID, Name, Color, StandardCost, ListPrice, Size, Weight
from	production.Product as pp
order by pp.ProductID
offset 0 rows fetch next 5 rows only



-- 2 naloga
-- (isto kot prva)
insert into dbo.demoProduct  (ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)

select	ProductID, Name, Color, StandardCost, ListPrice, Size, Weight
from	production.Product as pp
order by pp.ProductID
offset 5 rows fetch next 5 rows only

-- 3 naloga
insert into dbo.demoSalesOrderHeader (SalesOrderID, /*SalesID - skip beucase its set as identity*/ OrderDate,
									  CustomerID, SubTotal, TaxAmt, Freight,
									  DateEntered, SalesNumber /*TotalDue - computed by default*/ /*RV - timestamp, by default is getdate*/)
select	SalesOrderID, OrderDate, CustomerID, SubTotal, TaxAmt, Freight,
		getdate() /*for DateEntered*/, substring(SalesOrderNumber, 3, LEN(SalesOrderNumber)) /*converting from 'SO12345' to '12345'*/
from	sales.SalesOrderHeader as s

select	*
from	dbo.demoSalesOrderHeader

-- 4 naloga
-- dbo will be created on the fly if it doesnt exist
select	h.CustomerID as CustomerID, count(*) as NumberOfOrdersPlaces, sum(h.TotalDue) as TotalDue
into dbo.tempCustomerSales
from	sales.Customer as c
		join sales.SalesOrderHeader as h
		on c.CustomerID = h.CustomerID
group by h.CustomerID

select	*
from	dbo.tempCustomerSales

-- 5 naloga
-- (tabela dbo.DemoProduct ze obstaja zato najprej insert into)
insert into dbo.DemoProduct (ProductID, Name, Color, StandardCost, ListPrice, Size, Weight)
select	pp.ProductID, pp.Name, pp.Color, pp.StandardCost, pp.ListPrice, pp.Size, pp.Weight
from	Production.Product pp
where	not exists (
				select	ProductID
				from	dbo.demoProduct
				where	ProductID = pp.ProductID
			)


