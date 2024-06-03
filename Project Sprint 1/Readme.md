One-to-Many Relationships:
1.Customers and Orders

  Relationship: One customer can place multiple orders.
  Explanation: A single customer (Customers) can place multiple rental orders (Orders) at different times, but each order is associated with only one customer.
2.Game Consoles and Owns 

  Relationship: One game console can be owned by multiple entities (e.g., different customers over time).
  Explanation: A single game console (Game Consoles) can be owned by different customers (Owns) at different times, reflecting changes in ownership. However, at any given time, it can only be associated with one customer.
3.Owns and Orders 

  Relationship: One ownership record can have multiple associated orders.
  Explanation: An ownership record (Owns) can be linked to multiple orders (Orders) placed by the owner. Each order specifies a rental or purchase instance related to the ownership.
 
4.Orders and Transactions 

  Relationship: One order can result in multiple transactions.
  Explanation: A single order (Orders) might involve multiple transactions (Transactions), such as initial payment, follow-up payments, or returns.
5.Inventory and Contains 

  Relationship: One inventory record can contain multiple items.
  Explanation: An inventory record (Inventory) can encompass multiple game consoles or products (Contains) available in stock. Each item in the inventory is tracked individually.
6.Transfer and Transactions 

  Relationship: One transfer can be associated with multiple transactions.
  Explanation: A single transfer (Transfer) of ownership or product might involve multiple transaction records (Transactions) documenting the steps or stages of the transfer.
  
  
7.Inventory and Transfer

  Relationship: One inventory item can be involved in multiple transfers.
  Explanation: An individual item in the inventory (Inventory) can be transferred multiple times (Transfer), with each transfer being documented as a separate record.

One-to-One (1:1) Relationships:

1.Customers and Owns
  Relationship: Each customer has a unique ownership record.
  Explanation: A single customer (Customers) can have only one unique ownership record (Owns) at a given point in time, indicating the current game console owned by the customer.
