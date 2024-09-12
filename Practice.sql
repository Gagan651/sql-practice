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
Server=localhost;Database=master;Trusted_Connection=True;
drop table employee;
drop table department;

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
(4, 1, 16, 1, '2021-07-21'),
(5, 1, 17, 2, '2021-08-21'),
(6, 1, 12, 1, '2022-07-21'),
(7, 1, 19, 2, '2017-07-21'),
(1, 1, 20, 3, '2021-06-01'),
(2, 2, 15, 1, '2021-07-22'),
(3, 3, 7, 2, '2021-08-15');

ALTER TABLE Orders
ADD COLUMN Price FLOAT;
UPDATE Orders SET Price = 19.99 WHERE Order_ID = 1;
UPDATE Orders SET Price = 29.99 WHERE Order_ID = 2;
UPDATE Orders SET Price = 39.99 WHERE Order_ID = 3;
UPDATE Orders SET Price = 49.99 WHERE Order_ID = 4;
UPDATE Orders SET Price = 59.99 WHERE Order_ID = 5;
UPDATE Orders SET Price = 39.99 WHERE Order_ID = 6;
UPDATE Orders SET Price = 29.99 WHERE Order_ID = 7;

select * from customers;
select * from orders;

select sum(price) as "totalsum" from orders

select customer_name,count(order_id) from 

--Write query for atleasse one order from a customer and price is greater than 20
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

--Can you provide the list of customer who have ordered more than 5 items
select * from  customers where customer_id in(

select customer_id from orders group by customer_id having count(customer_id)>=5

);
--write query to 
select * from customers where customer_id in(
select customer_id from orders order by timestampdiff(day,order_Date,Current_date))limit 1

--what is the average price of all the order made
select avg(price) from orders;



--Can you provide the details of customers who have never placed an order?

select * from customers where customer_id not in(
select customer_id from orders)


-- What are all the orders that are priced above the average order price?
 
 select order_id from orders where price >
 (
 select avg(price) from orders
 );
 
 --Who are the customers that have ordered a specific item?

 --What is the total amount spent by each customer?
 
select sum(price),customer_id from orders group by customer_id or
select sum(o.price),o.customer_id,c.customer_name from orders o join customers c on o.customer_id=c.customer_id group by customer_id

--Which customer has the highest total order price?
select customer_id,sum(price) from orders group by customer_id order by sum(price) desc limit 1;
or
select o.customer_id,c.customer_name,sum(o.price) from orders o join customers c on o.customer_id=c.customer_id 
group by customer_id order by sum(price) desc limit 1;

--How many customers have made more than three orders?

select * from customers where customer_id in(
select customer_id,count(customer_id) from orders group by customer_id having count(customer_id)>=3)


-- Can you find customers who have ordered products with a price less than a certain amount?

select * from customers where customer_id in(
select customer_id from orders where price<30);

