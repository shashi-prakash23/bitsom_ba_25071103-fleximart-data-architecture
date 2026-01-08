-- This will create the relevant tables with required column in the SQL SERVER Management Studio

CREATE TABLE dbo.customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    phone      VARCHAR(20),
    city       VARCHAR(50),
    registration_date DATE
);

-- Products
CREATE TABLE dbo.products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50) NOT NULL,
    price        DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

-- Orders
CREATE TABLE dbo.orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT FK_orders_customers
        FOREIGN KEY (customer_id) REFERENCES dbo.customers(customer_id)
);

-- Order items
CREATE TABLE dbo.order_items (
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id  INT NOT NULL,
    product_id INT NOT NULL,
    quantity   INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal   DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_order_items_orders
        FOREIGN KEY (order_id) REFERENCES dbo.orders(order_id),
    CONSTRAINT FK_order_items_products
        FOREIGN KEY (product_id) REFERENCES dbo.products(product_id)
);

