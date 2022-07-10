--Q1
    --P1
    create login new_login with 
    password = '12';

    --P2
    create server role Role1;
    grant create any database to
    Role1;
    grant alter any database to
    Role1;

    --P3
    alter server role Role1 
    add member new_login;

    --P4
    use AdventureWorks2012;
    CREATE TABLE workers (
    Name varchar(25) NOT NULL ,
    ID char(5) PRIMARY KEY,
    salary int,
    );
    insert into workers values('martin','1',1299);
    insert into workers values ('joe','2',1300);

    select * from workers;

--Q2
    --P1
    use AdventureWorks2012
    go
    create role Role2;
    alter role db_securityadmin 
    add member Role2;

    --p2
    use AdventureWorks2012;
    alter role db_datareader
    add member Role2;