select * from customers where customer_id in(
select customer_id from orders
--write a query to extract the customer name who has minimumu salary
select min(o.price),c.customer_name
from customers c join orders o on c.customer_id=o.customer_id group by c.customer_name order by min(o.price) limit 1
or
select* from customers where customer_id in(
select customer_id from orders where price in(
select min(price) from orders))

select distinct top 3  order_id   from orders
SELECT TOP 3 customer_name FROM Customers;


select name, timestampdiff(year,dob,sysdate()) as year from employee 
select* from customers where customer_id in(
select customer_id from orders where price>20  group by customer_id having count(customer_id)>1)

select * from orders




create database project;
use project;

CREATE TABLE Employee (
    emp_id VARCHAR(255) NOT NULL,
    emp_name VARCHAR(255) NOT NULL,
    salary INT NOT NULL,
    dept_id CHAR(5) NOT NULL,
    manager_id VARCHAR(255),
    PRIMARY KEY (emp_id)
);

CREATE TABLE Department (
    dept_id VARCHAR(255) NOT NULL,
    dept_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (dept_id)
    
);

CREATE TABLE Manager (
    manager_id VARCHAR(255) NOT NULL,
    manager_name VARCHAR(255) NOT NULL,
    dept_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (manager_id),
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Projects (
    project_id VARCHAR(255) NOT NULL,
    project_name VARCHAR(255) NOT NULL,
    team_member_id VARCHAR(255) NOT NULL);



INSERT INTO Employee (emp_id, emp_name, salary, dept_id, manager_id) 
VALUES('E1', 'NAVEEN', 15000, 'D1', 'M1'),
 ('E2', 'Manoj', 15000, 'D1', 'M1'),
 ('E3', 'James', 55000, 'D2', 'M2'),
 ('E4', 'Michel', 25000, 'D2', 'M2'),
 ('E5', 'Ali', 20000, 'D10', 'M3'),
 ('E6', 'Robin', 35000, 'D10', 'M3');


INSERT INTO Department (dept_id, dept_name)
VALUES 
('D12', 'Admin'),
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');


INSERT INTO Manager (manager_id, manager_name, dept_id)
VALUES 
('M1', 'Prem', 'D3'),
('M2', 'Shripadh', 'D4'),
('M3', 'Nick', 'D1'),
('M4', 'Cory', 'D1');

INSERT INTO Projects (project_id, project_name, team_member_id)
VALUES 
('P1', 'DataMigration', 'E1'),
('P1', 'DataMigration', 'E2'),
('P1', 'DataMigration', 'M3'),
('P2', 'ETL Tool', 'E1'),
('P3', 'ETL Tool', 'M4');




1. Fetch the empname and department name they belongs to 

select e.* from employee as e 
inner join department as d
on e.dept_id=d.dept_id

--2. Fetch All the employee name and their name they belongs to
select e.* from employee as e 
left join department as d
on e.dept_id=d.dept_id

select * from department as d
right join employee as e
on d.dept_id=e.dept_id


-- Write a SQL query to fetch the names of employees who work under the same manager and the manager's name.

select * from employee e 
join manager m  on e.manager_id=m.manager_id


-- Write a SQL query to join the Employee and Department tables and fetch the employee's name and their respective department names.


select * from employee e join department d on e.dept_id=d.dept_id

--Write a SQL query to retrieve all managers and the number of employees they manage.

select count(e.emp_id),m.manager_name from employee e 
join manager m on e.manager_id=m.manager_id group by m.manager_name

--Write a SQL query that displays a list of employees who are not managers.

select * from manager where manager_id not in(
select m.manager_id from manager m  
join employee e on m.manager_id=e.manager_id )



-- Write a SQL query to fetch the details of the projects and the respective details of the team members involved in those projects.

(select * from projects p 
join employee e on  p.team_member_id=e.emp_id)


--Write a SQL query to fetch all information about employees, their departments, their managers, and the projects they are involved in.

select * from employee e
join department d on e.dept_id=d.dept_id
join projects p on e.emp_id=p.team_member_id


-- Write a SQL query to get the employee name, 
--their manager name,
-- and department name where the department ID is the same in the Department and Manager table.

Select * from manager

select e.emp_name,m.manager_name,d.dept_name
from Employee e
join manager m on e.manager_id=m.manager_id
join department d on d.dept_id=m.dept_id

--Write a SQL query to fetch all managers who are also employees and the projects handled by their team.


select  m.manager_name,p.project_name from manager m 
join employee e on m.manager_id=e.manager_id
join projects p on p.team_member_id=e.emp_id

--Write a SQL query to get the names of all employees who are not involved in any project.

select * from employee where emp_id not in(
select team_member_id from projects p join employee e on p.team_member_id=e.emp_id)

-- Write a SQL query to fetch all departments which don't have any employees.

select * from department where dept_id not in(
select distinct e.dept_id from employee e join department d on e.dept_id=d.dept_id)



--Write a SQL query to fetch the managers name along with the count of the number of employees and the number of projects handled by his/her team.

select manager_name,count(emp_id),count(project_id) 
from manager m join employee e on m.manager_id=e.manager_id
join projects p on p.team_member_id=e.emp_id
group by manager_name

select * from manager;
select * from employee;
select * from department;

select * from projects;

--Write a SQL query to fetch the names of all departments along with the less paid employees name in each department.

select d.dept_name,e.emp_name,min(e.salary) from department d join employee e on d.dept_id=e.dept_id group by d.dept_name,e.emp_name having min(e.salary)<16000;

--Write a SQL query to fetch project-wise count of employees.

select project_name,count(team_member_id) from projects p join employee e on p.team_member_id=e.emp_id group by project_name

--Write a SQL query to fetch the list of employees who are managed by the manager who manages the most number of employees.


select e.emp_name from employee e where e.manager_id=
(select m.manager_id from manager m join employee e1 on 
m.manager_id=e1.manager_id group by m.manager_id
order by  count(e1.emp_id) desc limit 1);

#Write a SQL query to fetch department-wise count of projects.
SELECT d.dept_name,count(p.project_id)
from department d
join employee e 
on d.dept_id=e.dept_id
join projects p
on p.team_member_id= e.emp_Id
group by d.dept_name
select * from projects;


select distinct dept_id from employee
union 
select distinct dept_id from department

#List all departments along with the number of employees in each.

select dept_name,count(emp_id) from department d join employee e on d.dept_id=e.dept_id group by dept_name

--Get the total number of projects each employee is working on.

select e.emp_name,count(p.project_id)
from employee e join projects p on e.emp_id=p.team_member_id group by e.emp_name

#Find the department name and the highest salary in each department.

select e.dept_id,d.dept_name ,max(salary) from department d join employee e on d.dept_id=e.dept_id group by dept_id

--Find all projects that involve team members from multiple departments.

select p.*,d.dept_name from projects p join employee e on p.team_member_id=e.emp_id
join department d on d.dept_id=e.dept_id

--Retrieve employees who work under the same manager and belong to the same department.

select emp_name,e.manager_id,d.dept_id from employee e join manager m on e.manager_id=m.manager_id
join department d on d.dept_id=e.dept_id



