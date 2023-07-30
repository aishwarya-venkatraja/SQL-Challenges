# PIZZA METRICS

**CASE STUDY QUESTIONS**

**1. How many pizzas were ordered?**

```sql
Select count(order_id) as Total_Pizzas_ordered
from customer_orders;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/0e99eb4b-4a7a-41e9-9e70-9c18b9dd11af)

**2. How many unique customer orders were made?**

```sql
Select count(distinct order_id) As Total_Number_Of_Unique_Customers
from customer_orders;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/ecd12c56-4e65-4f56-99dc-03a59e55b102)

**3. How many successful orders were delivered by each runner?**
```sql
Select runner_id,count(order_id) as successful_deliveries
from runner_orders
where cancellation is null
group by runner_id
order by runner_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/66bae3d8-0ee1-41a8-ba8f-f5b20aa2c53c)

**4. How many of each type of pizza was delivered?**

```sql
select pizza_id,count(pizza_id) as Count
from customer_orders
where order_id in (select order_id from runner_orders where cancellation is null)
group by pizza_id
order by pizza_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/90292b57-8f49-4f98-b6f0-e96c8d7eae29)

**5. How many Vegetarian and Meatlovers were ordered by each customer?**
```sql
select customer_orders.customer_id,pizza_names.Pizza_name,count(customer_orders.pizza_id) as Order_Count
from customer_orders 
join pizza_names on customer_orders.pizza_id=pizza_names.pizza_id
group by customer_id,Pizza_name
order by customer_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/31f20a31-b6ee-4953-95c5-e2450210e0d5)

**6. What was the maximum number of pizzas delivered in a single order?**
```sql
select max(count) as Maximum_pizzas_in_a_single_order
from 
(select order_id,count(pizza_id) as count
from customer_orders
group by order_id) as Count;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/5dbe6897-bea2-4dcd-8db3-1611d004dca0)

**7. For each customer, how many delivered pizzas had at least 1 change, and how many had no changes?**
```sql
with cte as
(
select c.customer_id,c.pizza_id,c.exclusions,c.extras
from customer_orders c
join runner_orders o on c.order_id=o.order_id
where cancellation is null )
select customer_id,sum(case when exclusions is null and extras is null then 1 else 0 end) as Pizza_Count_no_Changes,
sum(case when exclusions is not null or extras is not null then 1 else 0 end) as pizza_Count_with_changes
from cte
group by customer_id
order by customer_id;

```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/aa7b4123-0797-4a89-a697-c0dfc73ff1c3)

**8. How many pizzas were delivered that had both exclusions and extras?**
```sql
Select count(pizza_id) As Count
from customer_orders
join runner_orders on customer_orders.order_id=runner_orders.order_id
where cancellation is null and exclusions is not null and extras is not null;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/5abaaf19-424d-4ff9-b48f-e05ef55e4cbf)

**9. What was the total volume of pizzas ordered for each hour of the day?**
```sql
SELECT HOUR(order_time) AS hour_of_day, COUNT(*) AS total_volume
FROM customer_orders
GROUP BY hour_of_day
order by hour_of_day;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/ee1abb61-1aa0-4f34-9ed3-35853369d187)

**10. What was the volume of orders for each day of the week?**

```sql
SELECT DAYNAME(order_time) AS day_of_week, COUNT(*) AS order_volume
FROM customer_orders
GROUP BY day_of_week
order by day_of_week;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/3ef8a81f-2038-4bf5-a9a9-88abe85b8d37)








