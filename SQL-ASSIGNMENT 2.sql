-- Retrieve the total number of rentals made in the Sakila database.
select count(distinct(rental_id)) from rental;
-- Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT 
    AVG(TIMESTAMPDIFF(SECOND, rental_date, last_update) / (60 * 60 * 24)) AS avg_rental_duration_days
FROM 
    rental;
-- or
select AVG(DATEDIFF(last_update, rental_date)) AS avg_rental_duration_days from rental;

-- Display the first name and last name of customers in uppercase.
select upper(first_name) as First_Name,upper(last_name) as Last_Name from customer;

-- Extract the month from the rental date and display it alongside the rental ID.
select rental_id, month(rental_date) from rental;

-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
select distinct(customer_id),count(customer_id) from rental group by customer_id;

-- Find the total revenue generated by each store.
select staff_id as store ,sum(amount) from payment group by staff_id;

-- Display the title of the movie, customer s first name, and last name who rented it.
select f.title, c.first_name,c.last_name from customer c join rental r on c.customer_id = r.customer_id
join inventory i on i.inventory_id = r.inventory_id join film f on f.film_id = i.film_id;

-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind." 
-- I do film name "Gone Trouble" because that name is not there
select a.first_name, a.last_name from actor a join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id where title = "GONE TROUBLE";

-- Determine the total number of rentals for each category of movies.
select c.name as category_name , count(fc.film_id) as rent_no from category c join film_category fc on c.category_id = fc.category_id
join inventory i on i.film_id = fc.film_id join rental r on r.inventory_id=i.inventory_id
 group by category_name;
 
 -- Find the average rental rate of movies in each language.
 select l.name as language_name , avg(f.rental_rate) from language l join film f on l.language_id=f.language_id
 group by language_name;

-- Retrieve the customer names along with the total amount they've spent on rentals.
select concat(c.first_name," ",c.last_name) as full_name , sum(p.amount) as rent_amount from customer c join payment p on
c.customer_id=p.customer_id join rental r on r.customer_id = p.customer_id 
group by full_name;

-- List the titles of movies rented by each customer in a particular city (e.g., 'London').
select f.title as film_name  from film f join inventory i on f.film_id = i.film_id join rental r on r.inventory_id=i.inventory_id
join customer c on r.customer_id=c.customer_id join address a on a.address_id= c.address_id
join city on city.city_id = a.city_id where city = "London" ;

-- Display the top 5 rented movies along with the number of times they've been rented.
select f.title as movie_name ,count(r.rental_id) as rent_no from film f join inventory i on i.film_id=f.film_id join rental r on 
r.inventory_id=i.inventory_id group by movie_name order by rent_no desc limit 5;

-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

