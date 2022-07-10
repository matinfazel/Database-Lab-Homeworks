begin tran
update Production.Product
set Color = 'Black'
where ProductID = 1;
waitfor delay '00:00:10';
rollback tran;

