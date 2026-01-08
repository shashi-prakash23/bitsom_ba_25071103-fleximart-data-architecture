# Star Schema Design Documentation
## FlexiMart Data Warehouse
**Part 3: Data Warehouse and Analytics**

---

## Section 1: Schema Overview

### FACT TABLE: fact_sales
**Grain:** One row per product per order line item  
**Business Process:** Sales transactions capturing individual product-level sales within each order.

**Measures (Numeric Facts):**
- **quantity_sold:** Number of units sold per product per order line
- **unit_price:** Price per unit at the time of sale
- **discount_amount:** Discount applied to the line item
- **total_amount:** Final sale value (quantity_sold × unit_price − discount_amount)

**Foreign Keys:**
- **date_key** → dim_date
- **product_key** → dim_product
- **customer_key** → dim_customer

---

### DIMENSION TABLE: dim_date
**Purpose:** Enables time-based analysis such as daily, monthly, quarterly, and yearly trends  
**Type:** Conformed dimension

**Attributes:**
- date_key (PK): Surrogate key in YYYYMMDD format
- full_date: Actual calendar date
- day_of_week: Monday, Tuesday, etc.
- month: Numeric month (1–12)
- month_name: January, February, etc.
- quarter: Q1, Q2, Q3, Q4
- year: Calendar year
- is_weekend: Boolean indicator

---

### DIMENSION TABLE: dim_product
**Purpose:** Provides descriptive context for products sold

**Attributes:**
- product_key (PK): Surrogate key
- product_id: Source system product identifier
- product_name: Name of the product
- category: Product category (e.g., Electronics, Fashion)
- subcategory: Product subcategory
- brand: Brand name
- price_band: Derived price range (Low, Medium, High)

---

### DIMENSION TABLE: dim_customer
**Purpose:** Supports customer-centric analysis and segmentation

**Attributes:**
- customer_key (PK): Surrogate key
- customer_id: Source system customer identifier
- customer_name: Full name of customer
- city: City of residence
- state: State or region
- registration_date: Date customer registered

---

## Section 2: Design Decisions

The star schema is designed at the transaction line-item grain to capture the most granular level of sales activity. This allows accurate aggregation across products, customers, and time, and supports flexible analytics without losing detail. Surrogate keys are used instead of natural keys to improve query performance, ensure consistency across source systems, and handle slowly changing dimensions effectively. Natural keys from source systems may change or have business meaning, whereas surrogate keys are stable and warehouse-controlled.

This dimensional design enables efficient drill-down and roll-up operations. Analysts can roll up sales data from daily to monthly or yearly levels using the date dimension, or drill down from category-level sales to individual products using the product dimension. Similarly, customer analysis can move between geographic summaries and individual customer behavior, making the schema well-suited for business intelligence and reporting.

---

## Section 3: Sample Data Flow

### Source Transaction
- Order Number: 101  
- Customer: John Doe  
- Product: Laptop  
- Quantity: 2  
- Unit Price: 50,000  

### Data Warehouse Representation

**fact_sales**
```json
{
  "date_key": 20240115,
  "product_key": 5,
  "customer_key": 12,
  "quantity_sold": 2,
  "unit_price": 50000,
  "total_amount": 100000
}
```

**dim_date**
```json
{
  "date_key": 20240115,
  "full_date": "2024-01-15",
  "month": 1,
  "quarter": "Q1",
  "year": 2024
}
```

**dim_product**
```json
{
  "product_key": 5,
  "product_name": "Laptop",
  "category": "Electronics"
}
```

**dim_customer**
```json
{
  "customer_key": 12,
  "customer_name": "John Doe",
  "city": "Mumbai"
}
```

---
