/*
-- združevanje stringov po vrsticah
select  string_agg(name, ', ') as Name2
from    sys.databases
where   database_id > 4
*/
/*
-- string slitting, ena vrsta v več vrstic
select  trim(value) as Name
from    string_split('AdventureWorks2012, AdventureWorks2014, AdventureWorks2016, AdventureWorks2017', ',')
*/
/*
-- 1 naloga
select  left(addressline1, 10)
from    person.address

-- 2 naloga
select  SUBSTRING(addressline1, 10, 5)
from    person.address

-- 3 naloga
select  upper(firstname) as firstname, upper(lastname) as lastname
from    person.person

-- 4 naloga
select  reverse(SUBSTRING(reverse(ProductNumber), 1, CHARINDEX('-', reverse(ProductNumber))-1)), ProductNumber
from    Production.Product
*/
/*
-- datumi
select getdate(), cast(GETDATE() as date), cast(GETDATE() as time), cast(GETDATE() as datetime)

-- datename(dw, datum) -> ime dneva na tisti dan
select datename(dw, dateadd(d, 45, getdate()))

-- format datuma
select format(getdate(), 'dd MMMM ... (yyyy)')
*/
/*
-- 1 naloga
select  salesorderid, orderdate, shipdate, datediff(dd, orderdate, shipdate) as diff
from    sales.SalesOrderHeader

-- 2 naloga
select  salesorderid, orderdate, cast(orderdate as date) as dateOnly
from    sales.SalesOrderHeader

-- 3 naloga
select  orderdate as org, dateadd(m, 6, orderdate) as 'org+6months'
from    sales.SalesOrderHeader

-- 4 naloga
select  orderdate as fulldate, format(orderdate, 'yyyy') as year, format(orderdate, 'MM') as month
from    sales.SalesOrderHeader

-- 5 naloga
select  orderdate as fulldate, format(orderdate, 'yyyy') as year, format(orderdate, 'MMMM') as month
from    sales.SalesOrderHeader
*/