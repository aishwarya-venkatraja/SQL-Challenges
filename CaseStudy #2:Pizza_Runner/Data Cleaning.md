# DATA CLEANING

**CUSTOMER_ORDERS**

- Before using the "exclusions" and "extras" columns in the "customer_orders" table for queries, it is necessary to clean up the data, as these columns contain blank spaces and null values.

```sql
Update customer_orders 
set exclusions =(case when exclusions='' or exclusions like '%null%' then NULL 
                 else exclusions end),
                 extras=(case when extras='' or extras like '%null%' then NULL 
                 else extras end);
```
**CLEANED TABLE**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/25c53526-208a-48ce-b497-46b94d6db39b)

**RUNNER_ORDERS**

- Before utilizing the "pickup_time," "distance," "duration," and "cancellation" columns in the "runner_orders" table for queries, data cleaning has to be done for following reasons:

- The "pickup_time" column contains null values.
- The "distance" column contains null values and includes the unit "km," which needs to be removed.
- The "duration" column has null values and includes variations like "minutes," "mins," and "minute," which must be removed.
- The "cancellation" column contains blank spaces and null values.

```sql
UPDATE runner_orders
SET
    pickup_time = CASE WHEN pickup_time LIKE 'null' THEN NULL ELSE pickup_time END,
    distance = CASE WHEN distance LIKE 'null' THEN NULL ELSE CAST(regexp_replace(distance, '[a-z]+', '') AS FLOAT) END,
    duration = CASE WHEN duration LIKE 'null' THEN NULL ELSE CAST(regexp_replace(duration, '[a-z]+', '') AS FLOAT) END,
    cancellation = CASE WHEN cancellation LIKE '' OR cancellation LIKE 'null' THEN NULL ELSE cancellation END;
```

**CLEANED TABLE**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/e0a38dc9-9609-48a4-9b6d-76056091080b)

**TEMPORARY TABLE CREATION**

- A temporary table is created for pizza_id and its topping_ids.


