create database shop;
use shop;
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- Insert sample data
INSERT INTO Customer (CustomerID, CustomerName, ContactNumber, Email, Address)
VALUES
(1, 'John Doe', '123-456-7890', 'john.doe@example.com', '123 Main St'),
(2, 'Jane Smith', '987-654-3210', 'jane.smith@example.com', '456 Oak Ave'),
(3, 'David Lee', '555-789-4561', 'david.lee@example.com', '789 Pine Blvd');


CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    ManagerID INT
);

-- Insert sample data
INSERT INTO Department (DepartmentID, DepartmentName, ManagerID)
VALUES
(1, 'Sales', 101),
(2, 'IT', 102),
(3, 'HR', 103);



CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Insert sample data
INSERT INTO Employee (EmployeeID, EmployeeName, DepartmentID, Position, Salary, HireDate)
VALUES
(101, 'Alice Johnson', 1, 'Manager', 60000, '2020-01-15'),
(102, 'Bob Williams', 2, 'IT Specialist', 55000, '2019-03-10'),
(103, 'Catherine Green', 3, 'HR Manager', 58000, '2021-05-01'),
(104, 'David Brown', 1, 'Sales Associate', 40000, '2022-06-18');



CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    EmployeeID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Insert sample data
INSERT INTO Orders (OrderID, OrderDate, CustomerID, EmployeeID, TotalAmount)
VALUES
(1001, '2023-01-15', 1, 104, 250.50),
(1002, '2023-02-10', 2, 101, 150.00),
(1003, '2023-03-05', 3, 102, 300.75);





#Show all employees who were hired after 2020

select * from employee where hiredate>'2020-12-31'


#Find the total amount of orders placed by 'Jane Smith'.

select sum(o.totalAmount) from orders o join customer c  on o.customerID=c.customerID where customername='Jane Smith'

#List the name of the employee who has the highest salary.

select * from employee where salary in(
select max(salary) from employee);


#Count the number of employees in each department.

select d.departmentname,count(e.employeeid) from employee e join department d on e.departmentid=d.departmentid group by d.departmentname


#Find all orders handled by employees who are 'Managers':

select o.* from orders o join employee e on o.employeeid=e.employeeid where e.position='manager'

#Find the customer(s) who placed the highest number of orders:

select * from employee;
select * from customer;
select * from department;
select * from orders;

select c.customername,count(o.orderid) from customer c join orders o on c.customerid=o.customerid 
group by customername order by count(o.orderid) desc limit 1

#Display the name and total orders of employees who have handled more than 2 orders.

select e.employeeid,count(o.orderid) from employee e
join orders o on e.employeeid=o.employeeid
group by e.employeeid having count(o.orderid)>=2


#Find all departments that do not have any employees:

select * from department where departmentid not in(
select d.departmentid from department d join employee e on d.departmentid=e.departmentid)

#List the employees whose salary is above the average salary of their department:

select * from employee e where salary>
(select avg(salary) from employee)

#Display all orders along with the customer and employee names, ordered by the most recent orders first:

select orderid,customername,employeename,orderdate from orders o
join customer c on o.customerid=c.customerid
join employee e on e.employeeid=o.employeeid order by o.orderdate desc










