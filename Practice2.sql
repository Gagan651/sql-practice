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
insert into employee values (8,'manu','7891994242',11000,1);
insert into employee values (89,'basva','7891994241',10000,2);
select * from employee


select name,(salary*0.1)+salary from employee where salary>5000;

update employee set salary=(salary*0.1)+salary where salary<5000;

--write query to fetch  2 nd highest
select * from employee where salary in(
select max(salary) from employee where salary not in(

select max(salary) from employee));


select  distinct top 1 salary from employee order by salary 

select * from employee 

--write query to fetch  1 and 2 and 3 highest salary
SELECT top 1 salary
 from
(select DIstinct top 3  salary  from employee order by salary desc) as result
order by salary);

--write query to fetch  1 and 2 and 3 minimum salary
select top 1 salary from(
select DIstinct top 2 salary  from employee order by salary) as res
order by salary desc);

alter table employee add DOB datetime;

update employee set DOB='2024-08-29 12:00:00 ' where id=1;
update employee set DOB='1995-08-21 11:00:00 ' where id=2;
update employee set DOB='1993-07-12 08:10:00 ' where id=3;
update employee set DOB='1991-01-11 09:15:10 ' where id=4;
update employee set DOB='2023-08-29 2:00:00 ' where id=5;
update employee set DOB='1992-08-29 1:25:00 ' where id=6;
update employee set DOB='2024-08-28 02:00:00 ' where id=7;
update employee set DOB='2024-06-21 12:00:00 ' where id=8;
update employee set DOB='2024-05-20 12:00:00 ' where id=89;

select CURRENT_TIMESTAMP(