

-- Sakila SQL Join + Join in Multiple Tables:

-- List number of films per category.
select count(f.film_id), c.name from sakila.film f
join sakila.film_category fc 
on f.film_id=fc.film_id
join sakila.category c 
on fc.category_id=c.category_id
group by c.name;

-- Display the first and last names, as well as the address, of each staff member.
select s.first_name, s.last_name, a.address
from sakila.staff as s
join sakila.address a 
on s.address_id=a.address_id;

-- Display the total amount rung up by each staff member in August of 2005.
select s.staff_id, s.first_name, s.last_name, sum(p.amount) as total_amount, substr(p.payment_date, 1,7) as August_2005
from sakila.staff as s
join sakila.payment as p
on s.staff_id = p.staff_id
where substr(p.payment_date, 1,7) = '2005-08'
group by s.staff_id, s.first_name, s.last_name, substr(p.payment_date, 1,7);

-- List each film and the number of actors who are listed for that film.
select f.title, count(a.actor_id) as actors_per_film
from sakila.actor as a
join sakila.film_actor as fa
on a.actor_id = fa.actor_id
join sakila.film as f
on f.film_id = fa.film_id
group by f.title
order by f.title;

-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
select c.last_name, c.first_name, sum(p.amount) as total_paid_by_customer
from sakila.customer as c
join sakila.payment as p
on c.customer_id = p.customer_id
group by c.last_name, c.first_name
order by c.last_name;

-- Write a query to display for each store its store ID, city, and country.
use sakila;
select s.store_id, c.city, co.country
from sakila.store as s
join sakila.address as a
on s.address_id = a.address_id
join sakila.city as c
on a.city_id = c.city_id
join sakila.country as co
on c.country_id = co.country_id
group by s.store_id, c.city, co.country;


-- Write a query to display how much business, in dollars, each store brought in.
select s.store_id, CONCAT('$', sum(p.amount)) as total_amount_dollars
from sakila.store as s
join sakila.staff as st
on s.store_id = st.store_id
join sakila.payment as p
on st.staff_id = p.staff_id
group by s.store_id;

-- What is the average running time of films by category?
use sakila;
select c.name, round(avg(f.length),2) as average_length_per_film_category
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.film as f
on f.film_id = fc.film_id
group by c.name;


-- Which film categories are longest?
use sakila;
select c.name, round(avg(f.length),2) as average_length_per_film_category
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.film as f
on f.film_id = fc.film_id
group by c.name
order by round(avg(f.length),2) desc;

-- Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as most_rented_movies, f.film_id
from sakila.film as f
join sakila.inventory as i
on f.film_id = i.film_id
join sakila.rental as r
on i.inventory_id = r.inventory_id
group by f.title, f.film_id
order by  count(i.inventory_id) desc;


-- List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount) as gross_revenue
from sakila.category as c
join sakila.film_category as fc
on c.category_id = fc.category_id
join sakila.inventory as i
on fc.film_id = i.film_id
join sakila.rental as r
on i.inventory_id = r.inventory_id
join sakila.payment as p
on p.rental_id = r.rental_id
group by c.name
order by sum(p.amount) desc
limit 5;
-- Is "Academy Dinosaur" available for rent from Store 1
select f.title, i.inventory_id, i.store_id, r.return_date, i.last_update
from sakila.film as f
join sakila.inventory as i
on f.film_id = i.film_id
join sakila.rental as r
on i.inventory_id = r.inventory_id
where f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;