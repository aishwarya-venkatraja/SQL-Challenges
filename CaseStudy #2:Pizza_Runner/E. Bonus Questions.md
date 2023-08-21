# BONUS QUESTIONS 

**CASE STUDY QUESTIONS**

If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?

Adding a New pizza Supreme with all the toppings 

```sql
INSERT INTO pizza_names VALUES(3, 'Supreme');
SELECT * FROM pizza_names;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/69dce0a4-4ca7-44b0-ac96-a2cd218061a4)

Adding Toppings for supreme pizza to pizza_recipies table

```sql
INSERT INTO pizza_recipes
VALUES(3, (SELECT GROUP_CONCAT(topping_id SEPARATOR ', ') FROM pizza_toppings));

select * from pizza_recipes;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/f05b71ea-845c-4f4c-a1dc-e0c1b9fd1a25)

```sql
SELECT *
FROM pizza_names
INNER JOIN pizza_recipes USING(pizza_id);
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/85d30256-64f1-4c51-a358-a5ea2d65a80d)


