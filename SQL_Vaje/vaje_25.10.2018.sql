/*
-- 1 naloga
SELECT  concat_ws(' ',AddressLine1, PostalCode) as AddressLine1
FROM    Person.Address

-- 2 naloga
select  productID, ISNULL(color, 'no color'), name
from    Production.Product

-- 3 naloga
select  productID, concat_ws(' : ', name, ISNULL(color, 'no color')), name
from    Production.Product
*/
-- matematične operacije nad vrsticami
/*
-- 1 naloga
select  specialofferID, description, MinQty-MaxQty
from    Sales.SpecialOffer

-- 2 naloga
select  specialofferID, description, MinQty*DiscountPct
from    Sales.SpecialOffer

-- 3 naloga
-- nerešena
*/
-- string funkcije
select  concat_ws(' ', firstname, lastname) as Name
from    person.person
order by LastName
offset 0 rows
fetch first 10 rows only

