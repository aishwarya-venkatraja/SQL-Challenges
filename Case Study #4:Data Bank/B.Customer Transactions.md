# CUSTOMER TRANSACTIONS

**1. What is the unique count and total amount for each transaction type?**

```sql
Select txn_type as Transaction_Type,count(customer_id) as Customer_count,sum(txn_amount) AS Total_Amount
from customer_transactions
group by txn_type;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/aec2d450-fda8-450e-94dc-5f8cd661adb9)


**2. What is the average total historical deposit counts and amounts for all customers?**

```sql
with historical_deposit_cte as(
Select customer_id,SUM(txn_amount) as amount,COUNT(txn_type) as trans_count
from customer_transactions
where txn_type='deposit'
group by customer_id)
Select AVG(amount) as avg_amount,AVG(trans_count) as avg_trans_count from historical_deposit_cte;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/1549e488-4489-4dad-b5c2-a26c4ef27429)


**3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?**


```sql
with transaction_count_per_month_cte as
  (select customer_id,
          monthname(txn_date) as Transaction_month_name,
          SUM(if(txn_type="deposit", 1, 0)) as deposit_count,
          SUM(if(txn_type="withdrawal", 1, 0)) as withdrawal_count,
          SUM(if(txn_type="purchase", 1, 0)) as purchase_count
   from customer_transactions
   group by customer_id,
            monthname(txn_date))
select Transaction_month_name,
       count(distinct customer_id) as customer_count
from transaction_count_per_month_cte
where deposit_count>1
  and (purchase_count = 1
       or withdrawal_count = 1)
group by Transaction_month_name;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/b8307156-cdd5-49e3-a875-f7bca73c0453)


**4. What is the closing balance for each customer at the end of the month?**


```sql
with monthly_balance_cte as (
  select
    customer_id,
    txn_amount,txn_type,
    txn_date,
    SUM(case
          when txn_type = 'deposit' then txn_amount
          else -txn_amount
        end) over (partition by customer_id order by txn_date) as closing_balance
  from customer_transactions
)
select
  customer_id,
  EXTRACT(month from txn_date) as txn_month,txn_type,
  txn_amount,
  closing_balance
from monthly_balance_cte
order by customer_id, txn_date;
```

**Result:**

Result shown for 3 customers.

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/6a8344c3-c2cc-4b79-971f-83095ae0457b)


**5. What is the percentage of customers who increase their closing balance by more than 5%?**


```sql
WITH monthly_balance_cte AS (
  SELECT
    customer_id,
    txn_amount,
    txn_type,
    txn_date,
    SUM(
      CASE
        WHEN txn_type = 'deposit' THEN txn_amount
        ELSE -txn_amount
      END
    ) OVER (PARTITION BY customer_id ORDER BY txn_date) AS closing_balance
  FROM customer_transactions
)
, increased_customers AS (
  SELECT
    customer_id,
    (current_balance - previous_balance) / previous_balance AS balance_percentage
  FROM (
    SELECT
      customer_id,
      LAST_VALUE(closing_balance) OVER (PARTITION BY customer_id ORDER BY txn_date) AS current_balance,
      FIRST_VALUE(closing_balance) OVER (PARTITION BY customer_id ORDER BY txn_date) AS previous_balance
    FROM monthly_balance_cte
  ) AS customer_balance
)
SELECT
  ROUND(100 * COUNT(DISTINCT CASE WHEN balance_percentage > 5.00 THEN customer_id END) / COUNT(DISTINCT customer_id), 2) AS Customer_Percentage
FROM increased_customers;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/f7a7cee6-badc-4325-b1ca-6520c3b208ad)

