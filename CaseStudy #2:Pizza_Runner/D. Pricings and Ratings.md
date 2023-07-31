# PRICINGS AND RATINGS 

**CASE STUDY QUESTIONS**

**1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10, and there were no charges for changes, how much money has Pizza Runner made so far if there are no delivery fees?**
```sql
CREATE TEMPORARY TABLE charges
SELECT
  co.pizza_id,
  pn.pizza_name,
  CASE
    WHEN pn.pizza_name = 'Meatlovers' THEN 12
    WHEN pn.pizza_name = 'Vegetarian' THEN 10
    ELSE NULL
  END AS Base_Charges
FROM
  customer_orders co
  JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
  join runner_orders ro on co.order_id=ro.order_id
  where cancellation is null;
select * from charges;
Select concat('$',sum(base_charges)) as Total_revenue
from charges;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/648abee3-ec0d-4ad8-8beb-ea8f9b884acb)

**2. What if there was an additional $1 charge for any pizza extras?**
   - Add cheese is $1 extra.

```sql
select concat('$', topping_revenue + pizza_revenue) AS total_revenue
from
  (select sum(case
                  when pizza_id = 1 then 12
                  else 10
              end) as pizza_revenue,
          sum(topping_count) as topping_revenue
   from
     (select co.order_id,co.pizza_id,
             length(co.extras) - length(replace(co.extras, ",", "")) + 1 as topping_count
      from customer_orders co
      inner join  runner_orders ro on co.order_id = ro.order_id
      where cancellation is null
      order by co.order_id,co.pizza_id) as x) as y;

```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/d5126975-9049-4cf3-becf-4f92598db14b)

**3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner. How would you design an additional table for this new dataset? Generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.**
```sql
create table runner_rating (order_id INTEGER, rating INTEGER, review VARCHAR(100)) ;
INSERT INTO runner_rating
VALUES (1, 1, 'Really bad service'),
       (2, 1, NULL),
       (3, 4, "Took too long..."),
       (4, 1,"Runner was lost, delivered it AFTER an hour. Pizza arrived cold"),
       (5, 2, "Good service"),
       (7, 5, "It was great, good service and fast"),
       (8, 2, "He tossed it on the doorstep, poor service"),
       (10, 5, "Delicious!, he delivered it sooner than expected too!");
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/7f3ca573-8181-45b7-bf16-da6314958ae3)


**4. Using your newly generated table, can you join all of the information together to form a table which has the following information for successful deliveries?**
   - customer_id
   - order_id
   - runner_id
   - rating
   - order_time
   - pickup_time
   - Time between order and pickup
   - Delivery duration
   - Average speed
   - Total number of pizzas
     
```sql
SELECT co.customer_id,
       co.order_id,
       ro.runner_id,
       rr.rating,rr.review,
       co.order_time,
       ro.pickup_time,
       TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time) pick_up_time,
       ro.duration_min AS delivery_duration,
       round(ro.distance_km*60/ro.duration_min, 2) AS average_speed,
       count(co.pizza_id) AS total_pizza_count
FROM customer_orders co
INNER JOIN runner_orders ro on co.order_id=ro.order_id 
INNER JOIN runner_rating rr on ro.order_id=rr.order_id
GROUP BY ro.order_id,co.customer_id,ro.runner_id,rr.rating,rr.review,
       co.order_time,
       ro.pickup_time,ro.duration_min,ro.distance_km,co.pizza_id ;       
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/bad8ee2b-1b92-4cab-ae3a-48d4f6c73c13)


**5. If a Meat Lovers pizza was $12 and Vegetarian $10 (fixed prices with no cost for extras), and each runner is paid $0.30 per kilometer traveled, how much money does Pizza Runner have left over after these deliveries?**

```sql
select concat('$',round(sum(total_pizza_cost-total_delivery_cost), 2)) as total_revenue
from
(select sum(pizza_cost) As total_Pizza_Cost,sum(delivery_cost)as Total_delivery_cost
from
(select co.order_id,sum(case when co.pizza_id=1 then 12
when co.pizza_id=2 then 10
end ) as pizza_cost,round(0.30*ro.distance_km, 2) AS delivery_cost
from customer_orders co
join runner_orders ro on co.order_id=ro.order_id
where ro.cancellation is null
group by co.order_id,co.pizza_id,ro.distance_km) as x) as y;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/697cd5e4-3c17-4af2-a5b9-216934341ba3)

