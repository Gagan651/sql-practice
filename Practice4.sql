CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150),
    author_id INT,
    published_year INT,
    genre_id INT
);

ALTER TABLE Books ADD COLUMN price DECIMAL(10, 2);

SET SQL_SAFE_UPDATES = 0;


UPDATE Books
SET price = CASE
    WHEN book_id = 1 THEN 15.99
    WHEN book_id = 2 THEN 12.50
    WHEN book_id = 3 THEN 10.00
    WHEN book_id = 4 THEN 8.75
    WHEN book_id = 5 THEN 20.00
    ELSE price  -- Keep the price unchanged for other book_ids
END;



CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);

CREATE TABLE Genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(50)
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    membership_date DATE
);

CREATE TABLE Borrowed_Books (
    book_id INT,
    member_id INT,
    borrow_date DATE,
    return_date DATE,
    PRIMARY KEY (book_id, member_id, borrow_date),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Authors (author_id, author_name)
VALUES 
(1, 'George Orwell'),
(2, 'J.K. Rowling'),
(3, 'J.R.R. Tolkien');


INSERT INTO Genres (genre_id, genre_name)
VALUES 
(1, 'Dystopian'),
(2, 'Fantasy'),
(3, 'Adventure');

INSERT INTO Books (book_id, title, author_id, published_year, genre_id)
VALUES 
(1, '1984', 1, 1949, 1),
(2, 'Harry Potter and the Sorcerer\'s Stone', 2, 1997, 2),
(3, 'The Hobbit', 3, 1937, 2),
(4, 'Animal Farm', 1, 1945, 1),
(5, 'The Lord of the Rings', 3, 1954, 3);


INSERT INTO Members (member_id, first_name, last_name, membership_date)
VALUES 
(1, 'Alice', 'Brown', '2021-05-01'),
(2, 'Bob', 'Smith', '2021-06-15'),
(3, 'Charlie', 'Johnson', '2021-07-20');


INSERT INTO Borrowed_Books (book_id, member_id, borrow_date, return_date)
VALUES 
(1, 1, '2023-07-10', '2023-07-20'),
(2, 2, '2023-07-12', '2023-07-18'),
(3, 3, '2023-07-13', NULL),
(4, 1, '2023-08-01', '2023-08-10'),
(5, 2, '2023-08-05', NULL);


#Find all customers who registered after January 1, 2022.

select * from members where membership_date>'2022-01-01';

#List all products along with their prices and categories.

select b.title,b.price,g.genre_name from books b join genres g on b.genre_id=g.genre_id;

#Display all members who have never borrowed a book.

select * from Members where member_id not in(
select  distinct member_id from borrowed_books )

#Write a query to list all authors who have written more than 3 books.

select * from books where author_id in(
select author_id from books group by author_id having count(author_id)>=2);

#Retrieve the highest and lowest priced books.
select title from books where price in(
select min(price) from books
union all
select max(price) from books);

#Write a query to get the count of books for each genre.

select count(book_id),genre_id from books group by genre_id;

select * from Books;
select * from Authors ;
select * from Genres;
select * from  Members;
select * from Borrowed_Books;
#Retrieve the top 5 most expensive books.

select * from books order by price desc limit 5;

#How would you list the number of books published each year
select title,published_year,count(book_id) from books group by published_year,title;

#Write a query to retrieve book titles along with their authors' names.

select b.title,a.author_name from books b join authors a on b.author_id=a.author_id;

#How can you list all books along with their corresponding genres?

select b.title,g.genre_name from books b join genres g on b.genre_id=g.genre_id;


#Find all members who have borrowed books, along with the titles of those books.

with cte as
(select distinct member_id ,book_id from Borrowed_Books )

select m.first_name,m.last_name,b.title from members m join cte c on m.member_id=c.member_id
join books b on b.book_id=c.book_id;

