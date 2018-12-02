
SELECT *
FROM [INFORMATION_SCHEMA].[TABLES];
go

SELECT *
FROM [INFORMATION_SCHEMA].[COLUMNS]
WHERE TABLE_NAME='Address';
go

SELECT 
CASE WHEN(SELECT COLUMN_NAME
FROM [INFORMATION_SCHEMA].COLUMNS
WHERE TABLE_NAME='Address' AND COLUMN_NAME='City') IS NULL THEN 'ni'
ELSE 'je' END AS Vrednost;
go

SELECT BusinessEntityID, CASE WHEN BusinessEntityID%2=0 THEN 'even' ELSE 'odd' END AS oddoreven
FROM [HumanResources].[Employee];
go

SELECT CASE WHEN OrderQty<10 THEN 'under10'
	WHEN OrderQty>=10 AND OrderQty<20 THEN' 10-19'
	WHEN OrderQty>=20 AND OrderQty<30 THEN' 20-49'
	WHEN OrderQty>=30 AND OrderQty<40 THEN' 30-39'
	WHEN OrderQty>=40  THEN' greater than 40'
	END AS VALUE, SalesOrderDetailID, OrderQty


FROM [Sales].[SalesOrderDetail]
ORDER BY OrderQty;
go

SELECT  
  SERVERPROPERTY('MachineName') AS ComputerName,
  SERVERPROPERTY('ServerName') AS InstanceName,  
  SERVERPROPERTY('Edition') AS Edition,
  SERVERPROPERTY('ProductVersion') AS ProductVersion,  
  SERVERPROPERTY('ProductLevel') AS ProductLevel;  
GO


/*
	sortiramo z orderby stolpec OrderQty, in jih označimo s številko vrstice
	z ukazom ROW_NUMBER, to vrstico potem poimenujemo z Vrstica

	Nakoncu to vse uredimo po UnitPrice (vrstice ne bojo po vrsti)
*/
select	ROW_NUMBER() OVER (ORDER BY OrderQty desc) AS Vrstica, *
from	[Sales].[SalesOrderDetail]
order by UnitPrice

