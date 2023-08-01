# Case Study #4:Data Bank

![image](https://8weeksqlchallenge.com/images/case-study-designs/4.png)

## Introduction

There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.
Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!.Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!.Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!.The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

## Entity Relationship Diagram

![image](https://github.com/aishwarya-venkatraja/SQL-Challenges/assets/140829886/aacb4f04-a22f-4904-84f2-8b89ab3889db)

## Datasets

- **Regions:**
  Just like popular cryptocurrency platforms - Data Bank is also run off a network of nodes where both money and data is stored across the globe. In a traditional banking sense - you can think of these nodes as bank branches or stores that exist around the world.
This regions table contains the region_id and their respective region_name values

- **Customer Nodes:**
  Customers are randomly distributed across the nodes according to their region - this also specifies exactly which node contains both their cash and data.This random distribution changes frequently to reduce the risk of hackers getting into Data Bank’s system and stealing customer’s money and data!

- **Customer Transactions:**
  This table stores all customer deposits, withdrawals and purchases made using their Data Bank debit card.

  
## Case study Focus Areas

- A. Customer Nodes Exploration
- B. Customer Transactions
- C. Data Allocation Challenge
- D. Extra Challenge
- E.Extension Request
