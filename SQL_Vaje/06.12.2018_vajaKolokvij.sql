-- 5 naloga, rešena
with tmp as (
	select	year(OrderDate) as Year, CustomerID, sum(SubTotal) as Sale
	from	Sales.SalesOrderHeader
	group by year(OrderDate), CustomerID
),
tmp2 as (
	select	Year, CustomerID, Sale,
			dense_rank() over (partition by Year order by Sale desc) as Rank
	from	tmp
)
select	*
from	tmp2
where	rank = 2