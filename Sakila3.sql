USE sakila;
SET sql_mode="";
-- 1. How many customers are there for each country?  Have your result display the full country name and the number of customers for each country.
SELECT country.country AS country, count(*) AS total_number_of_customer
FROM address
LEFT JOIN customer ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY country.country
ORDER BY country.country ASC;

-- 2. How many customers are there for each city?  Have your result display the full city name, the full country name, as well as the number of customers for each city.
SELECT city.city AS city, country.country AS country, count(customer.customer_id) AS numbers_of_customers
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY city.city_id;
-- Now, look at the payment table where it has information about the customer as well as how much the customer paid to rent the item.  Based on this,
-- 1. Retrieve both the average rental amount, the total rental amount, as well as the total number of transactions for each month of each year.
SELECT DATE_FORMAT(payment_date, '%M-%Y') AS month_and_year, sum(amount) AS total_rental_amount, count(*) AS total_transactions, AVG(amount) AS average_rental_amount 
FROM payment
GROUP BY month_and_year;
-- 2. Your manager comes and asks you to pull payment report based on the hour of the day.  The managers wants to know which hour the company earns the most money/payment. 
--    Have your sql query generate the top 10 hours of the day with the most sales.  
--    Have the first row of your result be the hour with the most payments received.
SELECT DATE_FORMAT(payment_date,"%h %p") AS hour_of_the_day, sum(amount) AS total_payments_received
FROM payment
GROUP BY hour_of_the_day
ORDER BY total_payments_received DESC
LIMIT 10;