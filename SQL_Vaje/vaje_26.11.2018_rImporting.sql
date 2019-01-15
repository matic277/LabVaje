EXEC sp_execute_external_script

@language = N'R',
@script = N'OutputDataSet<- InputDataSet',
@input_data_1 = N'SELECT 1 AS Numb UNION ALL SELECT 2;'

WITH RESULT SETS
((
	Res INT
));
GO


-- Path to libraries on your computer/server
EXECUTE sp_execute_external_script

@language = N'R',
@script = N'OutputDataSet <- data.frame(.libPaths());'

WITH RESULT SETS (([DefaultLibraryName] VARCHAR(MAX) NOT NULL));
GO
