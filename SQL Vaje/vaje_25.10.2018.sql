/*
    1 naloga
    Write a query that displays in the “AddressLine1 (City PostalCode)” format from the Person.Address table.
*/
SELECT  concat_ws(' ',AddressLine1, PostalCode) as AddressLine1
FROM    Person.Address

/*
    2 naloga
    Write a query using the Production.Product table displaying the
    product ID, color, and name columns. If the color column contains
    a NULL value, replace the color with No Color.
*/
select  productID, ISNULL(color, 'no color'), name
from    Production.Product

/*
    3 naloga
    Modify the query written in question 2 so that the description of the
    product is displayed in the “Name: Color” format.
    Make sure that all rows display a value even if the Color value is missing.
*/
select  productID, concat_ws(' : ', name, ISNULL(color, 'no color')), name
from    Production.Product

-- matematične operacije nad vrsticami

/*
    1 naloga
    Write a query using the Sales.SpecialOffer table. Display the difference between the
    MinQty and MaxQty columns along with the SpecialOfferID and Description columns.
*/
select  specialofferID, description, MinQty-MaxQty
from    Sales.SpecialOffer

/*
    2 naloga
    Write a query using the Sales.SpecialOffer table. Multiply the MinQty column by the
    DiscountPct column. Include the SpecialOfferID and Description columns in the results.
*/
select  specialofferID, description, MinQty*DiscountPct
from    Sales.SpecialOffer

/*
    Write a query using the Sales.SpecialOffer table that multiplies the MaxQty column
    by the DiscountPct column. If the MaxQty value is NULL, replace it with the value 10.
    Include the SpecialOfferID and Description columns in the results.
*/
-- nerešena

-- string funkcije
select  concat_ws(' ', firstname, lastname) as Name
from    person.person
order by LastName
offset 0 rows
fetch first 10 rows only

