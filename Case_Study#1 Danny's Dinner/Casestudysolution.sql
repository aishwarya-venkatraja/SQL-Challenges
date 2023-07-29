--------------------------
Case-study-Danny's Dinner Solutions
--------------------------

Tool used:
MySQL
Concepts used:
Group by,CTE's,Window Functions,Subqueries

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
dense_rank() over(partition by customer_id order by order_date) as ranks
from sales s
join menu m on s.product_id=m.product_id) as x
where ranks=1
group by customer_id,product_name;

4.What is the most purchased item on the menu and how many times was it purchased by all customers?

5.Which item was the most popular for each customer?

select distinct customer_id,max(item_count) over (partition by customer_id) AS Favorite_item
from (select s.customer_id,m.product_name as Item_name,count(s.product_id) as Item_Count
from sales s
join menu m on s.product_id=m.product_id
group by customer_id,product_name) as count
group by customer_id;

select s.customer_id,product_id,count(s.product_id) as Item_Count
from sales s
join menu m on s.product_id=m.product_id
group by customer_id,product_id,item_name;

6.Which item was purchased first by the customer after they became a member?


with cte as 
(select s.customer_id,m.product_name,
dense_rank() over(partition by s.customer_id order by s.order_date asc) As ranks
from sales s
join menu m on s.product_id=m.product_id
join members on members.customer_id=s.customer_id
where order_date>join_date)
select distinct customer_id,product_name
from cte
where ranks=1
group by customer_id,product_name;

7.Which item was purchased just before the customer became a member?

with cte as 
(select s.customer_id,m.product_name,
dense_rank() over(partition by s.customer_id order by s.order_date desc) As ranks
from sales s
join menu m on s.product_id=m.product_id
join members on members.customer_id=s.customer_id
where order_date<join_date)
select distinct customer_id,product_name
from cte
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
