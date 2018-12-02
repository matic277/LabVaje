
/*
	1 naloga
	The HumanResources.Employee table does not contain the employee names.
	Join that table to the Person.Person table on the BusinessEntityID column.
	Display the job title, birth date, first name, and last name.
*/
select	hre.JobTitle, hre.BirthDate, pp.FirstName, pp.LastName
from	HumanResources.Employee as hre
		join Person.Person as pp
		on hre.BusinessEntityID=pp.BusinessEntityID

/*
	2 naloga
	The customer names also appear in the Person.Person table.
	Join the Sales.Customer table to the Person.Person table.
	The BusinessEntityID column in the Person.Person table matches the
	PersonID column in the Sales.Customer table. Display the CustomerID, StoreID
	and TerritoryID columns along with the name columns.
*/
select	CustomerID, StoreID, TerritoryID
from	sales.Customer as sc
		join person.Person as pp
		on sc.PersonID=pp.BusinessEntityID

/*
	3 naloga
	Extend the query written in question 2 to include the Sales.SalesOrderHeader table.
	Display the SalesOrderID column along with the columns already specified.
	The Sales.SalesOrderHeader table joins the Sales.Customer table on CustomerID.
*/
select	sc.CustomerID, StoreID, sc.TerritoryID, ss.SalesOrderID
from	sales.Customer as sc
		join person.Person as pp
		on sc.PersonID=pp.BusinessEntityID
		join Sales.SalesOrderHeader as ss
		on ss.CustomerID=sc.CustomerID

/*
	4 naloga
	Write a query that joins the Sales.SalesOrderHeader table to the Sales.SalesPerson table.
	Join the BusinessEntityID column from the Sales.SalesPerson table to theSalesPersonID column in the Sales.
*/
select	*
from	sales.SalesOrderHeader as ss
		join sales.SalesPerson as ssp
		on ssp.BusinessEntityID = ss.SalesPersonID

-- -- --

/*
	1 naloga
	Write a query that displays all the products along with the SalesOrderID even if
	an order has never been placed for that product. Join to the Sales.SalesOrderDetail
	table using the ProductID column.
*/
select	pp.ProductID, pp.Name, so.ProductID, so.OrderQty
from	Production.Product as pp
		left join sales.SalesOrderDetail as so
		on so.ProductID=pp.ProductID

/*
	2 naloga
	Change the query written in step 1 so that only products that have
	not been ordered show up in the query.
*/
select	pp.ProductID, pp.Name, so.ProductID, so.OrderQty
from	Production.Product as pp
		join sales.SalesOrderDetail as so
		on so.ProductID=pp.ProductID

/*
	3 naloga
	Write a query that returns all the rows from the Sales.SalesPerson table joined
	to the Sales.SalesOrderHeader table along with the SalesOrderID column even if
	no orders match. Include the SalesPersonID and SalesYTD columns in the results.
*/
select	soh.SalesPersonID, ss.SalesYTD
from	sales.SalesPerson as ss
		left join sales.SalesOrderHeader soh
		on soh.SalesPersonID=ss.BusinessEntityID

/*
	4 naloga
	Change the query written in question 3 so that the salesperson’s name also displays
	from the Person.Person table.

*/
select	soh.SalesPersonID, ss.SalesYTD, pp.FirstName
from	sales.SalesPerson as ss
		left join sales.SalesOrderHeader soh
		on soh.SalesPersonID=ss.BusinessEntityID
		inner join Person.Person as pp
		on pp.BusinessEntityID=ss.BusinessEntityID
/*
	5 naloga
	The Sales.SalesOrderHeader table contains foreign keys to the Sales.CurrencyRate and
	Purchasing.ShipMethod tables. Write a query joining all three tables, and make sure it
	contains all rows from Sales.SalesOrderHeader. Include the CurrencyRateID, AverageRate,
	SalesOrderID, and ShipBase columns.
*/
select	cr.CurrencyRateID, cr.AverageRate, soh.SalesOrderID, sm.ShipBase
from	sales.SalesOrderHeader as soh
		left join sales.CurrencyRate as cr
		on cr.CurrencyRateID=soh.CurrencyRateID
		join Purchasing.ShipMethod as sm
		on soh.ShipMethodID=sm.ShipMethodID

