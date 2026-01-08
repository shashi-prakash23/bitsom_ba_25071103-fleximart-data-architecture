# Schema Documentation – Sales Database (SQL Server)

/*
SQL Server Schema Reference

CREATE TABLE customers (
    customerid INT IDENTITY(1,1) PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    registration_date DATE
);

CREATE TABLE products (
    productid INT IDENTITY(1,1) PRIMARY KEY,
    productname VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stockquantity INT
);

CREATE TABLE orders (
    orderid INT IDENTITY(1,1) PRIMARY KEY,
    customerid INT,
    orderdate DATE,
    totalamount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

CREATE TABLE orderitems (
    orderitemid INT IDENTITY(1,1) PRIMARY KEY,
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
- **email**: Customer’s email address
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

The Sales Database is designed in compliance with Third Normal Form (3NF) to ensure data integrity, eliminate redundancy, and prevent anomalies.
First Normal Form (1NF) is satisfied because all attributes contain atomic values with no repeating groups.
Second Normal Form (2NF) is achieved since all non-key attributes are fully dependent on their respective primary keys.

Third Normal Form (3NF) is satisfied by eliminating transitive dependencies. Customer attributes depend solely on customerid, product attributes depend solely on productid, and order attributes depend solely on orderid.
No non-key attribute depends on another non-key attribute.

### Functional Dependencies
- customerid → firstname, lastname, email, phone, city, registration_date
- productid → productname, category, price, stockquantity
- orderid → customerid, orderdate, totalamount, status
- orderitemid → orderid, productid, quantity, unitprice, subtotal

### Avoidance of Anomalies
- **Update anomalies** are avoided as data is stored only once.
- **Insert anomalies** are avoided because master data can exist independently.
- **Delete anomalies** are avoided as deleting transactions does not delete master data.

---

## 3. Sample Data Representation (Using Actual Database Data)

The following SQL Server queries can be executed in SSMS to retrieve **real records** loaded from the original source files.

### customers
```sql
SELECT TOP 3 *
FROM customers;
```

---

### products
```sql
SELECT TOP 3 *
FROM products;
```

---

### orders
```sql
SELECT TOP 3 *
FROM orders;
```

---

### orderitems
```sql
SELECT TOP 3 *
FROM orderitems;
```

---