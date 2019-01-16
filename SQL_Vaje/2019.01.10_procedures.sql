-- 1 naloga
-- Create a stored procedure called dbo.usp_CustomerTotals that displays the total sales from the TotalDue
-- column per year and month for each customer. Test the stored procedure.

alter proc dbo.usp_CustomerTotals as begin
	select	sum(soh.TotalDue) as SumTotalDue,
			max(year(soh.OrderDate)) as Year,
			max(month(soh.OrderDate)) as Month
	from	sales.SalesOrderHeader as soh
	group by soh.CustomerID, year(soh.OrderDate), month(soh.OrderDate)
	order by year(soh.OrderDate), month(soh.OrderDate) ;

	return 0;
end

go
exec dbo.usp_CustomerTotals
go

-- 2 naloga
-- Modify the stored procedure created in question 1 to include a parameter @CustomerID.
-- Use the parameter in the WHERE clause of the query in the stored procedure.
-- Test the stored procedure.

alter proc dbo.usp_CustomerTotals2 (@CustomerID int) as begin
	select	sum(soh.TotalDue) as SumTotalDue,
			max(year(soh.OrderDate)) as Year,
			max(month(soh.OrderDate)) as Month
	from	sales.SalesOrderHeader as soh
	where	soh.CustomerID = @CustomerID
	group by soh.CustomerID, year(soh.OrderDate), month(soh.OrderDate)
	order by year(soh.OrderDate), month(soh.OrderDate) ;

	return 0;
end

go
exec dbo.usp_CustomerTotals2 @CustomerID = 12323
go

-- 3 naloga
-- Create a stored procedure called dbo.usp_ProductSales that accepts a ProductID for a parameter and has
-- an OUTPUT parameter that returns the total number sold for the product. Test the stored procedure.

alter proc dbo.usp_ProductSales (@ProductID int, @Output int output) as begin
	set @output = (
		select	count(ProductID)
		from	sales.SalesOrderDetail
		where	ProductID = @ProductID
		group by ProductID
	)
	return @Output;
end

go
-- have to declare a new empty variable to pass as parameter to procedure, which is used as its output
-- then print that variable that gets the value of whatever gets returned from procedure
declare @Output2 int;
exec dbo.usp_ProductSales @ProductID = 776, @Output = @Output2 output
print @Output2
go
