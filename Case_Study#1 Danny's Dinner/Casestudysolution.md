
# Case-study-Danny's Dinner Solutions


**Tool used:**
MySQL
**Concepts used:**
Group by,Aggregate functions,CTE's,Window Functions,Subqueries

--------------------------
  
## Case Study Questions:

**1.What is the total amount each customer spent at the restaurant?**
```sql
Select s.customer_id,sum(m.price) as Total_Amount_Spent
from sales s
join menu m on s.product_id=m.product_id
group by customer_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/38a447ae-f33f-4a22-8c2c-e3ee231aae45)


**2.How many days has each customer visited the restaurant?**

```sql
select customer_id,count(distinct order_date) as No_of_days_visited
from sales s
group by customer_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/a279a9ae-1029-4784-af61-3cf72d4081ad)


**3.What was the first item from the menu purchased by each customer?**

```sql
select customer_id,product_name as first_product
from
(select s.customer_id,s.product_id,m.product_name,
dense_rank() over(partition by customer_id order by order_date) as ranks -- dense rank() is used to fetch all items from first order
from sales s
join menu m on s.product_id=m.product_id) as x
where ranks=1
group by customer_id,product_name;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/24b7aa94-320f-449e-804a-cbb6b56a059d)


**4.What is the most purchased item on the menu and how many times was it purchased by all customers?**

```sql
select product_name as most_purchased_item,COUNT(*) as Total_Purchases
from sales as s
join menu as m on s.product_id = m.product_id
group by product_name
order by Total_Purchases desc
limit 1;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/8fc4e93d-5543-40a6-a3c4-e482f441f548)


**5.Which item was the most popular for each customer?**

```sql
with customer_popularity AS (
  select s.customer_id,m.product_name,COUNT(*) AS item_count,
    row_number() over (partition by s.customer_id order by  COUNT(*) desc) as ranks
  from sales as s
  join menu as m on s.product_id = m.product_id
  group by s.customer_id,m.product_name
)
SELECT customer_id,product_name AS Most_Popular_Item
FROM customer_popularity
WHERE ranks = 1;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/1cef2319-3b4d-4005-883d-d464de1837ee)


**6.Which item was purchased first by the customer after they became a member?**

```sql
with first_purchase_after_member_cte as 
(select s.customer_id,m.product_name,
dense_rank() over(partition by s.customer_id order by s.order_date asc) As ranks
from sales s
join menu m on s.product_id=m.product_id
join members on members.customer_id=s.customer_id
where order_date>join_date)
select distinct customer_id,product_name
from first_purchase_after_member_cte
where ranks=1
group by customer_id,product_name;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/caa9bff0-8cb1-440c-92c6-4e028b7afeea)


**7.Which item was purchased just before the customer became a member?**

```sql
with purchase_before_member_cte as 
(select s.customer_id,m.product_name,
dense_rank() over(partition by s.customer_id order by s.order_date desc) As ranks
from sales s
join menu m on s.product_id=m.product_id
join members on members.customer_id=s.customer_id
where order_date<join_date)
select distinct customer_id,product_name
from purchase_before_member_cte
where ranks=1
group by customer_id,product_name;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/acd232d8-05a8-43ef-96df-caca9fe0bb5b)

**8.What is the total items and amount spent for each member before they became a member?**

```sql
select s.customer_id,count( distinct s.product_id) as total_count,sum(m.price) as total_sales
from sales s 
join menu m on s.product_id=m.product_id
join members mem on mem.customer_id=s.customer_id
where order_date<join_date
group by customer_id
order by customer_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/7c77a323-639e-402c-9ea2-cd6a77932ef3)


**9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?**

  

**10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?**
