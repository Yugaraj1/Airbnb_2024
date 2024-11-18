-- Which are the top 10 hosts with the most listings on Airbnb?

SELECT host_id, host_name, COUNT(*) AS host_count
FROM airbnb_2024_table
GROUP BY host_id , host_name
HAVING COUNT(*) > 1
ORDER BY host_count DESC
LIMIT 10;

-- How many unique host_id do we have?

SELECT COUNT(DISTINCT host_id) AS unique_host_count
FROM airbnb_2024_table;

-- Which are the top 10 hosts with the most listings, and what is the average price of their listings?

SELECT host_id, host_name,
       COUNT(*) AS host_count, 
       AVG(price) AS avg_price
FROM airbnb_2024_table
GROUP BY host_id , host_name
HAVING COUNT(*) > 1
ORDER BY host_count DESC
LIMIT 10;

-- What are the room_type available in the listings?

SELECT DISTINCT room_type
FROM airbnb_2024_table;

-- How many Airbnb listings are available for each room type?

SELECT room_type, COUNT(*) AS number_of_listings , Avg(price) as Average_Price
FROM airbnb_2024_table
GROUP BY room_type
ORDER BY number_of_listings DESC;

-- What is the average , maximum and minimum rate out of all these Airbnb with room respective to room type?

SELECT room_type, MAX(price) AS Maximum_rate, MIN(price) AS Minimum_rate, avg(price)
FROM airbnb_2024_table
GROUP BY room_type;

-- Find the host_id for the highest price listing

SELECT host_id
FROM airbnb_2024_table
WHERE price = 99999;

-- Check full details for the host to see if they have other properties as well

SELECT *
FROM airbnb_2024_table
WHERE host_id = 132288219;

-- Check the average price for this host's listings by location

SELECT neighbourhood, AVG(price) AS avg_price
FROM airbnb_2024_table
WHERE host_id = 132288219
GROUP BY neighbourhood
ORDER BY avg_price DESC;

-- View individual records for certain locations

SELECT *
FROM airbnb_2024_table
WHERE (neighbourhood = "Botany Bay" 
       OR neighbourhood = "Burwood" 
       OR neighbourhood = "Rockdale" 
       OR neighbourhood = "Sydney")
  AND host_id = 132288219
ORDER BY neighbourhood;

-- Get the average price for each location, excluding outliers like 9999 or 99999 or null

SELECT neighbourhood, AVG(price) AS avg_price
FROM airbnb_2024_table
WHERE host_id = 132288219
  AND price < 1000  
  AND price > 0     
GROUP BY neighbourhood
ORDER BY avg_price DESC;

-- getting average of location Botany Bay to update outlier
SELECT neighbourhood, AVG(price) AS avg_price
FROM airbnb_2024_table
WHERE neighbourhood = 'Botany Bay' AND price < 99999;



-- Update the outliers with average rate

SET SQL_SAFE_UPDATES = 0;

UPDATE airbnb_2024_table
SET price = 300.80
WHERE id = 1170171007313468767;


SET SQL_SAFE_UPDATES = 1;

-- Average price in different locations

SELECT neighbourhood, AVG(price) AS Avg_Price , count(id) as Total_listings
FROM airbnb_2024_table
GROUP BY neighbourhood
ORDER BY Avg_Price DESC
limit 15;

-- Check availability of listings

SELECT name, host_id, neighbourhood, availability_365
FROM airbnb_2024_table
ORDER BY availability_365 ASC;

-- Average availability by location

SELECT neighbourhood, AVG(availability_365) AS avg_availability, AVG(price) AS Avg_price
FROM airbnb_2024_table
GROUP BY neighbourhood
ORDER BY Avg_price desc
Limit 15;

-- Review analysis

SELECT name, neighbourhood, last_review, number_of_reviews, reviews_per_month
FROM airbnb_2024_table;

-- Average reviews by location

SELECT neighbourhood, AVG(number_of_reviews) AS avg_number_of_reviews, AVG(reviews_per_month) AS avg_reviews_per_month
FROM airbnb_2024_table
GROUP BY neighbourhood;


-- let's see how many types of room have each location have and their average

SELECT 
    neighbourhood,
    room_type,
    COUNT(*) AS number_of_listings,
    AVG(price) AS average_price
FROM 
    airbnb_2024_table
GROUP BY 
    neighbourhood, 
    room_type
ORDER BY 
    neighbourhood, 
    room_type;

-- relation between minimum nights and average price with respect to room type

SELECT 
    neighbourhood,
    room_type,
    minimum_nights,
    AVG(price) AS avg_price
FROM airbnb_2024_table
GROUP BY neighbourhood, room_type, minimum_nights
ORDER BY neighbourhood, room_type, minimum_nights;

-- Average price per room type
select room_type , Avg(reviews_per_month)
from airbnb_2024_table
group by room_type;

-- avg avaiability

select id , name , price , number_of_reviews , availability_365 , 
(365 - availability_365) as unavailable,round((availability_365 / 365)*100,2) as avaiability_percent
from airbnb_2024_table;

WITH availability_analysis AS (
    SELECT 
        id, 
        name, 
        price, 
        neighbourhood, 
        availability_365, 
        (365 - availability_365) AS unavailable, 
        ROUND((availability_365 / 365.0) * 100, 2) AS availability_percent,
        CASE
            WHEN ROUND((availability_365 / 365.0) * 100, 2) <= 25 THEN 'Highly Booked'
            WHEN ROUND((availability_365 / 365.0) * 100, 2) <= 50 THEN 'Moderately Booked'
            ELSE 'Low Booking'
        END AS booking_status
    FROM airbnb_2024_table
)
SELECT 
    neighbourhood, 
    booking_status, 
    COUNT(*) AS number_of_listings, 
    AVG(price) AS avg_price, 
    AVG(availability_percent) AS avg_availability_percent
FROM availability_analysis
GROUP BY neighbourhood, booking_status
ORDER BY neighbourhood, booking_status;
