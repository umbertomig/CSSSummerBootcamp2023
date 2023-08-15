-- 
-- CSS 201.5
-- MS Computational Social Sciences Bootcamp
-- Dr. Umberto Mignozzetti
-- 
-- ###############
-- ## SQL Class ##
-- ###############
-- 

-- What is SQL?

/* 

   From Wikipedia:

   Structured Query Language (SQL) S-Q-L, sometimes "sequel" for historical reasons, 
   is a domain-specific language used in programming and designed for managing data 
   held in a relational database management system (RDBMS), or for stream processing 
   in a relational data stream management system (RDSMS). It is particularly useful 
   in handling structured data, i.e., data incorporating relations among entities 
   and variables.
   
   (https://en.wikipedia.org/wiki/SQL)
   
*/

-- 
-- Can we use SQL on Jupyter? Yes. I never tried though. We can try later if you want to: 
-- (https://www.datacamp.com/tutorial/sql-interface-within-jupyterlab)
-- 

-- Comment in one line

/* Also work for commenting */
/* Could potentially
   work for more 
   general comments */
   
-- As a pattern, we write SQL commands in upper case
-- and other things in lowercase
-- Example:

/* 
SELECT * FROM my_table;
*/

-- And this prints the table my_table in the screen

/* Operations with databases */

-- To create a new database:
CREATE DATABASE mydb;

-- To erase a database (warning: no way back!)
DROP DATABASE mydb;

-- Exercise: create a database and name it newdb.
CREATE DATABASE newdb;

-- To show all the databases in memory:
SHOW DATABASES;

-- To use a particular database:
-- USE database_name;
-- Exercise: use the database that we created.
USE newdb;

-- The new dataset has no tables inside it
-- but if it had, to display the tables we run:
SHOW TABLES;

/* Data types */

-- See the slides for the data types
SHOW CHARACTER SET;

/* Create a new table */

-- Create table to store personal info:
CREATE TABLE person
  (person_id SMALLINT UNSIGNED,
  fname VARCHAR(20),
  lname VARCHAR(20),
  eye_color ENUM('BR','BL','GR'),
  birth_date DATE,
  street VARCHAR(30),
  city VARCHAR(20),
  state VARCHAR(20),
  country VARCHAR(20),
  postal_code VARCHAR(20),
  CONSTRAINT pk_person PRIMARY KEY (person_id)
);

-- Table description
DESC person;

-- Change something in my Table Structure:
ALTER TABLE person
  MODIFY person_id SMALLINT
  UNSIGNED AUTO_INCREMENT;

-- Insert data:
INSERT INTO person
  (person_id, fname, 
  lname, eye_color, 
  birth_date) VALUES 
  (null, 'William',
  'Turner', 'BR', 
  '1972-05-27');

-- Exercise: insert info person slides:
INSERT INTO person 
  (person_id, fname, 
  lname, eye_color, 
  birth_date, street, city,
  state, country, postal_code) VALUES 
  (null, 'Susan', 'Smith',
  'BL', '1975-11-02', 
  '23 Maple St.', 'Arlington',
  'VA', 'USA', '20220');

-- And to do a quick SELECT in here:
SELECT person_id, fname, lname, birth_date FROM person;

-- Or to select all columns, use the star:
SELECT * FROM person;

-- And to update William's data:
UPDATE person
  SET street = '1225 Tremont St.',
  city = 'Boston',
  state = 'MA',
  country = 'USA',
  postal_code = '02138'
  WHERE person_id = 1;

-- Note the pattern: COMMAND1 place1 COMMAND2 place2 and etc...

-- Deleting rows (warning: be careful with this!)
DELETE FROM person
  WHERE person_id = 2;

-- Exercise:
-- 1. Add your info to the dataset. 
-- 2. Change your address to '200 Dowman Dr'. 
-- 3. Show your dataset.
-- 4. Erase the entry with your info.
INSERT INTO person 
  (person_id, fname, 
  lname, eye_color, 
  birth_date, street, city,
  state, country, postal_code) VALUES 
  (null, 'John', 'Doe',
  'BL', '1975-11-02', 
  '9500 Gilman Dr', 'La Jolla',
  'CA', 'USA', '92093');

SELECT * FROM person;

UPDATE person
  SET street = '9501 Gilman Dr'
  WHERE person_id = 3;

SELECT * FROM person;

DELETE FROM person
  WHERE person_id = 3;


/*************************************/
/* Import the databases we will need */
/*************************************/

-- sakila
-- Check the sakila database on the MySQL website
-- Two steps: 
--   First, import the schema
--   Second, import the data

-- world
--   Check the world database on the MySQL website

-- employee
--   Check the employee database on the MySQL website

-- soccer
--   There is a lovely database regarding soccer.
--   I still didn't find a downloadable version of it

-- Exercise: Import and load sakila.
-- 
-- 

-- Getting started
USE sakila;

-- Show tables
SHOW TABLES;

/* SELECT */
SELECT * FROM category;

-- Exercise: do the same with table language
-- 
-- 

-- SELECT for some variables
SELECT name FROM category;

-- Exercise: select `language_id` and `name` from 
-- the table `language`
-- 
-- 

-- SELECT with aliases
SELECT language_id,
  'COMMON' AS language_usage,
  language_id * 3.1415927 AS lang_pi_value,
  upper(name) AS language_name
  FROM language;

-- SELECT and SELECT DISTINCT
SELECT actor_id 
  FROM film_actor 
  ORDER BY actor_id;

SELECT DISTINCT actor_id 
  FROM film_actor 
  ORDER BY actor_id;

-- Exercise: how many types of movies by rating we have? 
-- Hint: table film column rating
-- 
-- 

/*************************************/
/* SELECT + WHERE */
/*************************************/

SELECT title
  FROM film
  WHERE rating = 'G' AND
    rental_duration >= 7;

SELECT title
  FROM film
  WHERE rating = 'G' OR
    rental_duration >= 7;

-- Exercise: select the title and rating for all 'R' rated movies.
-- 
-- 

-- More complicated WHERE clauses:
SELECT title, rating, rental_duration
  FROM film
  WHERE 
    (rating = 'G' AND rental_duration >= 7) 
	OR 
	(rating = 'PG-13' AND rental_duration < 4);

-- To simply count the number:
SELECT count(*)
  FROM film
  WHERE ratirang = 'G';

-- Exercise: count the number of 'R' rated movies.
-- 
-- 

-- SELECT + WHERE (range)
SELECT customer_id, rental_date
    FROM rental
    WHERE rental_date <= '2005-06-16'
      AND rental_date >= '2005-06-14';

-- Range using BETWEEN operator:
SELECT customer_id, rental_date
   FROM rental
   WHERE rental_date BETWEEN
      '2005-06-14' AND '2005-06-16';
      
SELECT customer_id, payment_date, amount
  FROM payment
  WHERE amount BETWEEN 10.0 AND 11.99;

-- Also works for strings:
SELECT last_name, first_name
  FROM customer
  WHERE last_name BETWEEN 'FA' AND 'FR';

-- Membership:
SELECT title, rating
  FROM film
  WHERE rating IN ('G','PG');

-- Exercise: select all movies PG-13 and R.
-- 
-- 

-- NOT IN:
SELECT title, rating
  FROM film
  WHERE rating NOT IN ('G','PG');

-- Exercise: select all but PG-13 or R rated movies.
answers_here

-- LIKE
SELECT title, rating
  FROM film
  WHERE title LIKE 'AM%';

-- Exercise: select all movies ending with 'T'.
-- 
-- 

-- Wild card:
SELECT title, rating
  FROM film
  WHERE title LIKE 'S_E%';


/*************************************/
/* Other queries */
/*************************************/

-- LIMIT:
SELECT title, rating
  FROM film
  WHERE rating IN ('G','PG')
  LIMIT 10;

-- Exercise: select the first 20 PG-13 or R rated movies.
-- 
-- 

-- COUNT:
SELECT COUNT(rating)
  FROM film;

SELECT COUNT(DISTINCT rating)
  FROM film;

-- Functions:
SELECT COUNT(amount),
  AVG(amount), MAX(amount),
  MIN(amount), SUM(amount)
  FROM payment;

-- ORDER BY:
SELECT first_name, last_name
  FROM actor
  ORDER BY last_name DESC;

-- Exercise: do the same ordering, without descending order.
-- 
-- 

-- GROUP BY:
SELECT rating, count(*)
  FROM film
  GROUP BY rating;

-- Exercise: compute the average payment and 
-- number rental frequency for each customer, 
-- ordering by the average payment.
-- 
-- 

-- HAVING:
SELECT rating, 
  count(*) AS n_movies
  FROM film
  GROUP BY rating
  HAVING n_movies > 200;

-- Exercise: compute the average payment and 
-- number rental frequency for each customer, 
-- ordering by the average payment, having 
-- more than 30 rentals.
-- 
-- 


/*************************************/
/* Querying Multiple Tables */
/*************************************/

-- Looking the info in customer
DESC customer;

-- Looking the info in address
DESC address;

-- Cartesian Product: ignores the common keys
SELECT c.first_name, c.last_name, a.address
    FROM customer c JOIN address a;
    
-- Seems like a normal table, but ordering it
-- shows its bad behavior:
SELECT c.first_name, c.last_name, a.address
    FROM customer c JOIN address a
    ORDER BY last_name, first_name;

/* INNER JOIN */
SELECT c.first_name, c.last_name, a.address
    FROM customer c JOIN address a
	ON c.address_id = a.address_id;

-- Exercise: create a table with staff name and 
-- amount paid by customer. Then, check up who is 
-- the employee that generated the maximum revenue.
-- 
-- 

-- Another way to do INNER JOINs:
SELECT c.first_name, c.last_name, a.address
  FROM customer c 
  INNER JOIN address a
    USING (address_id);
    
-- Older JOINs: somewhat different way to do it
SELECT c.first_name, c.last_name, a.address
    FROM customer c, address a
    WHERE c.address_id = a.address_id;

-- Older JOINs: and can keep filtering...
SELECT c.first_name, c.last_name, a.address
    FROM customer c, address a
    WHERE c.address_id = a.address_id
      AND a.postal_code = 52137;

-- Joining more than two tables
DESC address;

DESC city;

SELECT c.first_name, c.last_name, a.address, ct.city
	FROM customer c
	INNER JOIN address a
	ON c.address_id = a.address_id
	INNER JOIN city ct
	ON a.city_id = ct.city_id;

-- STRAIGHT JOIN:
SELECT STRAIGHT_JOIN c.first_name, c.last_name, ct.city
  FROM city ct
  INNER JOIN address a
  ON a.city_id = ct.city_id
  INNER JOIN customer c
  ON c.address_id = a.address_id

-- Exercise: Add also country name to the previous table.
-- 
-- 

-- Join as a table:
SELECT c.first_name, c.last_name, addr.address, addr.city
    FROM customer c
      INNER JOIN
	  (SELECT a.address_id, a.address, ct.city
		FROM address a
		INNER JOIN city ct
		ON a.city_id = ct.city_id
		WHERE a.district = 'California'
	  ) addr
	  ON c.address_id = addr.address_id;

-- And here is only the subquery that generates the table addr:
SELECT a.address_id, a.address, ct.city
	FROM address a
      INNER JOIN city ct
      ON a.city_id = ct.city_id
    WHERE a.district = 'California';

-- Using the same table more than once

-- Films that two actors appeared:
SELECT f.title
    FROM film f
      INNER JOIN film_actor fa
      ON f.film_id = fa.film_id
      INNER JOIN actor a
      ON fa.actor_id = a.actor_id
    WHERE ((a.first_name = 'CATE' AND a.last_name = 'MCQUEEN')
        OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH'));

-- But what if you want films that both actors appeared together?
SELECT f.title
     FROM film f
       INNER JOIN film_actor fa1
       ON f.film_id = fa1.film_id
       INNER JOIN actor a1
       ON fa1.actor_id = a1.actor_id
       INNER JOIN film_actor fa2
       ON f.film_id = fa2.film_id
       INNER JOIN actor a2
       ON fa2.actor_id = a2.actor_id
    WHERE (a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
      AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH');

-- Exercise: Write a query that returns the title of every film in 
-- which an actor with the first name JOHN appeared.
-- 
-- 

-- RIGHT JOIN
SELECT c.first_name, c.last_name, a.address
    FROM customer c 
    RIGHT JOIN address a
	ON c.address_id = a.address_id;

-- LEFT JOIN
SELECT c.first_name, c.last_name, a.address
    FROM customer c 
    LEFT JOIN address a
	ON c.address_id = a.address_id;

/*************************************/
/* GROUP BY again with JOIN now */
/*************************************/

-- Not grouped
SELECT customer_id FROM rental;

-- Grouped
SELECT customer_id
    FROM rental
    GROUP BY customer_id;

-- Counting customers in rentals
SELECT customer_id, count(*)
    FROM rental
    GROUP BY customer_id;

-- Exercise: count actors in films
-- 
-- 

-- It is also useful to order results (ORDER BY):
SELECT customer_id, count(*)
    FROM rental
    GROUP BY customer_id
    ORDER BY 2 DESC;

-- HAVING:
SELECT customer_id, count(*)
    FROM rental
    WHERE count(*) >= 40
    GROUP BY customer_id;

SELECT customer_id, count(*)
    FROM rental
    GROUP BY customer_id
    HAVING count(*) >= 40;

-- Exercise: compute the rental revenue for each movie
-- 
-- 

-- Grouping via expression:
SELECT extract(YEAR FROM rental_date) year,
      COUNT(*) how_many
    FROM rental
    GROUP BY extract(YEAR FROM rental_date);

-- Multiple column grouping:
SELECT fa.actor_id, f.rating, count(*)
    FROM film_actor fa
      INNER JOIN film f
      ON fa.film_id = f.film_id
    GROUP BY fa.actor_id, f.rating
    ORDER BY 1,2;
    
-- Multiple grouping and filtering:
SELECT fa.actor_id, f.rating, count(*)
    FROM film_actor fa
      INNER JOIN film f
      ON fa.film_id = f.film_id
    WHERE f.rating IN ('G','PG')
    GROUP BY fa.actor_id, f.rating
    HAVING count(*) > 9;

-- Grouping WITH ROLLUP
SELECT fa.actor_id, f.rating, count(*)
    FROM film_actor fa
      INNER JOIN film f
      ON fa.film_id = f.film_id
    GROUP BY fa.actor_id, f.rating WITH ROLLUP
    ORDER BY 1,2;
    
-- Exercise: Compute the revenue of movies by its language and rating
-- 
-- 


/*************************************/
/* Subqueries */
/*************************************/

-- Query within query. Example:
SELECT customer_id, first_name, last_name
    FROM customer
    WHERE customer_id = 
      (SELECT MAX(customer_id) 
       FROM customer);

-- And here is the result of the subquery:
SELECT MAX(customer_id) FROM customer;

-- Exercise: do the same for the minimum customer id.
-- 
-- 


/******************************************/
/* Correlated x non-correlated subqueries */
/******************************************/

-- Noncorrelated subqueries: completely self-contained
SELECT city_id, city
  FROM city
  WHERE country_id <> 
    (SELECT country_id FROM country WHERE country = 'India');

-- Self-contained: nothing needed to execute it independently
SELECT country_id FROM country WHERE country = 'India';

-- Multirow subequery (fail):
SELECT city_id, city
  FROM city
  WHERE country_id <> 
    (SELECT country_id FROM country WHERE country <> 'India');

-- Multirow subequery (done right):
SELECT city_id, city
  FROM city
  WHERE country_id NOT IN 
    (SELECT country_id FROM country WHERE country <> 'India');

-- Multirow subquery:
SELECT city_id, city
  FROM city
  WHERE country_id IN
  (SELECT country_id
    FROM country
    WHERE country IN ('Canada','Mexico'));

-- Exercise: what are the cities not in Canada or Mexico?
-- 
-- 

-- ALL operator: makes comparison between value and all values in set
-- All customers that never got a free rental:
SELECT first_name, last_name
  FROM customer
  WHERE customer_id <> ALL
    (SELECT customer_id
	FROM payment
    WHERE amount = 0);

-- But if you don't like to use the ALL operator:
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN
 (SELECT customer_id
  FROM payment
  WHERE amount = 0);

-- Be careful with null's:
SELECT first_name, last_name
  FROM customer
  WHERE customer_id NOT IN (122, 452, NULL);
  
-- ALL clause again:
-- Exercise: Read this query out loud. What does it do?
SELECT customer_id, count(*)
    FROM rental
    GROUP BY customer_id
    HAVING count(*) > ALL
     (SELECT count(*)
      FROM rental r
        INNER JOIN customer c
        ON r.customer_id = c.customer_id
        INNER JOIN address a
        ON c.address_id = a.address_id
        INNER JOIN city ct
        ON a.city_id = ct.city_id
        INNER JOIN country co
        ON ct.country_id = co.country_id
      WHERE co.country IN ('United States','Mexico','Canada')
      GROUP BY r.customer_id
      );

-- And the subquery:
SELECT count(*)
      FROM rental r
        INNER JOIN customer c
        ON r.customer_id = c.customer_id
        INNER JOIN address a
        ON c.address_id = a.address_id
        INNER JOIN city ct
        ON a.city_id = ct.city_id
        INNER JOIN country co
        ON ct.country_id = co.country_id
      WHERE co.country IN ('United States','Mexico','Canada')
      GROUP BY r.customer_id;

-- Exercise: Construct a query against the film table 
-- that uses a filter condition with a noncorrelated 
-- subquery against the category table to find all 
-- action films (category.name = 'Action').
-- 
-- 


-- Correlated subquery
-- Definition: queries that do not stand by themselves.

-- Example: containing query retrieves 
-- those customers who have rented exactly 20 films:
SELECT c.first_name, c.last_name
  FROM customer c
  WHERE 20 =
    (SELECT count(*) FROM rental r
    WHERE r.customer_id = c.customer_id);

-- If you try the subquery, you get an error:
SELECT count(*) FROM rental r
    WHERE r.customer_id = c.customer_id;

-- Exercise: retrieve customers with more than 25 rentals.
-- 
-- 

-- Warning about correlated subqueries: **they are computationally expensive.**

-- EXISTS operator: useful when the amount is not crucial
-- For example, how many customers rented before a date?
SELECT c.first_name, c.last_name
  FROM customer c
  WHERE EXISTS
  (SELECT 1 FROM rental r
    WHERE r.customer_id = c.customer_id
      AND date(r.rental_date) < '2005-05-25');

-- Note the 1. It can be anything. Will not change...
SELECT c.first_name, c.last_name
  FROM customer c
  WHERE EXISTS
  (SELECT * FROM rental r
    WHERE r.customer_id = c.customer_id
      AND date(r.rental_date) < '2005-05-25');

-- Actually, speed changes.

-- Actor never appeared in R rated (NOT EXISTS clause):
SELECT a.first_name, a.last_name
  FROM actor a
  WHERE NOT EXISTS
  (SELECT 1
    FROM film_actor fa
      INNER JOIN film f ON f.film_id = fa.film_id
    WHERE fa.actor_id = a.actor_id
      AND f.rating = 'R');

-- Subqueries as data sources:
SELECT c.first_name, c.last_name, 
    pymnt.num_rentals, pymnt.tot_payments
  FROM customer c
    INNER JOIN
    (SELECT customer_id, 
      count(*) num_rentals, sum(amount) tot_payments
    FROM payment
    GROUP BY customer_id
    ) pymnt
    ON c.customer_id = pymnt.customer_id;

-- Exercise: is the subquery above a correlated or
-- noncorrelated subquery?
-- 
-- 

-- Data Fabrication:

-- Suppose we want to classify the customers in this way:
SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
  UNION ALL
  SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
  UNION ALL
  SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

-- Here is the query to classify:
SELECT pymnt_grps.name, count(*) num_customers
  FROM (SELECT customer_id,
    count(*) num_rentals, sum(amount) tot_payments
  FROM payment
  GROUP BY customer_id
  ) pymnt
  INNER JOIN
    (SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
    UNION ALL
    SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
    UNION ALL
    SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit
    ) pymnt_grps
  ON pymnt.tot_payments BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
  GROUP BY pymnt_grps.name;


-- Exercise: using the following classification:
SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles
-- Count the participation of actors in movies 
-- 
-- 

/*************************************************/
/* Data Generation, Manipulation, and Conversion */
/*************************************************/

-- A few special characters:
SELECT CHAR(128,129,130,131,132,133,134,135,136,137);

SELECT CHAR(138,139,140,141,142,143,144,145,146,147);

SELECT CHAR(148,149,150,151,152,153,154,155,156,157);

SELECT CHAR(158,159,160,161,162,163,164,165);

-- Concat function:
SELECT CONCAT('danke sch', CHAR(148), 'n');

SELECT concat(first_name, ' ', last_name,
    ' has been a customer since ', date(create_date)) cust_narrative
    FROM customer;
    
-- Numeric data:
SELECT (37 * 59) / (78 - (8 * 6));

SELECT MOD(10,4);

SELECT MOD(22.75, 5);

SELECT POW(2,8);

SELECT POW(2,10) kilobyte, POW(2,20) megabyte,
  POW(2,30) gigabyte, POW(2,40) terabyte;

SELECT CEIL(72.445), FLOOR(72.445);

SELECT CEIL(72.000000001), FLOOR(72.999999999);

SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001);

SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2),
  TRUNCATE(72.0909, 3);
  
-- Time and date:
SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);

