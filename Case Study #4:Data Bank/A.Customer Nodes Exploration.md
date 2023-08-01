# A.CUSTOMER NODES EXPLORATION

1. How many unique nodes are there on the Data Bank system?

```sql
Select count(distinct(node_id)) as Unique_Nodes
from customer_nodes;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/4dfe208e-5ea3-4b72-84c5-6eaf8c261803)


**2. What is the number of nodes per region?**

```sql
select region_id,count(distinct(node_id)) as No_Of_Nodes
from customer_nodes
group by region_id
order by region_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/9a7dacec-76e6-484c-8812-eee52f86a3be)


**3. How many customers are allocated to each region?**

```sql
select region_id,count(distinct(customer_id)) as No_of_Customers
from customer_nodes
group by region_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/c72c6adb-8993-4f01-ab19-7c54551a0527)


**4. How many days on average are customers reallocated to a different node?**

```sql


```

**Result:**




**5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?**



