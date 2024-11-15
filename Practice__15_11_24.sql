create database helth;
use helth;

CREATE TABLE HOTELS (
    HOTEL_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    CITY VARCHAR(50),
    RATING DECIMAL(2, 1),
    ROOMS_AVAILABLE INT
);

CREATE TABLE GUESTS (
    GUEST_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    PHONE VARCHAR(15),
    EMAIL VARCHAR(100),
    CITY VARCHAR(50)
);

CREATE TABLE BOOKINGS (
    BOOKING_ID INT PRIMARY KEY,
    GUEST_ID INT,
    HOTEL_ID INT,
    CHECKIN_DATE DATE,
    CHECKOUT_DATE DATE,
    ROOMS_BOOKED INT,
    FOREIGN KEY (GUEST_ID) REFERENCES GUESTS(GUEST_ID),
    FOREIGN KEY (HOTEL_ID) REFERENCES HOTELS(HOTEL_ID)
);

-- Insert data into HOTELS
INSERT INTO HOTELS (HOTEL_ID, NAME, CITY, RATING, ROOMS_AVAILABLE) VALUES
(1, 'Grand Paradise', 'Paris', 5.0, 10),
(2, 'Ocean Breeze', 'Miami', 4.5, 25),
(3, 'Mountain View Resort', 'Denver', 4.8, 15),
(4, 'Urban Stay', 'New York', 4.0, 20);

-- Insert data into GUESTS
INSERT INTO GUESTS (GUEST_ID, NAME, PHONE, EMAIL, CITY) VALUES
(101, 'Alice Brown', '9876543210', 'alice@guest.com', 'Los Angeles'),
(102, 'Bob Martin', '8765432109', 'bob@guest.com', 'Miami'),
(103, 'Clara Johnson', '7654321098', 'clara@guest.com', 'Denver'),
(104, 'David Lee', '6543210987', 'david@guest.com', 'New York');

-- Insert data into BOOKINGS
INSERT INTO BOOKINGS (BOOKING_ID, GUEST_ID, HOTEL_ID, CHECKIN_DATE, CHECKOUT_DATE, ROOMS_BOOKED) VALUES
(1001, 101, 1, '2023-10-05', '2023-10-10', 1),
(1002, 102, 2, '2023-11-01', '2023-11-05', 2),
(1003, 103, 3, '2023-10-15', '2023-10-20', 1),
(1004, 104, 4, '2023-11-10', '2023-11-12', 1);


ALTER TABLE HOTELS
ADD price_per_room DECIMAL(10, 2);

UPDATE HOTELS
SET price_per_room = 100
WHERE hotel_id = 1;

UPDATE HOTELS
SET price_per_room = 150
WHERE hotel_id = 2;

UPDATE HOTELS
SET price_per_room = 120
WHERE hotel_id = 3;

UPDATE HOTELS
SET price_per_room = 130
WHERE hotel_id = 4;





#Find all bookings with more than 1 room booked.
select * from bookings where rooms_booked>1;

#List guests who have checked in after October 1, 2023.
select * from guests where guest_id in(
select guest_id from bookings where CHECKOUT_DATE>'2023-10-01');


#Retrieve the names of guests along with the hotels they have booked

select g.name,h.name from guests g join bookings b on g.guest_id=b.guest_id
join hotels h on h.hotel_id=b.hotel_id;

#List all bookings along with the city of the guest.
select b.*,g.city from bookings b join guests g on b.guest_id=g.guest_id;



#List guests who have booked hotels in the same city as themselves.

select g.* from guests g where g.guest_id in(
select b.guest_id from
bookings b join hotels h on b.hotel_id=h.hotel_id
join guests g on g.guest_id=b.guest_id where g.city=h.city); 

#Calculate the total rooms booked for each hotel.

select hotel_id ,COUNT(rooms_booked) from bookings group by hotel_id;


#Find the average rating of all hotels.
select avg(rating) from hotels 

#Count the total number of bookings made by each guest.
select COUNT(*),guest_id from bookings group by guest_id


#Calculate the total revenue generated from each hotel based on rooms booked.

with cte as(
select b.hotel_id,(sum(rooms_booked)*price_per_room ) as total_revenue 
from bookings b join hotels h on b.hotel_id=h.hotel_id  group by hotel_id)
select h.hotel_id,h.name,c.total_revenue from hotels h join cte c on h.hotel_id=c.hotel_id

#Identify guests who have booked more than one hotel.
select guest_id,count(hotel_id) from bookings group by guest_id having count(hotel_id)>1





#Find the hotel with the highest number of available rooms.
select * from hotels where ROOMS_AVAILABLE in(
select max(ROOMS_AVAILABLE) from hotels)

select * from hotels;
select * from guests;
select * from bookings;
#Identify guests who have booked in hotels with a rating greater than 4.5.
with cte as(
select b.guest_id,b.hotel_id,h.name,h.rating from bookings b join hotels h on b.hotel_id=h.hotel_id where h.rating>4.5)
select g.name as guest_name,c.name as hotel_name,c.rating from guests g join cte c on c.guest_id=g.guest_id


#Find the guest who has booked the highest number of rooms.
select g.* ,b.rooms_booked from guests g join bookings b on b.guest_id=g.guest_id where b.rooms_booked in(
select max(rooms_booked) from bookings as rooms_booked)




