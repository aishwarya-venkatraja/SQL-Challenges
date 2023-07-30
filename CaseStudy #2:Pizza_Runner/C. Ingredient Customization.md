# INGREDIENT CUSTOMIZATION

**CASE STUDY QUESTIONS**

**1. What are the standard ingredients for each pizza?**
```sql
Select pn.pizza_id,pn.pizza_name,GROUP_CONCAT(topping_name) AS Toppings
from pizza_names pn
join temp_pizza_toppings ptt on pn.pizza_id=ptt.pizza_id
join pizza_toppings pt on ptt.topping_ids=pt.topping_id
group by pn.pizza_id,pn.pizza_name
order by pizza_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/9e961487-5f99-41a5-aa1f-fb9c7c31946e)

**2. What was the most commonly added extra?**
```sql
Select pt.topping_name as Most_Added, COUNT(*) as extra_count
from customer_orders co
join pizza_toppings pt on FIND_IN_SET(pt.topping_id, co.extras)
where co.extras is not null
group by pt.topping_name
order by extra_count desc
limit 1;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/4da77690-e31c-4444-9fb6-b6c87f400d3e)

**3. What was the most common exclusion?**
```sql
Select pt.topping_name as Most_excluded, COUNT(*) as exclusions_count
from customer_orders co
join pizza_toppings pt on FIND_IN_SET(pt.topping_id, co.exclusions)
where co.exclusions is not null
group by pt.topping_name
order by exclusions_count desc
limit 1;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/4ecb5b83-d14a-4124-8d62-71f45dfbe3be)

**4. Generate an order item for each record in the customers_orders table in the format of one of the following:**
   - Meat Lovers
   - Meat Lovers - Exclude Beef
   - Meat Lovers - Extra Bacon
   - Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
     
```sql
select co.order_id,
  CONCAT(
    pn.pizza_name,
    if(co.exclusions is not null, CONCAT(' - Exclude ', GROUP_CONCAT(pt_exclude.topping_name SEPARATOR ', ')), ''),
    if(co.extras is not null, CONCAT(' - Extra ', GROUP_CONCAT(pt_extra.topping_name SEPARATOR ', ')), '')
  ) as order_item
from
  customer_orders co
  join pizza_names pn on co.pizza_id = pn.pizza_id
  left join pizza_recipes pr on co.pizza_id = pr.pizza_id
  left join pizza_toppings pt_exclude on FIND_IN_SET(pt_exclude.topping_id, co.exclusions)
  left join pizza_toppings pt_extra on FIND_IN_SET(pt_extra.topping_id, co.extras)
group by
  co.order_id, pn.pizza_name, co.exclusions, co.extras
  order by co.order_id;
```
**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/b84d52b1-492f-466f-a456-770d9c6fecc0)

**5. Generate an alphabetically ordered comma-separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients.
   For example: "Meat Lovers: 2xBacon, Beef, ..., Salami"**
```sql

```
**Result:**

**6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?**
```sql

```
**Result:**


