create database  business;
use business;
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

drop table employee;
drop table department;

insert into department values(1,'IT');
insert into department values(2,'payrol');
insert into department values(3,'hr');
insert into department values(4,'admin');

insert into employee values (1,'arun','7892994248',1000,3,'2024-08-29 12:00:00 ');
insert into employee values (2,'john','7892994243',2000,2);
insert into employee values (3,'charles','7892994548',4000,1);
insert into employee values (4,'jeevita','7892994148',7000,4);
insert into employee values (5,'amol','7892994240',8000,1);
insert into employee values (6,'ashok','7892954248',10000,3);
insert into employee values (7,'ranjita','7891994248',11000,1);

truncate table employee;

insert into  department(DID,Dept_name)
values(1,'IT'),
(2,'payrol'),
(3,'hr'),
(4,'admin');

insert into employee(id,name,phone,salary,DID)
values
(1,'arun','7892994248',1000,3),
(2,'john','7892994243',2000,2),
(3,'charles','7892994548',4000,1),
(4,'jeevita','7892994148',7000,4),
(5,'amol','7892994240',8000,1),
(6,'ashok','7892954248',10000,3),
(7,'ranjita','7891994248',11000,1);

alter table department add Dep_location varchar(40);
alter table employee add DOB datetime;
update employee set DOB='2024-08-29 12:00:00 ' where id=1;
update employee set DOB='1995-08-21 11:00:00 ' where id=2;
update employee set DOB='1993-07-12 08:10:00 ' where id=3;
update employee set DOB='1991-01-11 09:15:10 ' where id=4;
update employee set DOB='2023-08-29 2:00:00 ' where id=5;
update employee set DOB='1992-08-29 1:25:00 ' where id=6;
update employee set DOB='2024-08-28 12:00:00 ' where id=7;

delete from department where DID=1
DELETE FROM EMPLOYEE WHERE ID=2;
select * from department;
SELECT * FROM employee

insert into employee(id,name,phone,salary,DID)
values
(11,'GAGAN','7892994248',11000,null),
(9,'Tarun','7892994248',12000,2),
(10,'Tirupati','7892994248',12000,2)
select id, salary,name FROM employee order by salary desc, name asc
select id, salary,name FROM employee order by salary desc, name asc

select * from employee where name like '%ar%';

SELECT count(DID) from employee
group by DID 

SELECT * FROM department;
SELECT * FROM employee

select count(DID) as "count of departmentid" from employee;

select name,DID from employee

select dept_name ,
(
SELECT count(DID) from employee
where department.DID=employee.DID
group by DID ) as deprtCoun from department

select dept_name,count(d.DID) from employee e  join department d on d.DID=e.DID group by d.dept_name;


CREATE TABLE Customers (
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(255),
Customer_Email VARCHAR(255),
Customer_Address VARCHAR(255),
Customer_Phone VARCHAR(20)
)

CREATE TABLE Orders (
Order_ID INT PRIMARY KEY,
Customer_ID INT,
Product_ID INT,
Quantity INT,
Order_Date DATE,
FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
)

INSERT INTO Customers (Customer_ID, Customer_Name, Customer_Email, Customer_Address, Customer_Phone)
VALUES 
(5, 'Gangana', 'susan.johnson@example.com', '789 Pine Ave', '555-321-7890'),
(6, 'Apple', 'susan.johnson@example.com', '789 Pine Ave', '555-321-7890'),
(7, 'Ball', 'susan.johnson@example.com', '789 Pine Ave', '555-321-7890'),
(8, 'Cate', 'susan.johnson@example.com', '789 Pine Ave', '555-321-7890')


INSERT INTO Orders (Order_ID, Customer_ID, Product_ID, Quantity, Order_Date)
VALUES
(1, 1, 20, 3, '2021-06-01'),
(2, 2, 15, 1, '2021-07-22'),
(3, 3, 7, 2, '2021-08-15');

ALTER TABLE Orders
ADD COLUMN Price FLOAT;
UPDATE Orders SET Price = 19.99 WHERE Order_ID = 1;
UPDATE Orders SET Price = 29.99 WHERE Order_ID = 2;
UPDATE Orders SET Price = 39.99 WHERE Order_ID = 3;

select * from customers;
select * from orders;

select sum(price) as "totalsum" from orders

select customer_name,count(order_id) from 


select * from customers where customer_id 
in(
select Customer_id from orders where quantity>=1 and price>20);


select * from customers where customer_id 

select * from customers where customer_id 
in
(select Customer_id from orders where customer_id
 in (
select Customer_id from orders where quantity>=1 and price>20) and quantity>=2) ;


select * from customer where 
in
(select Customer_id from orders where customer_id
 in (
select Customer_id from orders where quantity>=1 and price>20 )) ;

SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (
SELECT CUSTOMER_ID FROM ORDERS);