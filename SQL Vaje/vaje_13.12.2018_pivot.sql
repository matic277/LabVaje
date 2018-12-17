select	year(OrderDate) as OrderYear,
		sum(case when month(OrderDate) = 5 then TotalDue else 0 end) as Maj,
		sum(case when month(OrderDate) = 6 then TotalDue else 0 end) as Junij,
		sum(case when month(OrderDate) = 7 then TotalDue else 0 end) as Julij
from	Sales.SalesOrderHeader
where	month(OrderDate) in (5, 6, 7)
group by Year(OrderDate)
order by OrderYear

select	*
from	sales.SalesOrderHeader


-- pivoting
SELECT	OrderYear, [1] AS Jan, [2] AS Feb, [3] AS Mar, [4] AS Apr, [5] AS May, [6] AS Jun
FROM	(
			SELECT	TotalDue, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth
			FROM	Sales.SalesOrderHeader
		) AS MonthData
PIVOT	(
			SUM(MonthData.TotalDue)
			FOR	MonthData.OrderMonth IN ([1], [2], [3], [4], [5], [6])
		) AS PivotData
ORDER BY OrderYear;

-- naloge

-- prereq
--Pivot clause
CREATE TABLE departments
( dept_id INT NOT NULL,
  dept_name VARCHAR(50) NOT NULL,
  CONSTRAINT departments_pk PRIMARY KEY (dept_id)
);

CREATE TABLE employees
( employee_number INT NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  salary INT,
  dept_id INT,
  CONSTRAINT employees_pk PRIMARY KEY (employee_number)
);

INSERT INTO departments
(dept_id, dept_name)
VALUES
(30, 'Accounting');

INSERT INTO departments
(dept_id, dept_name)
VALUES
(45, 'Sales');

INSERT INTO employees
(employee_number, last_name, first_name, salary, dept_id)
VALUES
(12009, 'Sutherland', 'Barbara', 54000, 45);

INSERT INTO employees
(employee_number, last_name, first_name, salary, dept_id)
VALUES
(34974, 'Yates', 'Fred', 80000, 45);

INSERT INTO employees
(employee_number, last_name, first_name, salary, dept_id)
VALUES
(34987, 'Erickson', 'Neil', 42000, 45);

INSERT INTO employees
(employee_number, last_name, first_name, salary, dept_id)
VALUES
(45001, 'Parker', 'Salary', 57500, 30);

INSERT INTO employees
(employee_number, last_name, first_name, salary, dept_id)
VALUES
(75623, 'Gates', 'Steve', 65000, 30);

-- 1 naloga
-- total salary by department
select	*
from	employees

-- using case
select	sum(case when d.dept_id = 30 then salary else 0 end) as ID_30,
		sum(case when d.dept_id = 45 then salary else 0 end) as ID_45
from	departments as d join employees as e
		on d.dept_id = e.dept_id

-- using pivot
select	[30] as ID_30, [45] as ID_45
from	(
			select	d.dept_id, e.salary
			from	departments as d join employees as e
					on d.dept_id = e.dept_id
		) as tmp
PIVOT	(
			SUM(tmp.salary)
			for	tmp.dept_id in ([30], [45])
		) as PivotData


-- 2 naloga
-- using sales.salesorderheader, what is the todal dude by sellers and years

select	TotalDue, year(OrderDate), SalesPersonID
from	Sales.SalesOrderHeader

-- using case (years 2011, 2012, 2013, 2014)
select	sum(case when year(OrderDate) = 2011 then TotalDue else 0 end) as Leto2011,
		sum(case when year(OrderDate) = 2012 then TotalDue else 0 end) as Leto2012,
		sum(case when year(OrderDate) = 2013 then TotalDue else 0 end) as Leto2013,
		sum(case when year(OrderDate) = 2014 then TotalDue else 0 end) as Leto2014,
		SalesPersonID
from	Sales.SalesOrderHeader
group by SalesPersonID
having	SalesPersonID is not null
order by SalesPersonID

-- using pivot
select	[2011] as Leto2011, [2012] as Leto2012, [2013] as Leto2013,[2014] as Leto2014, SalesPersonID
from	(
			select	year(OrderDate) as Date, TotalDue as Total, SalesPersonID
			from	Sales.SalesOrderHeader
			where	SalesPersonID is not null
		) as tmp
PIVOT	(
			SUM(tmp.Total)
			for	tmp.Date in ([2011], [2012], [2013], [2014])
		) as PivotData
order by SalesPersonID



