-- definicija funkcije 
create function dbo.udf_Delim(@String VARCHAR(100), @Delimiter CHAR(1))
returns varchar(200) as
begin
	declare @newString varchar(200) = '';
	declare @count int = 1;
	while @count <= len(@String) begin
		set @newString += SUBSTRING(@String, @count, 1) + @Delimiter;
		set @count += 1;
	end
	return (left(@newString, LEN(@newString)-1));
end

go

-- uporaba funkcije
select dbo.udf_Delim('ABCDEF', '-')

-- vaje

-- 1 naloga
-- Create a user-defined function called dbo.fn_AddTwoNumbers that accepts two integer parameters.
-- Return the value that is the sum of the two numbers. Test the function

create function dbo.fn_AddTwoNumbers(@Var1 int, @Var2 int)
returns int as begin
	return (@Var1 + @Var2);
end

select dbo.fn_AddTwoNumbers(1, 5);

-- 2 naloga
-- Create a user-defined function called dbo.Trim that takes a VARCHAR(250) parameter.
-- This function should trim off the spaces from both the beginning and the end of the string.
-- Test the function.

alter function dbo.Trimm(@String varchar(250))
returns varchar(250) as begin
	return ltrim(rtrim(@String));
end

select dbo.Trimm('   asd  ');

-- 3 naloga
-- Create a function dbo.fn_RemoveNumbers that removes any numeric characters from a VARCHAR(250) string.
-- Test the function. Hint: The ISNUMERIC function checks to see whether a string is numeric.
-- Check Books Online to see how to use it.

alter function dbo.fn_RemoveNumbers(@String varchar(250))
returns varchar(250) as begin
	declare @c int = 1;
	declare @trimmed varchar(250) = '';
	declare @char varchar(1);

	while @c <= len(@String) begin
		set @char = substring(@String, @c, 1);
		if (isnumeric(@char) = 0) begin
			set @trimmed += @char;
		end
		set @c += 1;
	end

	return @trimmed;
end

select dbo.fn_RemoveNumbers('1as2sa23dsreg23x')

-- 4 naloga
-- Write a function called dbo.fn_FormatPhone that takes a string of ten numbers.
-- The function will format the string into this phone number format: “(###) ###-####.”
-- Test the function.

alter function dbo.fn_FormatPhone(@String varchar(10))
returns varchar(14) as begin
	declare @formatted varchar(250) = '(';

	set @formatted +=  substring(@String, 1, 3);
	set @formatted += ') '
	set @formatted += substring(@String, 3, 3);
	set @formatted += '-'
	set @formatted += substring(@String, 6, 4);
	set @formatted += '.'

	return @formatted;
end

select dbo.fn_FormatPhone('0123456789');

-- 5 naloga
-- Crete table-valued function dbo.ThreeBigest, which returns 3 top sold products by value for each seller.
-- Use function in a select statement with cross apply. Select statement should return full name of a
-- seller, product name and value (linetotal) of sales for product.
CREATE FUNCTION dbo.ThreeBiggest (@SalesPerson int)
RETURNS @Three TABLE 
(

	Product nvarchar(200) NOT NULL,
    Total numeric(19,2) NOT NULL
)
AS
BEGIN
INSERT INTO @Three
SELECT MAX(P.Name) AS ProductName,SUM(D.LineTotal) AS Total
FROM SALES.SalesOrderDetail AS D
JOIN SALES.SalesOrderHeader AS H ON D.SalesOrderID=H.SalesOrderID
JOIN PRODUCTION.Product AS P ON D.ProductID=P.ProductID
WHERE H.SalesPersonID=@SalesPerson
GROUP BY D.ProductID
ORDER BY Total DESC OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY

RETURN
END
GO
SELECT A.SalesPersonID,C.Product,C.Total
FROM 
(SELECT DISTINCT h.SalesPersonID
FROM sales.SalesOrderHeader as h
WHERE SalesPersonID IS NOT NULL) as a
CROSS APPLY dbo.ThreeBiggest(A.SalesPersonID) AS c