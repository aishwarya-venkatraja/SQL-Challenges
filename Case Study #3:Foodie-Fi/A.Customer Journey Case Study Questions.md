# A. Customer Journey

Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.

Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!

Selecting random customer_ids to view their Foodie-fi journey.

```sql
select s.customer_id,s.plan_id,p.plan_name,s.start_date,p.price
from plans p
join subscriptions s on p.plan_id=s.plan_id
where customer_id in ( 1,9,23,45,52,67,86,100)
order by s.customer_id,p.plan_id;
```

**Result:**

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/8fdb5d25-940f-4905-8ffa-22a9fdf82a14)

**Insights from Customer journey:**

1. Customers 1, 9, 23, 45, and 100 all started with a trial but made changes to their subscription plans, either upgrading to higher tiers or switching between monthly and annual plans. This shows that customers initially test the service before committing to a specific plan.
2. Customers 9, 23, and 86 upgraded to annual plans. This could indicate that some customers prefer the cost savings and convenience associated with annual billing.
3. Customer 67 opted to upgrade to a pro monthly plan after starting with a trial. This may indicate an interest in the premium features of the pro plan without committing to an annual subscription.
4. Customer 100 followed a more complex path, transitioning through trial, basic monthly, and pro monthly plans.Seems like he tried out eveerything before upgrading.
5. Customer 52 started with a trial but eventually churned. 


