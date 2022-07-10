--Q1


USE [AdventureWorks2012]
create TABLE [Sales].[SalesTerritoryNew](
	[TerritoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[Group] [nvarchar](50) NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[CostYTD] [money] NOT NULL,
	[CostLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
)

exec xp_cmdshell 'bcp "AdventureWorks2012.Sales.SalesTerritory" out C:\Users\query1.txt -T -c -t"|"'


BULK INSERT [Sales].[SalesTerritoryNew]
FROM 'C:\Users\query1.txt'
with (
FIELDTERMINATOR = '|'
)
select * from [Sales].[SalesTerritoryNew];

-- Q2
exec xp_cmdshell 'bcp "select TerritoryID,[Name] from AdventureWorks2012.Sales.SalesTerritory;" queryout C:\Users\query2.txt -T -c -t;'

--Q3 
exec xp_cmdshell 'bcp "select * from AdventureWorks2012.Production.Location;" queryout C:\Users\query3.dat -T -c -t;'

--Q4
exec xp_cmdshell 'bcp "SELECT Name,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $x in /StoreSurvey return <result>{$x/AnnualSales}</result>'') as AnnualSales,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $x in /StoreSurvey return <result> {$x/YearOpened} </result>'') as YearOpened,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $x in /StoreSurvey return <result>{$x/NumberEmployees}</result>'') as NumberEmployees FROM AdventureWorks2012.Sales.Store;" queryout C:\Users\query4.txt -T -c -q -t;';