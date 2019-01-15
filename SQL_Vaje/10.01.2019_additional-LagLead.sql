-- izpis prometa za vsako leto, in koliko prometea je bilo v prejsnjem letu
-- brez lead in lag
with tmp as (
	select	year(orderDate) as leto, sum(totalDue) as Promet
	from	sales.SalesOrderHeader
	group by year(orderDate)
)
select	c.leto, c.promet as currentP, l.promet as previous,
		(c.promet - l.promet) as '+/-',
		(c.promet / l.promet)*100 as '%'
from	tmp as c left join tmp as l
		on c.leto = (l.leto+1)
order by c.leto

-- LAG in LEAD(vrednost, razlika med kljuci, default ce kluca ni)
select	year(OrderDate) as leto,
		sum(TotalDue) as currentP,
		LAG(sum(TotalDue), 1, 0) over (order by year(OrderDate)) as previous,
		LEAD(sum(TotalDue), 1, 0) over (order by year(OrderDate)) as nextY
from	sales.SalesOrderHeader
group by year(OrderDate)

-- po mesecih znotraj leta
select	year(OrderDate) as leto,
		max(month(OrderDate)) as mesec,
		sum(TotalDue) as currentP,
		LAG(sum(TotalDue), 1, 0) over (order by year(OrderDate), month(OrderDate)) as previous
from	sales.SalesOrderHeader
group by year(OrderDate), month(OrderDate)
order by year(OrderDate), month(OrderDate)