SELECT LAST_DAY('2021-11-18');

SELECT DAYNAME('2021-11-18');

SELECT EXTRACT(YEAR FROM '2020-01-20 22:19:05');

SELECT DATEDIFF('2019-09-03', '2019-06-21');

-- Exercise: find the date difference from today to 
-- your birthday.
-- 
-- 

-- Hard Q:

-- 1. Create a query with sum of payment amounts by customer
--    add their first and last name in a single column
-- 
-- 

-- 2. Display the name and the payment amount of the
--    third highest spender. You should assume the table
--    will change, but your code should always display
--    the third highest spender.
-- 


/************/
/* Practice */
/************/

-- 1. What are the names of all the languages in 
-- the database (sorted alphabetically)?

-- 2. Return the full names (first and last) 
-- of actors with “SON” in their last name, 
-- ordered by their first name.

-- 3. Find all the addresses where the second 
-- address is not empty (i.e., contains some text), 
-- and return these second addresses sorted.

-- 4. Return the first and last names of actors who played 
-- in a film involving a “Crocodile” and a “Shark”, along 
-- with the release year of the movie, sorted by the actors’ 
-- last names.

-- 5. How many films involve a “Crocodile” and a “Shark”?

-- 6. Find all the film categories in which there are
-- between 55 and 65 films. Return the names of these categories 
-- and the number of films per category, sorted by the number 
-- of films.

