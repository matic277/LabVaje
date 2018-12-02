-- združevanje stringov po vrsticah
select  string_agg(name, ', ') as Name2
from    sys.databases
where   database_id > 4


-- string slitting, ena vrsta v več vrstic
select  trim(value) as Name
from    string_split('AdventureWorks2012, AdventureWorks2014, AdventureWorks2016, AdventureWorks2017', ',')


-- 1 naloga
-- Write a query that displays the first 10 characters of the AddressLine1 column in the Person.Address table.
select  left(addressline1, 10)
from    person.address

-- 2 naloga
-- Write a query that displays characters 10 to 15 of the AddressLine1 column in the Person.Address table.
select  SUBSTRING(addressline1, 10, 5)
from    person.address

-- 3 naloga
-- Write a query displaying the first and last names from the Person.Person table all in uppercase.
select  upper(firstname) as firstname, upper(lastname) as lastname
from    person.person

/*
    4 naloga
    The ProductNumber in the Production.Product table contains a hyphen (-).
    Write a query that uses the SUBSTRING function and the CHARINDEX function to display the
    characters in the product number following the hyphen. Note: there is also a second hyphen in
    many of the rows; ignore the second hyphen for this question. Hint: Try writing this statement in
    two steps, the first using the CHARINDEX function and the second adding the SUBSTRING function
*/
select  reverse(SUBSTRING(reverse(ProductNumber), 1, CHARINDEX('-', reverse(ProductNumber))-1)), ProductNumber
from    Production.Product


-- datumi
select getdate(), cast(GETDATE() as date), cast(GETDATE() as time), cast(GETDATE() as datetime)

-- datename(dw, datum) -> ime dneva na tisti dan
select datename(dw, dateadd(d, 45, getdate()))

-- format datuma
select format(getdate(), 'dd MMMM ... (yyyy)')


/*
    Write a query that calculates the number of days between the date an order was placed and the
    date that it was shipped using the Sales.SalesOrderHeader table.
    Include the SalesOrderID, OrderDate, and ShipDate columns.
*/
select  salesorderid, orderdate, shipdate, datediff(dd, orderdate, shipdate) as diff
from    sales.SalesOrderHeader

-- 2 naloga
-- Write a query that displays only the date, not the time, for the order date and ship date in the
-- Sales.SalesOrderHeader table.
select  salesorderid, orderdate, cast(orderdate as date) as dateOnly
from    sales.SalesOrderHeader

-- 3 naloga
-- Write a query that adds six months to each order date in the Sales.SalesOrderHeader table.
-- Include the SalesOrderID and OrderDate columns.
select  orderdate as org, dateadd(m, 6, orderdate) as 'org+6months'
from    sales.SalesOrderHeader

-- 4 naloga
-- Write a query that displays the year of each order date and the numeric month of each
-- order date in separate columns in the results. Include the SalesOrderID and OrderDate columns.
select  orderdate as fulldate, format(orderdate, 'yyyy') as year, format(orderdate, 'MM') as month
from    sales.SalesOrderHeader

-- 5 naloga
-- Change the query written in question 4 to display the month name instead.
select  orderdate as fulldate, format(orderdate, 'yyyy') as year, format(orderdate, 'MMMM') as month
from    sales.SalesOrderHeader
