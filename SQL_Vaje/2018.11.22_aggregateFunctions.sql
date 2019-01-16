-- COUNT() ne steje NULL vrednosti
-- COUNT(*) steje tudi NULL vrednosti

-- 1 naloga
select	count(c.CustomerID)
from	sales.Customer as c

-- 2 naloga
select	sum(o.OrderQty)
from	sales.SalesOrderDetail as o

-- 3 naloga
select	max(o.UnitPrice)
from	sales.SalesOrderDetail as o

-- 4 naloga
select	avg(o.Freight)
from	sales.SalesOrderHeader as o

-- 5 naloga
select	max(p.ListPrice) as max, min(p.ListPrice) as min, avg(p.ListPrice) as avg
from	Production.Product as p

-- group by naloge

-- 1 naloga
select	s.ProductID, sum(s.OrderQty)
from	sales.SalesOrderDetail as s
group by s.ProductID

-- 2 naloga
select	s.salesOrderID as id, count(*) as count
from	sales.SalesOrderDetail as s
group by s.SalesOrderID

-- 3 naloga
select	p.ProductLine,  count(p.ProductID) as count
from	Production.Product as p
group by p.ProductLine

-- 4 naloga
select	year(s.OrderDate) as date, s.customerID as cID, count(*) as count
from	sales.SalesOrderHeader as s
group by year(s.OrderDate), s.CustomerID
order by cID

-- naloge z having

-- 1 naloga
select	COUNT(s.LineTotal) as count
from	Sales.SalesOrderDetail as s
group by s.SalesOrderID
having	COUNT(s.LineTotal) > 3

-- 2 naloga
select	SUM(s.LineTotal)
from	Sales.SalesOrderDetail as s
group by s.SalesOrderID
having	SUM(s.LineTotal) > 1000

-- 3 naloga
select	COUNT(p.productModelID) as count
from	Production.Product as p
group by p.productModelID
having	COUNT(p.productModelID) = 1

-- 4 naloga
select	COUNT(p.productModelID) as count, MAX(p.Color) as color
from	Production.Product as p
where	p.Color IS NOT NULL AND (p.Color = 'Blue' OR p.Color = 'Red')
group by p.productModelID


-- distinct

-- 1 naloga
select	count(distinct s.ProductID) as count
from	sales.SalesOrderDetail as s

-- 2 naloga
select	count(distinct s.territoryID)
from	sales.SalesOrderHeader as s
group by s.CustomerID


-- z joini

-- 1 naloga
select	concat_ws(' ', max(p.FirstName), max(p.LastName)) as Name, count(h.SalesOrderID) as numOfOrders
from	person.person as p
		join sales.customer as c
		on p.BusinessEntityID = c.PersonID
		join sales.SalesOrderHeader as h
		on h.CustomerID=c.CustomerID
group by c.PersonID
order by numOfOrders desc

--2 naloga
select	sum(ssd.OrderQty) as products, max(pp.name) as name, year(ssh.OrderDate) as year
from	sales.SalesOrderHeader as ssh
		join sales.SalesOrderDetail as ssd
		on ssh.SalesOrderID = ssd.SalesOrderID
		join Production.Product as pp
		on pp.ProductID = ssd.ProductID
group by ssd.ProductID, year(ssh.OrderDate)
order by name




