-- 1 naloga
-- Write a statement that attempts to insert a duplicate row into the HumanResources.Department table.
-- Use the @@ERROR function to display the error.

declare @var table(DepartmentID int, Name varchar(50), GroupName varchar(50), ModifiedDate datetime)

insert into @var
select	top 1 *
from	HumanResources.Department


begin try
	insert into HumanResources.Department
	select	*
	from	@var
end try
begin catch
	print 'error'
end catch


select * from HumanResources.Department

print @var


-- 2 naloga
-- Change the code you wrote in question 1 to use TRY…CATCH. Display the error number,
-- message, and severity.



-- 3 naloga
-- Change the code you wrote in question 2 to raise a custom error message instead of the
-- actual error message.
