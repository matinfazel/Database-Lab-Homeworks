begin tran
select ProductID, Weight from Production.Product where 
ProductID = 508;
waitfor delay '00:00:15';

select ProductID, Weight from Production.Product where 
ProductID = 508;
commit tran
