# DATA CLEANING

**CUSTOMER_ORDERS:**

- Before using the "exclusions" and "extras" columns in the "customer_orders" table for queries, it is necessary to clean up the data, as these columns contain blank spaces and null values.

```sql
Update customer_orders 
set exclusions =(case when exclusions='' or exclusions like '%null%' then NULL 
                 else exclusions end),
                 extras=(case when extras='' or extras like '%null%' then NULL 
                 else extras end);
```
**Cleaned table:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/25c53526-208a-48ce-b497-46b94d6db39b)

----------------------------------------------------------------------------------------------------

**RUNNER_ORDERS:**

Before utilizing the "pickup_time," "distance," "duration," and "cancellation" columns in the "runner_orders" table for queries, data cleaning has to be done for following reasons:
  

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

**Cleaned Table:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/e0a38dc9-9609-48a4-9b6d-76056091080b)

----------------------------------------------------------------------------------

**TEMPORARY TABLE CREATION:**

A temporary table is created for pizza_id and its topping_ids.

```sql
CREATE TABLE temp_pizza_toppings AS
SELECT
  pizza_id,
  SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', numbers.n), ',', -1) AS topping_ids
FROM
  pizza_recipes
  INNER JOIN
  (
    SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
    SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL
    SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
  ) numbers
  ON CHAR_LENGTH(toppings) - CHAR_LENGTH(REPLACE(toppings, ',', '')) >= numbers.n - 1;
```


 **Temporary Table:**

 ![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/16c4c8b4-6be5-42bc-ab62-4de2b23ba7b4)



