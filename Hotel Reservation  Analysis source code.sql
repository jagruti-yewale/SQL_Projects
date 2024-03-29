--first we create a table my_data and add a attributes name as we have in dataset.
create table public."my_data"(Booking_ID varchar(20), no_of_adults int,
							  no_of_children int, no_of_weekend_nights int,
							 no_of_week_nights int, type_of_meal_plan varchar(50),
							 room_type_reserved varchar(20),lead_time int, 
							 arrival_date varchar(20), market_segment_type varchar(20),
							 avg_price_per_room float, booking_status varchar(30))
						
--table is successfull created
--just check out the format of table
select * from my_data
--this table is empty beacause we do not fit any records in the table
--lets import the data of hotel reservation data csv file into my_data table.
--this is the first method for uploading the dataset
COPY public."my_data" from 'C:/Users/SONY/Documents/DBMS/Hotel Reservation Dataset.csv' delimiter ',' csv header
--second method is from import and export option
select * from my_data
--1st querry
--What is the total number of reservations in the dataset?
select count(booking_id) as total_Reservation
from my_data;

--2nd querry
--Which meal plan is the most popular among guests?
select type_of_meal_plan , count(*) as most_popular_meal
from my_data
group by type_of_meal_plan
order by most_popular_meal desc;

--3rd querry
--What is the average price per room for reservations involving children?
select avg(avg_price_per_room) as Average_price_per_room_with_children
from my_data
where no_of_children >=1;

--4th
--How many reservations were made for the year 20XX (replace XX with the desired year)?
select count(*) as Total_Reservation_2017
from my_data
where arrival_date like '%2017%';
--5th
--What is the most commonly booked room type?
select * from my_data
select room_type_reserved, count(*) as most_common_room_type
from my_data
group by room_type_reserved
order by most_common_room_type desc;
--6th
--How many reservations fall on a weekend (no_of_weekend_nights > 0)?
select count(*) as Reservation_of_Weekends
from my_data
where no_of_weekend_nights > 0;
--7th
--What is the highest and lowest lead time for reservations?
select min(lead_time) as Lowest_Lead_Time, max(lead_time) as Highest_lead_Time
from my_data;
--8th
--What is the most common market segment type for reservations?
select market_segment_type,count(*) as most_common_market_segment_type
from my_data
group by market_segment_type
order by most_common_market_segment_type desc;
--9th
-- How many reservations have a booking status of "Confirmed"?
select count(booking_status) as confirmed_reservation
from my_data
where booking_status='Not_Canceled'
--10th
--What is the total number of adults and children across all reservations?
select sum(no_of_adults) as total_adults,sum(no_of_children) as total_children
from my_data;
--11th
--What is the average number of weekend nights for reservations involving children?
select avg(no_of_weekend_nights) as avg_weekend_night_with_children
from my_data
where no_of_children > 0;
--12th
-- How many reservations were made in each month of the year?
select extract(month from arrival_date) as month, count(*) as reservation_per_month
from my_data
group by extract(month from arrival_date)
order by extract(month from arrival_date);
--or
select arrival_date as month,count(*) as reservation_per_month
from my_data
group by arrival_date
--13th 
--What is the average number of nights (both weekend and weekday) spent by guests for each roomtype?
select room_type_reserved,avg(no_of_weekend_nights + no_of_week_nights) as avg_nights
from my_data
group by room_type_reserved
--14 
--For reservations involving children, what is the most common room type, and what is the average price for that room type?
select room_type_reserved as most_common_type , count(*)as count , avg(avg_price_per_room) as avg_price
from my_data
where no_of_children > 0
group by room_type_reserved
--15
--Find the market segment type that generates the highest average price per room.
select market_segment_type, avg(avg_price_per_room) as highest_avg_price_per_room
from my_data
group by market_segment_type
order by highest_avg_price_per_room desc;




