use book;


-- #note

-- ChatGPT said:
-- ChatGPT
-- To decide between using COUNT or SUM when calculating a total number, consider the context of what you're counting or summing:

-- When to Use COUNT
-- Use COUNT when you want to count the number of rows or occurrences in a table, regardless of the value of a specific column.

-- Examples:
-- Total Number of Rows in a Table

-- SELECT COUNT(*) AS TotalRows FROM Products;
-- Counts all rows in the Products table.
-- Total Number of Products in a Specific Category

-- SELECT COUNT(*) AS TotalProducts
-- FROM Products
-- WHERE Category = 'Electronics';
-- Counts rows where Category = 'Electronics'.
-- Distinct Values

-- SELECT COUNT(DISTINCT ProductName) AS UniqueProducts FROM Products;
-- Counts unique product names.
-- When to Use SUM
-- Use SUM when you want to calculate the total of a numeric column.

-- Examples:
-- Total Quantity in Stock

-- SELECT SUM(Stock) AS TotalStock FROM Products;
-- Adds up all the values in the Stock column.
-- Total Revenue

-- SELECT SUM(TotalPrice) AS TotalRevenue FROM Orders;
-- Adds up all the values in the TotalPrice column.
-- Condition-Based Summation

-- SELECT SUM(Quantity) AS TotalElectronicsSold
-- FROM Orders O
-- JOIN Products P ON O.ProductID = P.ProductID
-- WHERE P.Category = 'Electronics';
-- Sums the Quantity column for orders in the "Electronics" category.
-- Key Difference:
-- Use COUNT to determine the number of entries or occurrences (e.g., number of rows, distinct values, etc.).
-- Use SUM to determine the total of a numeric column (e.g., total revenue, stock, or quantity).
-- Example Comparison:
-- If you want the number of orders placed:

-- SELECT COUNT(*) AS TotalOrders FROM Orders;
-- If you want the total revenue of all orders:

-- SELECT SUM(TotalPrice) AS TotalRevenue FROM Orders;
-- Rule of Thumb:
-- If you're counting rows or unique values → Use COUNT.
-- If you're adding numeric values → Use SUM.




CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 750.00, 50),
(2, 'Smartphone', 'Electronics', 500.00, 120),
(3, 'Chair', 'Furniture', 75.00, 200),
(4, 'Desk', 'Furniture', 150.00, 80),
(5, 'Refrigerator', 'Appliances', 1200.00, 20);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

INSERT INTO Customers (CustomerID, Name, Email, Phone, City) VALUES
(1, 'Alice Johnson', 'alice.johnson@example.com', '1234567890', 'New York'),
(2, 'Bob Smith', 'bob.smith@example.com', '0987654321', 'Los Angeles'),
(3, 'Charlie Brown', 'charlie.brown@example.com', '1122334455', 'Chicago'),
(4, 'Daisy Miller', 'daisy.miller@example.com', '2233445566', 'Houston'),
(5, 'Ethan Clark', 'ethan.clark@example.com', '3344556677', 'Phoenix');


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity, TotalPrice) VALUES
(1, 1, 1, '2024-12-01', 2, 1500.00),
(2, 2, 2, '2024-12-02', 1, 500.00),
(3, 3, 3, '2024-12-03', 4, 300.00),
(4, 4, 4, '2024-12-03', 1, 150.00),
(5, 5, 5, '2024-12-03', 1, 1200.00);


#Find the total number of products available in the "Electronics" category.
SELECT COUNT(*) AS TotalProducts
FROM Products
WHERE Category = 'Electronics';


#Find the total number of products in the Products table.
select count(*) from products;




#Calculate the total revenue generated from all orders.
select sum(totalprice) from orders;


#Determine the average price of all products.
select avg(price) from products;



#Identify the maximum order amount placed.
select max(totalprice) from orders;

#Find the minimum stock available among all products.
select min(stock) from products;

#Identify the second maximum order amount placed.
select max(TotalPrice) from orders where TotalPrice not in(
select max(totalprice) from orders);


#Count the number of products available in each category.
select count(*),category from products group by Category



#Calculate the total quantity sold for each product.
select sum(quantity),ProductID from orders group by ProductID;

