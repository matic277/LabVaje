if object_id('dbo.demo') is not null begin
	drop table dbo.demo;
	end
create table dbo.demo (
	id int primary key,
	name varchar(25)
)

-- 1 naloga
-- Write a transaction that includes two INSERT statements to add two rows to the dbo.Demo table.
begin tran
insert into dbo.demo values (1, 'first')
insert into dbo.demo values (2, 'second')
commit

-- 2 naloga
-- Write a transaction that includes two INSERT statements to add two more rows to the dbo.Demo table.
-- Attempt to insert a letter instead of a number into the ID column in one of the statements.
-- Select the data from the dbo.Demo table to see which rows made it to the table.
begin tran
insert into dbo.demo values (3, 'third')
insert into dbo.demo values (4, 'fourth')
commit

begin tran
insert into dbo.demo values (5, 'fifth')
insert into dbo.demo values ('a', 'sixth')
commit -- both of these get rejected, if an error occurs inside a transaction, everything is rolled back

select	*
from	dbo.demo