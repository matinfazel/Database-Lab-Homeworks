--Q1

select * from 
(
select Production.Product.Name,  Sales.SalesOrderDetail.OrderQty , sales.SalesTerritory.[Group] as region
from Production.Product 
    inner join  Sales.SalesOrderDetail 
     on (Production.Product.ProductID = Sales.SalesOrderDetail.ProductID)
    inner join sales.SalesOrderHeader
     on (sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID)
    inner join sales.SalesTerritory
     on (sales.SalesTerritory.TerritoryID = sales.SalesOrderHeader.TerritoryID)

) as source_table
pivot (
count(OrderQty) 
for region in (Europe,[North America],Pacific)

)as pivote_table


--Q2
SELECT * FROM  
(
select Person.BusinessEntityID, PersonType, Gender
from Person.Person join HumanResources.Employee on (Person.BusinessEntityID =
Employee.BusinessEntityID )
) AS SourceTable  
pivot  
( 
  count(BusinessEntityID)  
  for Gender in (M,F)  
 
) AS PivotTable;  
  
  

--Q3

select Name from Production.Product
where len(Name) >15 and  SUBSTRING(name, LEN (name) - 1, 1) = 'e' order by Name








--Q5
create function new_function_(
    @year int,
    @month int,
    @name varchar(20)
)
RETURNS table
AS  

    return
	select Sales.SalesOrderHeader.OrderDate, Sales.SalesTerritory.Name
			from Production.Product inner join Sales.SalesOrderDetail on
			Production.Product.ProductID = Sales.SalesOrderDetail.ProductID inner join
			Sales.SalesOrderHeader on Sales.SalesOrderHeader.SalesOrderID = 
			Sales.SalesOrderDetail.SalesOrderID 
			inner join Sales.SalesTerritory on Sales.SalesTerritory.TerritoryID = 
			Sales.SalesOrderHeader.TerritoryID
			where 
			Production.Product.Name = @name and 
			year(Sales.SalesOrderHeader.OrderDate) = @year and
			month(Sales.SalesOrderHeader.OrderDate) = @month
