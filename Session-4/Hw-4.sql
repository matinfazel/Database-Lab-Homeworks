--Q1
USE AdventureWorks2012
GO
SELECT Sales.SalesOrderHeader.OrderDate, Sales.SalesOrderDetail.LineTotal,
AVG(Sales.SalesOrderDetail.LineTotal)OVER (PARTITION BY Sales.SalesOrderHeader.CustomerID
ORDER BY Sales.SalesOrderHeader.OrderDate, Sales.SalesOrderHeader.SalesOrderID
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM Sales.SalesOrderHeader JOIN Sales.SalesOrderDetail ON
(SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID);



--Q2
select Sales.SalesTerritory.Name as TerritoryName,
Sales.SalesTerritory.[Group] as Region,
sum(Sales.SalesOrderHeader.SubTotal) as SalesTotal,
count (*) as SalesCount from 

Sales.SalesTerritory inner join Sales.SalesOrderHeader on 
Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID
group by Sales.SalesTerritory.Name , Sales.SalesTerritory.[Group]

union 
select 'All Terretories' as TerritoryName,
Sales.SalesTerritory.[Group] as Region,
sum(Sales.SalesOrderHeader.SubTotal) as SalesTotal,
count (*) as SalesCount from 

Sales.SalesTerritory inner join Sales.SalesOrderHeader on 
Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID
group by Sales.SalesTerritory.[Group]

union 
select 'All Terretories' as TerritoryName,
'All Region' as Region,
sum(Sales.SalesOrderHeader.SubTotal) as SalesTotal,
count (*) as SalesCount from 

Sales.SalesTerritory inner join Sales.SalesOrderHeader on 
Sales.SalesTerritory.TerritoryID = Sales.SalesOrderHeader.TerritoryID
order by Region,TerritoryName  desc


--Q3
select cast(Production.Product.ProductSubcategoryID as varchar) as ProductSubCategory,  
Production.ProductSubcategory.ProductCategoryID , 
count(*) as count_of_order,
sum(Sales.SalesOrderDetail.LineTotal) as sum_of_order
from 
Production.Product inner join Sales.SalesOrderDetail on 
Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
inner join Production.ProductSubcategory on 
Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
inner join Sales.SalesOrderHeader on 
Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
group by Production.Product.ProductSubcategoryID, Production.ProductSubcategory.ProductCategoryID
union 
select 'all subcategories'as ProductSubCategory, 
Production.ProductSubcategory.ProductCategoryID , 
count(*) as count_of_order,
sum(Sales.SalesOrderHeader.SubTotal) as sum_of_order
from 
Production.Product inner join Sales.SalesOrderDetail on 
Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
inner join Production.ProductSubcategory on 
Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
inner join Sales.SalesOrderHeader on 
Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
group by Production.ProductSubcategory.ProductCategoryID

--Q4
with count_job(title,count) as (select HumanResources.Employee.JobTitle,count(*) from
HumanResources.Employee
group by HumanResources.Employee.JobTitle having count(*) > 3)

select CONCAT(Person.Person.FirstName,' ',Person.Person.LastName) as name,
HumanResources.Employee.NationalIDNumber as nationalIdnumber, 
HumanResources.Employee.Gender as Gender,
case 
	when HumanResources.Employee.MaritalStatus = 'S' then 'Single'
	when HumanResources.Employee.MaritalStatus = 'M' then 'Married'
end as MaritalStatus,
HumanResources.Employee.JobTitle as jobtitle, count_job.count as count
from count_job,
Person.Person inner join HumanResources.Employee on Person.Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID
where HumanResources.Employee.JobTitle = count_job.title;