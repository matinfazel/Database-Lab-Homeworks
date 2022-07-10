-- Question 1
-- ابتدا جداول گفته شده در دستور کار را ایجاد میکنیم

CREATE TABLE Departments (
  Name varchar(20) NOT NULL ,
  ID char(5) PRIMARY KEY,
  Budget numeric(12,2),
  Category varchar(15) Check (Category in ('Engineering','Science'))
);

CREATE TABLE Teachers (
  FirstName varchar(20) NOT NULL,
  LastName varchar(30) NOT NULL ,
  ID char(7),
  BirthYear int,
  DepartmentID char(5),
  Salary numeric(7,2) Default 10000.00,
  PRIMARY KEY (ID),
  FOREIGN KEY (DepartmentID) REFERENCES Departments(ID),
);

CREATE TABLE Students (
  FirstName varchar(20) NOT NULL,
  LastName varchar(30) NOT NULL ,
  StudentNumber char(7) PRIMARY KEY,
  BirthYear int,
  DepartmentID char(5),
  AdvisorID char(7),
  FOREIGN KEY (DepartmentID) REFERENCES Departments(ID),
  FOREIGN KEY (AdvisorID) REFERENCES Teachers(ID)
);

--A
ALTER TABLE Students add Total_Credits int; -- adding column for saving passed credits

--B 

CREATE TABLE Courses (
  ID char(5) primary key,
  Title varchar(30) NOT NULL ,
  Credits int,
  DepartmentID char(5) ,
  FOREIGN KEY (DepartmentID) REFERENCES Departments(ID)
);

CREATE TABLE Available_Courses (
  CourseID char(5) NOT NULL,
  Semster varchar(12) CHECK (Semster in ('fall','spring')) NOT NULL ,
  Year int,
  ID varchar(5) primary key,
  TeacherID char(7) NOT NULL,
  FOREIGN KEY (CourseID) REFERENCES Courses(ID),
  FOREIGN KEY (TeacherID) REFERENCES Teachers(ID),

);

CREATE TABLE Taken_Courses (
  StudentID char(7),
  CourseID 	char(5),
  Semester varchar(12) CHECK (Semester in ('fall','spring')) NOT NULL ,
  Year int,
  Grade int,

  PRIMARY KEY (StudentID,CourseID,Semester,Year),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentNumber),
  FOREIGN KEY (CourseID) REFERENCES Courses(ID),

);

create table Prerequisites(
    CourseID char(5) NOT NULL,
    PrereqID char(5),
    PRIMARY KEY (CourseID,PrereqID),
    FOREIGN KEY (CourseID) REFERENCES Courses(ID)
);

--C 


--Inserting into Department 
INSERT INTO Departments VALUES ('Comp-Sci.', '1', 780000 , 'Engineering');
INSERT INTO Departments VALUES('Civil-eng', '2', 1270000,'Engineering');
INSERT INTO Departments VALUES('Math', '3' ,1510000, 'Science');

--Inserting into Teachers

INSERT INTO Teachers VALUES ('Michael','Johnson', '1', 1968, '1', 87000.00);
INSERT INTO Teachers VALUES ('Andy','Adams', '3', 1989, '2', 56000.00);
INSERT INTO Teachers VALUES ('Kate','Nickson', '5', 1963, '3', 71000.00);

--Inserting into Students 

INSERT INTO Students VALUES ('Evelyn','ALbro', '2424', 1996, '1', '1');
INSERT INTO Students VALUES ('Matin','Fazel', '23424', 1995, '2', '3');
INSERT INTO Students VALUES ('Jackson','Barks', '123', 2001, '3', '5');
INSERT INTO Students VALUES ('Madison','Basil', '234', 2000, '1', '1');
INSERT INTO Students VALUES ('William','Johanson', '125', 1994, '3', '5');

--Inserting into Courses table
INSERT INTO Courses VALUES ('10','C', 4, '1');
INSERT INTO Courses VALUES ('11','Signal', 3, '2');
INSERT INTO Courses VALUES ('12','DB', 3, '3');
INSERT INTO Courses VALUES ('13','AP', 3, '1');
INSERT INTO Courses VALUES ('14','DB-Lab', 3, '1');



-- Inserting into Available_Courses table
INSERT INTO Available_Courses VALUES ('10','fall', 2019,'19', '1');
INSERT INTO Available_Courses VALUES ('11','spring', 2020,'12', '1');
INSERT INTO Available_Courses VALUES ('12','spring', 2020,'15', '5');
INSERT INTO Available_Courses VALUES ('14','spring', 2019, '17','3');

-- Inserting into Taken_Courses table
INSERT INTO Taken_Courses VALUES ('2424','10', 'fall', 2020, 96);
INSERT INTO Taken_Courses VALUES ('234','11', 'fall', 2019, 92);
INSERT INTO Taken_Courses VALUES ('234','12', 'fall', 2019, 88);
INSERT INTO Taken_Courses VALUES ('125','13', 'spring', 2019, 80);

--Inserting into Taken_Courses table Prerequisites

INSERT INTO Prerequisites VALUES ('10','11');
INSERT INTO Prerequisites VALUES ('11','12');
INSERT INTO Prerequisites VALUES ('12','13');


--2
--A

select * from Students where Students.StudentNumber = '123';

--B
select StudentID,CourseID,Semester,Year,Grade+1
from Taken_Courses;

--C

select *
from Students
LEFT JOIN Taken_Courses 
ON (Taken_Courses.StudentID = Students.StudentNumber ) 
where Students.StudentNumber not in (select StudentID from Taken_Courses where CourseID = '12');