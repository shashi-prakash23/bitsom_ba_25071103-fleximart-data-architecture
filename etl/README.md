# MySQL Sales Dataset

## Overview

This repository contains a fully normalized **Sales Database** implemented using **MySQL** and populated through a **Python-based ETL pipeline**. The project demonstrates best practices in relational database design, normalization, and data loading using industry-standard tools.

The dataset is suitable for academic assignments, portfolio projects, and hands-on practice with SQL, Python, and ETL workflows.

---

## Repository Structure

```text
mysql-sales-dataset/
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   └── orderitems.csv
├── schema/
│   └── create_tables.sql
├── etl/
│   └── etl_pipeline.ipynb
├── docs/
│   └── schema_documentation.md
└── README.md
```

---

## Database Tables

- customers – Customer master data  
- products – Product catalog  
- orders – Order-level transactions  
- orderitems – Line-item details per order  

The schema is normalized to **Third Normal Form (3NF)**.

---

## How to Use

1. Run `schema/create_tables.sql` in MySQL
2. Load CSV files from `data/`
3. Optionally run the ETL pipeline in `etl/etl_pipeline.ipynb`

---

## Technologies Used

- MySQL
- Python
- Pandas
- SQLAlchemy
- Git & GitHub

---

## License

Educational use only.

---

## Author

Shashi Prakash
