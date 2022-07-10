begin tran
update Production.Product
set Weight = Weight + 1
where ProductID = 508;
commit tran