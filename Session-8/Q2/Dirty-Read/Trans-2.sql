SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
begin tran;
select * from Production.Product where ProductID = 1;
commit tran;