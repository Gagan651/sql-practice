create table employee(
id int primary key ,
name varchar(34),
phone varchar(10),
salary int,
DID int,
foreign key(DID)references department(DID));

create table department(
DID int primary key,
Dept_name varchar(30)
);
--Server=localhost;Database=master;Trusted_Connection=True;
--drop table employee;
--drop table department;

insert into department values(1,'IT');
insert into department values(2,'payrol');
insert into department values(3,'hr');
insert into department values(4,'admin');

insert into employee values (1,'arun','7892994248',1000,3);
insert into employee values (2,'john','7892994243',2000,2);
insert into employee values (3,'charles','7892994548',4000,1);
insert into employee values (4,'jeevita','7892994148',7000,4);
insert into employee values (5,'amol','7892994240',8000,1);
insert into employee values (6,'ashok','7892954248',10000,3);
insert into employee values (7,'ranjita','7891994248',11000,1);

select * from employee