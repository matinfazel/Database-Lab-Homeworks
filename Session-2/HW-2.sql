use AdventureWorks2012;
--matin fazel 9825583
--Q1

select * from Sales.SalesOrderHeader inner join Sales.SalesTerritory
on Sales.SalesOrderHeader.TerritoryID = Sales.SalesTerritory.TerritoryID
where Sales.SalesOrderHeader.Status = 5 
and (sales.SalesTerritory.Name = 'france'  or sales.SalesTerritory.[Group] = 'North America')
and Sales.SalesOrderHeader.TotalDue > 100000 and Sales.SalesOrderHeader.TotalDue < 500000; 

--Q2

use AdventureWorks2012;
select SalesOrderID,CustomerID,
SubTotal, OrderDate,
Sales.SalesTerritory.Name as region

from Sales.SalesOrderHeader inner join Sales.SalesTerritory on
Sales.SalesOrderHeader.TerritoryID = Sales.SalesTerritory.TerritoryID

--Q3

WITH newTable(ProductID, OrderQty, TerritoryID) AS 
    (select ProductID, SUM(OrderQty) as NumberOfSell, TerritoryID
    from sales.SalesOrderDetail INNER JOIN sales.SalesOrderHeader 
    ON (sales.SalesOrderDetail.SalesOrderID = sales.SalesOrderHeader.SalesOrderID)
    GROUP BY ProductID, TerritoryID),

    newtable_2 (ProductID,maximumNumberOfSell) AS 
    (select ProductID, max(OrderQty) 
    from newTable
    GROUP BY ProductID)    

    
    SELECT newTable.ProductID, TerritoryID
    from newTable , newtable_2
    where newTable.OrderQty = newtable_2.maximumNumberOfSell and newTable.ProductID = newtable_2.ProductID
    ORDER BY ProductID;
--Q4


--drop table NAmerica_Sales;
with new_tmp as 
(select SalesOrderID,OrderDate,Status,CustomerID,sales.SalesOrderHeader.TerritoryID,SubTotal,TotalDue,Name,CountryRegionCode,sales.SalesTerritory.[Group] from Sales.SalesOrderHeader inner join Sales.SalesTerritory
on Sales.SalesOrderHeader.TerritoryID = Sales.SalesTerritory.TerritoryID
where Sales.SalesOrderHeader.Status = 5 
and (sales.SalesTerritory.[Group] = 'North America')
and Sales.SalesOrderHeader.TotalDue > 100000 and Sales.SalesOrderHeader.TotalDue < 500000)

select * into NAmerica_Sales from new_tmp;

alter table NAmerica_Sales add avg_status varchar(4);
alter table NAmerica_Sales add constraint status_check check(avg_status ='LOW' or avg_status ='Mid'or avg_status ='High');

WITH avg_total_due (AvgTotalDue) as
    (select AVG(TotalDue) as AvgTotalDue
    from sales.SalesOrderHeader INNER JOIN sales.SalesTerritory
    ON (sales.SalesOrderHeader.TerritoryID = sales.SalesTerritory.TerritoryID)
    WHERE sales.SalesTerritory.[Group] = 'North America' and (sales.SalesOrderHeader.TotalDue > 100000 and sales.SalesOrderHeader.TotalDue < 500000))


--select * from avg_total_due;

update NAmerica_Sales 
set avg_status = (
	case 
		when TotalDue > AvgTotalDue then 'High'
		when TotalDue < AvgTotalDue THEN 'LOW'
        when TotalDue = AvgTotalDue THEN 'MID'
		end
	 )
	 from avg_total_due,NAmerica_Sales;
select * 
from NAmerica_Sales;


--Q5

WITH tmp (BusinessEntityID,ratePerHour) AS
        (SELECT BusinessEntityID ,max(Rate)
        FROM HumanResources.EmployeePayHistory
        GROUP BY BusinessEntityID),
     
    tmp2 (BusinessEntityID,ratePerHour, LEVEL) AS
        (select BusinessEntityID,ratePerHour, CASE 
                            WHEN ratePerHour < 29.0000 THEN 3
                            WHEN ratePerHour >= 29.0000 and ratePerHour < 50.0000 THEN 2
                            WHEN ratePerHour >= 50.0000 THEN 1
                    END as LEVEL
        from tmp),
    
     myAVgTable (avg_Salary) AS
        (select AVG(ratePerHour)
        from tmp2),

    tmp3 (BusinessEntityID,NewSalary,LEVEL) AS 
        (select BusinessEntityID, CASE 
                            WHEN ratePerHour <= avg_Salary/2 THEN (ratePerHour + (ratePerHour*20)/100)
                            WHEN ratePerHour > avg_Salary/2 and ratePerHour <= avg_Salary THEN (ratePerHour + (ratePerHour*15)/100)
                            WHEN ratePerHour > avg_Salary and ratePerHour <= avg_Salary + avg_Salary/2 THEN (ratePerHour + (ratePerHour*10)/100)
                          WHEN ratePerHour > avg_Salary + avg_Salary/2 THEN (ratePerHour + (ratePerHour*5)/100)
                                END, LEVEL
        from tmp2,myAVgTable)
select * 
from tmp3
ORDER BY BusinessEntityID;
