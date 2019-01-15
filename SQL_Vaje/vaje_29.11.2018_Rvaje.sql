-- inserting data into split table in test db
-- (if table doesnt exist it will be created on the fly)
USE test
go

select * into split
from (
select N'1' as id, N'a,b,c' as znaki union all
select N'2' as id, N'b,d' as znaki union all
select N'3' as id, N'c,e' as znaki ) t;

go

select * into split2
from (
select N'1' as id, N'a' as znaki union all
select N'1' as id, N'b' as znaki union all
select N'1' as id, N'c' as znaki union all
select N'2' as id, N'd' as znaki union all
select N'2' as id, N'e' as znaki ) t;

select *
from split

go

-- unnesting with R
-- (InputDataSet and OutputDataSet are fixed variable
-- names for input and output values in R)
EXEC sp_execute_external_script
@language = N'R',
@script = N'
	library(tidyverse)
	library(stringr)

	output = InputDataSet %>% 
		mutate(znaki1=str_split(znaki, ",")) %>%
		unnest(znaki1) %>%
		select(id, znaki1)

	OutputDataSet <- as.data.frame(output)
',

@input_data_1 = N'select * from split'

-- same thing in SQL
select	id, value as znak
from	split as s
		CROSS APPLY string_split(s.znaki, ',')

-- reversing, grouping and concating values
select	id, STRING_AGG(znaki, ',') as znaki
from	split2
group by id


