-- declaring and overwritting/setting variable x to something
declare @x INT = 5
print @x

set @x = 10
print @x


-- shranjevanje imen
declare @Names NVARCHAR(4000) = ''

select	@Names = @Names + ', ' + p.FirstName
from	Person.Person as p
print @Names

-- ali
declare @Names TABLE (Names nvarchar(50))
insert into @Names
select	FirstName
from	Person.Person

select	*
from	@Names

---

declare @FirstName nvarchar(50)
set @FirstName = N'Ke%'

select	BusinessEntityID, FirstName, LastName
from	Person.Person
where	FirstName like @FirstName
order by BusinessEntityID