-- 7. In how many film categories is the average difference 
-- between the film replacement cost and the rental rate 
-- larger than 17?

-- 8. Display the first and last names of all actors from the table actor.

-- 9. Display the first and last name of each actor in a 
-- single column in upper case letters. Name the column Actor Name.

-- 10. You need to find the ID number, first name, and last 
-- name of an actor, of whom you know only the first name, "Joe." 
-- What is one query would you use to obtain this information?

-- 11. Find all actors whose last name contain the letters GEN:

-- 12. Find all actors whose last names contain the letters LI. 
-- This time, order the rows by last name and first name, in that order:

-- 13. Using IN, display the country_id and country columns 
-- of the following countries: Afghanistan, Bangladesh, and China:

-- 14. List the last names of actors, as well as how many actors 
-- have that last name.

-- 15. List last names of actors and the number of actors 
-- who have that last name, but only for names that are 
-- shared by at least two actors

-- 16. Use JOIN to display the first and last names, 
-- as well as the address, of each staff member. 

-- 17. Use JOIN to display the total amount rung up by each staff 
-- member in August of 2005. Use tables staff and payment.
-- Use also: payment_date LIKE '2005-08%'

-- 18. List each film and the number of actors who are listed for \
-- that film. Use tables film_actor and film. Use inner join.

-- 19. How many copies of the film Hunchback Impossible exist 
-- in the inventory system?

-- 20. Use subqueries to display all actors who appear in the 
-- film Alone Trip.

-- 21. You want to run an email marketing campaign in Canada, 
-- for which you will need the names and email addresses of 
-- all Canadian customers. Use joins to retrieve this information.

-- 
/* See you next class */
-- 