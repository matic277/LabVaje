-- 1 naloga
select	hre.JobTitle, hre.BirthDate, pp.FirstName, pp.LastName
from	HumanResources.Employee as hre
		join Person.Person as pp
		on hre.BusinessEntityID=pp.BusinessEntityID

-- 2 naloga
select	CustomerID, StoreID, TerritoryID
from	sales.Customer as sc
		join person.Person as pp
		on sc.PersonID=pp.BusinessEntityID

-- 3 naloga
select	sc.CustomerID, StoreID, sc.TerritoryID, ss.SalesOrderID
from	sales.Customer as sc
		join person.Person as pp
		on sc.PersonID=pp.BusinessEntityID
		join Sales.SalesOrderHeader as ss
		on ss.CustomerID=sc.CustomerID

-- 4 naloga
select	*
from	sales.SalesOrderHeader as ss
		join sales.SalesPerson as ssp
		on ssp.BusinessEntityID = ss.SalesPersonID

-- -- --

-- 1 naloga
select	pp.ProductID, pp.Name, so.ProductID, so.OrderQty
from	Production.Product as pp
		left join sales.SalesOrderDetail as so
		on so.ProductID=pp.ProductID

-- 2 naloga
select	pp.ProductID, pp.Name, so.ProductID, so.OrderQty
from	Production.Product as pp
		join sales.SalesOrderDetail as so
		on so.ProductID=pp.ProductID

-- 3 naloga
select	soh.SalesPersonID, ss.SalesYTD
from	sales.SalesPerson as ss
		left join sales.SalesOrderHeader soh
		on soh.SalesPersonID=ss.BusinessEntityID

-- 4 naloga
select	soh.SalesPersonID, ss.SalesYTD, pp.FirstName
from	sales.SalesPerson as ss
		left join sales.SalesOrderHeader soh
		on soh.SalesPersonID=ss.BusinessEntityID
		inner join Person.Person as pp
		on pp.BusinessEntityID=ss.BusinessEntityID

-- 5 naloga
select	cr.CurrencyRateID, cr.AverageRate, soh.SalesOrderID, sm.ShipBase
from	sales.SalesOrderHeader as soh
		left join sales.CurrencyRate as cr
		on cr.CurrencyRateID=soh.CurrencyRateID
		join Purchasing.ShipMethod as sm
		on soh.ShipMethodID=sm.ShipMethodID