#Find the average order value for each customer.
select avg(TotalPrice),customerid from orders group by CustomerID


#Display the total revenue generated for each product and order the results by revenue in descending order.
select sum(totalprice),productid from orders group by productid order by sum(totalprice) desc;




#Retrieve the number of orders placed by each customer.
select count(*) as "nuberoforders",customerid from orders group by CustomerID;


select * from products;
select * from customers;
select * from orders;
#List customers who have placed orders totaling more than oe equal $1000.
select customerid,sum(totalprice)  from orders group by CustomerID having sum(TotalPrice)>=1000;




#Identify the product that has generated the highest total revenue.
select productid,sum(totalprice) from orders group by ProductID order by sum(TotalPrice) desc limit 1

#Find the average price of products for each category.
select  avg(price),category from products group by category;



#Calculate the total revenue generated in a specific month (e.g., December 2024).
select sum(totalprice)from orders where month(orderdate)='12';


#Determine the product with the lowest stock after considering all orders.

with 
cet as(
select sum(o.quantity) as "totalqunatitys",p.productname,o.ProductID from 
products p join orders o on p.ProductID=o.ProductID group by p.ProductName,o.ProductID)

select min(p1.stock-c.totalqunatitys) as "lowest_stack",p1.ProductName 
from products p1 join cet c on p1.ProductID=c.productid group by p1.ProductName order by lowest_stack limit 1



#Count the number of distinct cities where customers reside.
select count(distinct(city)) from customers;



#Retrieve products with a price higher than the average price of all products.
select ProductName,price from products where price>(
select avg(price) from products)



#Calculate the total quantity sold of products in the "Electronics" category.
select sum(o.quantity) from  orders o join products p on p.ProductID=o.ProductID where p.Category='Electronics';


#List all orders with a total price greater than the average order price.

select totalprice,OrderID from orders where TotalPrice>(
select avg(totalprice) from orders)



#Calculate the total revenue generated by each city.
select sum(o.totalprice),c.city  from customers c join orders o on c.CustomerID=o.CustomerID group by c.city

#Find the maximum quantity sold in a single order for each product.
select max(quantity),productid from orders group by productid 




#Calculate the number of customers who have purchased from each category.
select count(distinct o.customerid),p.category from orders o join products p on p.ProductID=o.ProductID group by Category



#Find the total revenue and the number of orders placed by each customer.
select sum(o.totalprice),count(*),c.name from orders o join customers c on c.CustomerID=o.CustomerID  group by c.name



#Identify customers whose total spending is above the overall average revenue per customer.
select sum(totalprice),CustomerID from orders group by CustomerID having sum(TotalPrice)>
(select avg(TotalPrice) from orders)  

#Find products with stock levels below the average stock of all products.
select stock,productname from products where stock<(
select avg(stock) from products);



#Display the average order value for customers who placed more than 3 orders.
with cte as(
select count( o.customerid) as "ordercount",CustomerID from orders o group by CustomerID)
select avg(o.totalprice),c.CustomerID from orders o join cte c on o.CustomerID=c.CustomerID where c.ordercount>=3 group by c.CustomerID
use book;


#Find the total sales for each product (quantity sold and total revenue).
select sum(quantity),productid from orders group by ProductID

#List the names of customers who have purchased a total worth more than $1000.

select sum(totalprice),customerid from orders group by customerid having sum(totalprice)>1000






#Find customers who have placed more than 2 orders.
select  count(customerid),CustomerID from orders group by CustomerID having count(CustomerID)>=2

select * from products;
select * from customers;
select * from orders;


#Identify products that have never been ordered by any customer.
select * from products where productid not in(
select distinct productid from orders)


#Find the customer who spent the most on purchases.
select customerid,sum(totalprice)  from orders group by customerid order by sum(totalprice) desc limit 1

#Display customers and the number of distinct categories of products they have purchased.
select distinct category ,o.customerid from products p join orders o on o.productid=p.productid

SELECT 
    o.CustomerID,
    COUNT(DISTINCT p.Category) AS DistinctCategoriesPurchased
FROM 
    Orders o
JOIN 
    Products p ON o.ProductID = p.ProductID
GROUP BY 
    o.CustomerID;

