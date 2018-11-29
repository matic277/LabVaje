-- skewness z SQL funkcijo
WITH SkewCTE AS
(
SELECT SUM(1.0*Age) AS rx,
 SUM(POWER(1.0*Age,2)) AS rx2,
 SUM(POWER(1.0*Age,3)) AS rx3,
 COUNT(1.0*Age) AS rn,
 STDEV(1.0*Age) AS stdv,
 AVG(1.0*Age) AS av
FROM dbo.vTargetMail
)
SELECT
   (rx3 - 3*rx2*av + 3*rx*av*av - rn*av*av*av)
   / (stdv*stdv*stdv) * rn / (rn-1) / (rn-2) AS Skewness
FROM SkewCTE;


-- skewness z R libaryjem 'moments'
EXEC sp_execute_external_script
@language = N'R',
@script = N'library(moments)
			OutputDataSet<- as.data.frame(skewness(InputDataSet))',

@input_data_1 = N'SELECT Age FROM dbo.vTargetMail'
