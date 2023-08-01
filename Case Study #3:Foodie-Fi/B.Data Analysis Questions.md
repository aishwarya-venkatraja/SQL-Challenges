# CASE STUDY QUESTIONS

## B.DATA ANALYSIS QUESTIONS

**1. How many customers has Foodie-Fi ever had?**

```sql
Select count(distinct customer_id) as Total_Customers
from subscriptions;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/0c770197-121f-4e88-9b18-20a16bedf9c5)


**2. What is the monthly distribution of trial plan `start_date` values for our dataset? Use the start of the month as the group by value.**

```sql
select month(s.start_date) as Month,monthname(s.start_date) as Month_name,
       count(distinct s.customer_id) as 'monthly distribution'
from subscriptions s
join plans p on s.plan_id=p.plan_id
where s.plan_id=0
group by month(s.start_date),monthname(s.start_date);
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/b7051472-ab6a-417d-a4d1-93e8c07934de)


**3. What plan `start_date` values occur after the year 2020 for our dataset? Show the breakdown by count of events for each `plan_name`.**

```sql
select s.plan_id,
       p.plan_name,
       count(*) AS 'count of events'
from subscriptions s
join plans p on s.plan_id=p.plan_id
where year(s.start_date) > 2020
group by s.plan_id,p.plan_name
order by s.plan_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/03407274-c5ba-47de-b459-761962838b2f)


**4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?**

```sql
WITH counts_cte AS
  (SELECT
          count(DISTINCT s.customer_id) AS distinct_customer_count,
          SUM(CASE
                  WHEN s.plan_id=4 THEN 1
                  ELSE 0
              END) AS churned_customer_count
   FROM subscriptions s
   JOIN plans p on s.plan_id=p.plan_id)
SELECT *,
       round(100*(churned_customer_count/distinct_customer_count), 1) AS churn_percentage
FROM counts_cte;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/075d8d0d-1e00-4318-b459-0989c5be0094)


**5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?**

```sql
WITH next_plan_cte AS
  (SELECT *,
          lead(plan_id, 1) over(PARTITION BY customer_id
                                ORDER BY start_date) AS next_plan
   FROM subscriptions),
     churners AS
  (SELECT *
   FROM next_plan_cte
   WHERE next_plan=4
     AND plan_id=0)
SELECT count(customer_id) AS 'churn after trial count',
       round(100 *count(customer_id)/
               (SELECT count(DISTINCT customer_id) AS 'distinct customers'
                FROM subscriptions), 2) AS 'churn percentage'
FROM churners;

```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/b14c6ff2-c927-45ff-b99b-442f4cfa5bd5)


**6. What is the number and percentage of customer plans after their initial free trial?**

```sql
select p.plan_name,count(customer_id) as Customer_Count,
round(100*count(customer_id)/(select count(distinct customer_id)from subscriptions),2)as Customer_percentage
from subscriptions s
join plans p on s.plan_id=p.plan_id
where p.plan_id!=0
group by p.plan_id,p.plan_name
order by p.plan_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/39ee945d-a493-43df-8d3c-9a98e23bbc31)


**7. What is the customer count and percentage breakdown of all 5 `plan_name` values at 2020-12-31?**

```sql
with plan_names as 
(
select *,row_number() over(partition by customer_id order by start_date desc) as rn
from subscriptions 
where start_date<='2020-12-31')
select plan_name,count(customer_id) as customer_count,round(100*count(customer_id)/(select count(distinct customer_id) from subscriptions),2) as Percentage
from plan_names
join plans p on plan_names.plan_id=p.plan_id
where rn=1
group by plan_name;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/dcd9e941-3b41-49fb-955d-a65cc0cb1069)


**8. How many customers have upgraded to an annual plan in 2020?**


```sql
select plan_id,count(distinct customer_id) Annual_Plan_Count
from subscriptions
where plan_id=3 and year(start_date)=2020;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/7b16c5c1-99c8-4624-b458-5469cc5190b9)


**9. How many days on average does it take for a customer to upgrade to an annual plan from the day they join Foodie-Fi?**

```sql
Create temporary table trial 
(
select customer_id,start_date
from subscriptions 
where plan_id=0);
create temporary table annual 
(select customer_id,start_date
from subscriptions 
where plan_id=3);
select avg(datediff(annual.start_date,trial.start_date)) as Avg_Days
from trial
join annual on trial.customer_id=annual.customer_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/db23a7d0-f234-4fe8-a4e8-d316e75e01c2)


**10. Can you further break down this average value into 30-day periods (i.e., 0-30 days, 31-60 days, etc.)?**

```sql
SELECT 
  CASE
    WHEN DATEDIFF(annual.start_date, trial.start_date) BETWEEN 0 AND 30 THEN '0-30 days'
    WHEN DATEDIFF(annual.start_date, trial.start_date) BETWEEN 31 AND 60 THEN '31-60 days'
    WHEN DATEDIFF(annual.start_date, trial.start_date) BETWEEN 61 AND 90 THEN '61-90 days'
    ELSE 'More than 90 days'
  END AS Period,
count(trial.customer_id) as Customer_count
FROM trial
JOIN annual ON trial.customer_id = annual.customer_id
GROUP BY Period
ORDER BY period;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/e99ef467-5058-4e0f-b132-4b9d094e5503)


**11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?**

```sql
select count(customer_id) as downgrade_count
from (select customer_id,plan_id as current_plan, lag(plan_id,1) over (partition by customer_id order by start_date asc) as last_plan
from subscriptions
where year(start_date)=2020
order by customer_id)as downgrade
where current_plan=1 and last_plan=2;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/df28bbbf-e73e-4a13-8762-3bedb80ef1e8)





