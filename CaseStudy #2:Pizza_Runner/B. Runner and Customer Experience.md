# RUNNER AND CUSTOMER EXPERIENCE

**CASE STUDY QUESTIONS**

**1. How many runners signed up for each 1-week period? (i.e., week starts 2021-01-01)**
```sql
SELECT week(registration_date) as 'Week of registration',
       count(runner_id) as 'Number of runners'
FROM runners
GROUP BY 1;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/00f5d950-a02e-4a6d-a32d-ba73dd7f78ef)

**2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pick up the order?**
```sql
SELECT r.runner_id, round(AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)),2) AS average_time_minutes
FROM customer_orders c
JOIN runner_orders r ON c.order_id = r.order_id
GROUP BY r.runner_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/a2e362fa-16c8-4e41-aba6-4eb99557e455)

**3. Is there any relationship between the number of pizzas and how long the order takes to prepare?**
```sql
Select pizza_count,round(avg(prep_time),2) As Avg_Prep_Time
from
(Select c.order_id,count(c.pizza_id) as pizza_count,timestampdiff(minute,c.order_time,r.pickup_time)as Prep_time
from customer_orders c
join runner_orders r on c.order_id=r.order_id
where r.cancellation is Null
group by c.order_id,c.order_time,r.pickup_time) as Prep_Time
group by pizza_count
order by pizza_count;
```
**Result:**

From the results,it is evident that no of pizzas has influence on the preparation time.

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/7c55a33e-29c9-47cc-a93c-416bb4bb2cc0)

**4. What was the average distance traveled for each customer?**
```sql
select c.customer_id,round(avg(r.distance_km),1) As Avg_Distance_Travelled
from customer_orders c
join runner_orders r on c.order_id=r.order_id
group by customer_id
order by customer_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/8bd831ac-40de-4368-b86d-88dbbb5a642c)

**5. What was the difference between the longest and shortest delivery times for all orders?**
```sql
Select abs(min-max) as Time_difference_min
from 
(Select min(duration_min) as min,max(duration_min) as max
from runner_orders r
where cancellation is NULL) as Duration;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/2885f08a-7c1c-4eac-be7c-8eca393dc241)

**6. What was the average speed for each runner for each delivery, and do you notice any trend for these values?**
```sql
select runner_id,order_id,round(avg(distance_km/(cast(duration_min as decimal(10,2))/60)),1) as avg_speed_kmph
from runner_orders
where cancellation is NULL
group by runner_id,order_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/dbaf74ae-b388-4455-8f11-97dd94973d6e)

**7. What is the successful delivery percentage for each runner?**
```sql
select runner_id,round(sum(case when cancellation is NULL then 1 else 0 end)/count(*)*100,2) as Sucessful_Delivery_percentage
from runner_orders
group by runner_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/e48f8a4b-941b-4945-904f-30802bab4a60)


