--------------------------
Case-study-Danny's Dinner Solutions
--------------------------

Tool used:
MySQL
Concepts used:
Group by,Aggregate functions,CTE's,Window Functions,Subqueries

--------------------------
  
Case Study Questions:

1.What is the total amount each customer spent at the restaurant?

Select s.customer_id,sum(m.price) as Total_Amount_Spent
from sales s
join menu m on s.product_id=m.product_id
group by customer_id;

2.How many days has each customer visited the restaurant?

select customer_id,count(distinct order_date) as No_of_days_visited
from sales s
group by customer_id;

3.What was the first item from the menu purchased by each customer?

select customer_id,product_name as first_product
from
(select s.customer_id,s.product_id,m.product_name,
dense_rank() over(partition by customer_id order by order_date) as ranks -- dense rank() is used to fetch all items from first order
from sales s
join menu m on s.product_id=m.product_id) as x
where ranks=1
group by customer_id,product_name;

4.What is the most purchased item on the menu and how many times was it purchased by all customers?

select product_name as most_purchased_item,COUNT(*) as Total_Purchases
from sales as s
join menu as m on s.product_id = m.product_id
group by product_name
order by Total_Purchases desc
limit 1;

5.Which item was the most popular for each customer?

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


6.Which item was purchased first by the customer after they became a member?


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

7.Which item was purchased just before the customer became a member?

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


8.What is the total items and amount spent for each member before they became a member?

select s.customer_id,count( distinct s.product_id) as total_count,sum(m.price) as total_sales
from sales s 
join menu m on s.product_id=m.product_id
join members mem on mem.customer_id=s.customer_id
where order_date<join_date
group by customer_id
order by customer_id;

9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

  

10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
