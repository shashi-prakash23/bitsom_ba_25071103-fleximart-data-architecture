# Schema Documentation – Sales Database

/* 
SQL Schema Reference

CREATE TABLE customers (
    customerid INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    registration_date DATE
);

CREATE TABLE products (
    productid INT PRIMARY KEY AUTO_INCREMENT,
    productname VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stockquantity INT
);

CREATE TABLE orders (
    orderid INT PRIMARY KEY AUTO_INCREMENT,
    customerid INT,
    orderdate DATE,
    totalamount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

CREATE TABLE orderitems (
    orderitemid INT PRIMARY KEY AUTO_INCREMENT,
    orderid INT,
    productid INT,
    quantity INT,
    unitprice DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (orderid) REFERENCES orders(orderid),
    FOREIGN KEY (productid) REFERENCES products(productid)
);
*/

---

## 1. Entity–Relationship Description

### ENTITY: customers

**Purpose:**  
Stores customer master information for individuals who place orders.

**Attributes:**
- **customerid**: Unique identifier for each customer (Primary Key)
- **firstname**: Customer's first name
- **lastname**: Customer's last name
- **email**: Customer’s email address (unique)
- **phone**: Contact phone number
- **city**: City of residence
- **registration_date**: Date the customer registered

**Relationships:**
- One customer can place **many orders** (1:M relationship with `orders`)

---

### ENTITY: products

**Purpose:**  
Stores information about products available for sale.

**Attributes:**
- **productid**: Unique identifier (Primary Key)
- **productname**: Name of the product
- **category**: Product category
- **price**: Unit price
- **stockquantity**: Quantity in stock

**Relationships:**
- One product can appear in **many order items**

---

### ENTITY: orders

**Purpose:**  
Stores order-level transaction details.

**Attributes:**
- **orderid**: Unique order identifier (Primary Key)
- **customerid**: Customer placing the order (Foreign Key)
- **orderdate**: Date of order
- **totalamount**: Total order value
- **status**: Order status

**Relationships:**
- Each order belongs to **one customer**
- Each order has **many order items**

---

### ENTITY: orderitems

**Purpose:**  
Stores individual line items for each order.

**Attributes:**
- **orderitemid**: Unique identifier (Primary Key)
- **orderid**: Associated order (Foreign Key)
- **productid**: Associated product (Foreign Key)
- **quantity**: Quantity ordered
- **unitprice**: Price per unit
- **subtotal**: Calculated as quantity × unitprice

---

## 2. Normalization Explanation (Third Normal Form – 3NF)

The Sales Database is designed in compliance with Third Normal Form (3NF) to ensure data integrity, eliminate redundancy, and prevent anomalies. The design satisfies First Normal Form by ensuring that all attributes contain atomic values and that there are no repeating groups. Second Normal Form is achieved because all non-key attributes are fully dependent on the entire primary key of their respective tables.

Third Normal Form is satisfied by eliminating transitive dependencies. In the customers table, attributes such as firstname, lastname, email, and city depend solely on customerid. Similarly, product details depend only on productid, and order attributes depend only on orderid. No non-key attribute depends on another non-key attribute.

### Functional Dependencies
- customerid → firstname, lastname, email, phone, city, registration_date
- productid → productname, category, price, stockquantity
- orderid → customerid, orderdate, totalamount, status
- orderitemid → orderid, productid, quantity, unitprice, subtotal

### Avoidance of Anomalies
- **Update anomalies** are avoided because customer and product data are stored only once.
- **Insert anomalies** are prevented since customers and products can exist without orders.
- **Delete anomalies** are avoided because deleting an order does not remove customer or product records.

This normalized structure ensures scalability, consistency, and maintainability.

---

## 3. Sample Data Representation

### customers

| customerid | firstname | lastname | city   |
|------------|-----------|----------|--------|
| 1 | Rahul | Sharma | Delhi |
| 2 | Anita | Verma | Mumbai |

---

### products

| productid | productname | category | price |
|----------|------------|----------|-------|
| 1 | Laptop | Electronics | 65000 |
| 2 | Headphones | Accessories | 2500 |

---

### orders

| orderid | customerid | orderdate | totalamount | status |
|--------|------------|-----------|-------------|--------|
| 101 | 1 | 2024-06-01 | 67500 | Completed |
| 102 | 2 | 2024-06-03 | 2500 | Pending |

---

### orderitems

| orderitemid | orderid | productid | quantity | subtotal |
|------------|---------|-----------|----------|----------|
| 1 | 101 | 1 | 1 | 65000 |
| 2 | 101 | 2 | 1 | 2500 |


