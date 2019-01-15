select	Name, ListPrice,
		first_value(Name) over (order by ListPrice asc)
from	Production.Product
where	ProductSubcategoryID = 37

-- vaje
-- 1 naloga
-- SHOW the number of units sold for each product by year, along
-- with the prior year’s sales and the next year’s sales. 
select	d.ProductID, max(year(h.OrderDate)) as 'date', sum(d.OrderQty) as 'current',
		lag(sum(d.OrderQty), 1, 0) over (partition by d.ProductID order by d.ProductID) as previous,
		lead(sum(d.OrderQty), 1, 0) over (partition by d.ProductID order by d.ProductID) as next
from	sales.SalesOrderDetail as d join sales.SalesOrderHeader as h
		on h.SalesOrderID = d.SalesOrderID
group by d.ProductID, year(h.OrderDate)
order by productID, date

-- 2 naloga
-- SHOW the number of units sold for each product for three days at a time
select	d.ProductID,
		max(convert(date, h.OrderDate)) as 'day',
		sum(OrderQty) as 'current',
		lag(sum(OrderQty), 1, 0) over (partition by ProductID order by OrderDate) as previous1,
		lag(sum(OrderQty), 2, 0) over (partition by ProductID order by OrderDate) as previous2,
		lag(sum(OrderQty), 3, 0) over (partition by ProductID order by OrderDate) as previous3
from	sales.SalesOrderDetail as d join sales.SalesOrderHeader as h
		on h.SalesOrderID = d.SalesOrderID
group by d.ProductID, h.OrderDate
order by ProductID, h.OrderDate


-- 3 naloga
-- show each employee’s pay history in chronological order: show pay rate and the
-- date it took effect, as well as the original pay rate for this employee
select	BusinessEntityID,
		RateChangeDate,
		Rate,
		FIRST_VALUE(Rate) over (partition by BusinessEntityID order by RateChangeDate asc) as 'OriginalRate'
from	HumanResources.EmployeePayHistory
order by BusinessEntityID, RateChangeDate desc


-- 4 naloga
-- compute the percentage increase from the original pay rate and include only those
-- records that represent changes in pay in the result. (The query SHOULD also include
-- the date for the original pay rate.)
select	BusinessEntityID,
		RateChangeDate,
		Rate,
		first_value(Rate) over (partition by BusinessEntityID order by RateChangeDate asc) as '%'
from	HumanResources.EmployeePayHistory


-- vaja
select	BusinessEntityID, PersonType, FirstName,
		LAST_VALUE(FirstName) over 
			(partition by PersonType order by FirstName rows between unbounded preceding and unbounded following)
from	person.Person