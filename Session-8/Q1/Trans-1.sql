begin tran
update Production.Product set
Weight = Weight + 2 
where ProductID = 717;
waitfor delay '00:00:15';

update Production.Product set
Weight = Weight + 1 
where ProductID = 732;
waitfor delay '00:00:15';
