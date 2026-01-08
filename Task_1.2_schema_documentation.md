# Fleximart Database – Schema Documentation

## 1. Entity–Relationship Description (Text Format)

### ENTITY: customers
**Purpose:** Stores customer information for users registered on the Fleximart platform.

**Attributes:**
- **customer_id**: Unique identifier for each customer (Primary Key, auto-generated)
- **first_name**: Customer’s first name
- **last_name**: Customer’s last name
- **email**: Customer’s email address (Unique, Not Null)
- **phone**: Customer’s contact phone number
- **city**: City of residence
- **registration_date**: Date when the customer registered

**Relationships:**
- One customer can place **many orders** (1:M relationship with `orders` table)

---

### ENTITY: products
**Purpose:** Stores information about products available for purchase.

**Attributes:**
- **product_id**: Unique identifier for each product (Primary Key, auto-generated)
- **product_name**: Name of the product
- **category**: Product category
- **price**: Unit price of the product
- **stock_quantity**: Available inventory quantity

**Relationships:**
- One product can be included in **many order items** (1:M relationship with `order_items` table)

---

### ENTITY: orders
**Purpose:** Represents a customer purchase transaction at the order level.

**Attributes:**
- **order_id**: Unique identifier for each order (Primary Key, auto-generated)
- **customer_id**: Identifier of the customer placing the order (Foreign Key → customers.customer_id)
- **order_date**: Date when the order was placed
- **total_amount**: Total value of the order
- **status**: Order status (e.g., Pending, Completed)

**Relationships:**
- Each order is placed by **one customer** (M:1 with customers)
- Each order contains **many order items** (1:M with order_items)

---

### ENTITY: order_items
**Purpose:** Stores detailed line items for each order.

**Attributes:**
- **order_item_id**: Unique identifier for each order item (Primary Key, auto-generated)
- **order_id**: Identifier of the related order (Foreign Key → orders.order_id)
- **product_id**: Identifier of the purchased product (Foreign Key → products.product_id)
- **quantity**: Quantity ordered
- **unit_price**: Price per unit at time of purchase
- **subtotal**: Line total (quantity × unit_price)

**Relationships:**
- Many order items belong to **one order** (M:1 with orders)
- Many order items reference **one product** (M:1 with products)

---

## 2. Normalization Explanation (Third Normal Form)

The Fleximart database schema is designed according to **Third Normal Form (3NF)** principles to ensure data integrity, eliminate redundancy, and prevent anomalies during data operations.

Each table has a clearly defined primary key, and all non-key attributes are fully functionally dependent on that primary key. In the **customers** table, the primary key `customer_id` uniquely determines customer attributes such as name, email, phone, city, and registration date. Similarly, in the **products** table, `product_id` determines product name, category, price, and stock quantity. In the **orders** table, `order_id` determines customer reference, order date, total amount, and status. In the **order_items** table, `order_item_id` determines the associated order, product, quantity, unit price, and subtotal.

There are no transitive dependencies in the design. For example, customer details are stored only in the customers table and are not repeated in orders, and product details are stored only in the products table and not repeated in order items. This separation ensures that updating customer or product information requires changes in only one place, thereby avoiding **update anomalies**. **Insert anomalies** are avoided because new customers or products can be added independently without requiring order data. **Delete anomalies** are prevented because deleting an order does not remove customer or product information. Overall, the schema satisfies 3NF and supports consistent, scalable transactional processing.

---

## 3. Sample Data Representation (SQL Server Code)

The following SQL Server Management Studio (SSMS) queries can be used to view 2–3 sample records from each table. These queries are intended for data validation and demonstration purposes.

### customers – sample records
```sql
SELECT TOP 3
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    city,
    registration_date
FROM dbo.customers
ORDER BY customer_id;
```

---

### products – sample records
```sql
SELECT TOP 3
    product_id,
    product_name,
    category,
    price,
    stock_quantity
FROM dbo.products
ORDER BY product_id;
```

---

### orders – sample records
```sql
SELECT TOP 3
    order_id,
    customer_id,
    order_date,
    total_amount,
    status
FROM dbo.orders
ORDER BY order_date DESC;
```

---

### order_items – sample records
```sql
SELECT TOP 3
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    subtotal
FROM dbo.order_items
ORDER BY order_item_id;
