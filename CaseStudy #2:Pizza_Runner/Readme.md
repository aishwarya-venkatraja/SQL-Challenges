# Case Study #2:Pizza Runner

![image](https://8weeksqlchallenge.com/images/case-study-designs/2.png)

## Introduction

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”
Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!
Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

# Entity Relationship Diagram

# Datasets

- **Table Name: runners**
  - Description: The table shows the registration_date for each new runner.

- **Table Name: customer_orders**
  - Description: Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order.
  - Columns:
    - Order_id,Customer_id
    - pizza_id: Relates to the type of pizza which was ordered.
    - exclusions: Ingredient_id values to be removed from the pizza.
    - extras: Ingredient_id values to be added to the pizza.

- **Table Name: runner_orders**
  - Description: After each order is received through the system, they are assigned to a runner. However, not all orders are fully completed and can be cancelled by the restaurant or the customer.
  - Columns:
    -Order_id,Runner_id
    - pickup_time: The timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas.
    - distance: Related to how far the runner had to travel to deliver the order to the respective customer.
    - duration: Indicates how long the runner took to deliver the order.
    - Cancellation: Yes Or No

- **Table Name: pizza_names**
  - Description: Pizza Runner only has 2 pizzas available: Meat Lovers or Vegetarian!

- **Table Name: pizza_recipes**
  - Description: Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.

- **Table Name:Pizza_toppings**
 - Description: Topping_id and its Topping_names.

- **Table Name: pizza_toppings**
  - Description: The table contains all of the topping_name values with their corresponding topping_id value.




