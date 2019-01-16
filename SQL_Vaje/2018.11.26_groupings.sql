-- rollup gre po vrsti specificirani v group by (customerID, territoryID) -> najprej customer ID nato territoryID
-- cube gre vse možne permutacije ureditve (customerID, territoryID) -> najprej customer ID nato territoryID potem še obratno
select	CustomerID, 
		TerritoryID,
		COUNT(*) as Orders
from	Sales.SalesOrderHeader
group by rollup (CustomerID, TerritoryID)
order by Orders desc


-- grouping
-- groupingC in groupingT stolpca vrneta 1 ali 0, glede na to ali je stolpec v parametru NULL
-- če je posledica agregacije je vrednost 1, drugače 0
select	CustomerID, 
		grouping(CustomerID) as GroupingC,
		TerritoryID,
		grouping(TerritoryID) as GroupingT,
		COUNT(*) as Orders
from	Sales.SalesOrderHeader
group by rollup (CustomerID, TerritoryID)
order by Orders desc

-- grouping sets
-- povemo vse svoje vrstne rede grupiranja znotraj grouping sets
select	CustomerID, 
		grouping(CustomerID) as GroupingC,
		TerritoryID,
		grouping(TerritoryID) as GroupingT,
		COUNT(*) as Orders
from	Sales.SalesOrderHeader
group by grouping sets(
		(CustomerID, TerritoryID),
		(CustomerID),
		())
order by Orders desc