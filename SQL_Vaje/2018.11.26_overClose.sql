/*
	3 naloga
	Write a query that joins the HumanResources.Employee table to the Person.Person table so
	that you can display the FirstName, LastName, and HireDate columns for each employee.
	Display the JobTitle along with a count of employees for the title. Use a derived table to solve this query.
*/

select	FirstName, JobTitle, count(*) over (partition by JobTitle) as num
from	Person.Person as pp
		join HumanResources.Employee as hre
		on pp.BusinessEntityID = hre.BusinessEntityID
order by num desc

/*
	4 naloga
	Display the CustomerID, SalesOrderID, and OrderDate for each Sales.SalesOrderHeader row
	as long as the customer has placed at least five orders. Use any of the techniques from
	this section to come up with the query.
*/

select	*
from	(
			select	CustomerID, SalesOrderID, OrderDate, count(*) over (partition by CustomerID) as NumOfOrders
			from	Sales.SalesOrderHeader
		) as SubQ
where	SubQ.NumOfOrders >= 5
order by NumOfOrders
