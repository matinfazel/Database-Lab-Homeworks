begin tran
select ProductID,Weight
from Production.Product
where ProductID = 717
waitfor delay '00:00:05'

select ProductID,Weight
from Production.Product
where ProductID = 732