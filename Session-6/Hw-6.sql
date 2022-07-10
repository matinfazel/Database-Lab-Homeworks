--Q1

    create TABLE ProductLogs(
	[ProductID] [int] NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[MakeFlag] [dbo].[Flag] NOT NULL,
	[FinishedGoodsFlag] [dbo].[Flag] NOT NULL,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] NOT NULL,
	[ReorderPoint] [smallint] NOT NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Size] [nvarchar](5) NULL,
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int] NOT NULL,
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[Transaction_Type] [nchar](10));



create trigger inserting -- trigger for inserting
on Production.product 
after insert
as 
begin
   SET NOCOUNT ON;
insert into ProductLogs(
	[ProductID],
	[Name]  ,
	ProductNumber,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel ,
	ReorderPoint ,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate ,
	SellEndDate ,
	DiscontinuedDate ,
	rowguid ,
	ModifiedDate ,
	Transaction_Type
)

select 	ProductID ,
	tmp_obj.Name  ,
	tmp_obj.ProductNumber,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel ,
	ReorderPoint ,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate ,
	SellEndDate ,
	DiscontinuedDate ,
	rowguid ,
	ModifiedDate ,
	'insert'
	from inserted tmp_obj ;
end



create trigger deleting -- trigger for deleting
on Production.product 
after delete
as 
begin
   SET NOCOUNT ON;
insert into ProductLogs(
	[ProductID],
	[Name]  ,
	ProductNumber,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel ,
	ReorderPoint ,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate ,
	SellEndDate ,
	DiscontinuedDate ,
	rowguid ,
	ModifiedDate ,
	Transaction_Type
)

select 	ProductID ,
	tmp_obj.Name  ,
	tmp_obj.ProductNumber,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel ,
	ReorderPoint ,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate ,
	SellEndDate ,
	DiscontinuedDate ,
	rowguid ,
	ModifiedDate ,
	'delete'
	from deleted tmp_obj ;
end



create trigger updating -- trigger for updating
on Production.product 
after update
as 
begin
   SET NOCOUNT ON;
insert into ProductLogs(
	[ProductID],
	[Name]  ,
	ProductNumber,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel ,
	ReorderPoint ,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate ,
	SellEndDate ,
	DiscontinuedDate ,
	rowguid ,
	ModifiedDate ,
	Transaction_Type
)

select 	ProductID ,
	tmp_obj.Name  ,
	tmp_obj.ProductNumber,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel ,
	ReorderPoint ,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate ,
	SellEndDate ,
	DiscontinuedDate ,
	rowguid ,
	ModifiedDate ,
	'update'
	from inserted tmp_obj ;
end


update Production.Product set Color = 'Black' where ProductID = 368 -- updating
update Production.Product set Color = NULL where ProductID = 368 -- updating

insert into Production.Product -- inserting
select 	'asdf'  ,
	466546023,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel ,
	ReorderPoint ,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate ,
	SellEndDate ,
	DiscontinuedDate ,
	'0A0C93AA-D06C-48AA-99EB-20F2C8A6D6C6' ,
	ModifiedDate from Production.Product where ProductID = 368

	delete from Production.Product where rowguid = '0A0C93AA-D06C-48AA-99EB-20F2C8A6D6C6' --deleting




--Q2
--first making copy table from ProductLog named new_ProductLogs
select *
into new_ProductLogs from 
ProductLogs
--making some changes in new_ProductLogs
update new_ProductLogs set Name = 'New Name'where ProductID = 368

--Q3
CREATE PROCEDURE find_diff 
AS
begin
select * into diff_table from(
select * from ProductLogs except 
select * from new_ProductLogs) as foo
end

execute find_diff