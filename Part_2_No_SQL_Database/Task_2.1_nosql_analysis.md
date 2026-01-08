# NoSQL Analysis Report – MongoDB for FlexiMart Product Catalog

## Section A: Limitations of RDBMS (Relational Databases)

Relational databases such as MySQL or SQL Server are based on fixed schemas and predefined table structures. This makes them less suitable for product catalogs where items have highly diverse attributes. For example, laptops may require attributes like RAM, processor, storage, and operating system, while shoes need size, color, material, and brand. In an RDBMS, supporting such variability typically requires either adding many nullable columns or creating multiple related tables, which increases complexity and reduces clarity.

Frequent schema changes are another challenge. Each time a new product type with new attributes is introduced, the database schema must be altered. Schema changes in relational databases are costly operations that can require downtime, impact existing queries, and increase maintenance overhead.

Additionally, storing nested or hierarchical data such as customer reviews, ratings, and comments is inefficient in an RDBMS. Reviews usually require separate tables with joins to products and customers. As the number of reviews grows, queries become more complex and performance can degrade due to multiple joins.

---

## Section B: Benefits of MongoDB (NoSQL)

MongoDB addresses these challenges through its flexible, document-based data model. Products are stored as JSON-like documents, allowing each product to have its own set of attributes without enforcing a rigid schema. This makes it easy to store laptops, shoes, and other product types in the same collection, each with different fields, without modifying the database structure.

MongoDB also supports embedded documents, which is ideal for nested data such as customer reviews. Reviews can be stored directly inside the product document as an array, allowing all product-related information to be retrieved in a single query. This improves read performance and simplifies application logic.

Another major advantage is horizontal scalability. MongoDB is designed to scale out using sharding, distributing data across multiple servers. As FlexiMart’s product catalog and traffic grow, MongoDB can handle large volumes of data and high read/write throughput more efficiently than a traditional single-node relational database.

---

## Section C: Trade-offs of Using MongoDB

Despite its flexibility, MongoDB has trade-offs compared to relational databases. One disadvantage is weaker support for complex multi-document transactions, which can be critical for systems requiring strict consistency across many related entities. Although MongoDB supports transactions, they are generally more limited and can impact performance.

Another drawback is the lack of enforced schema and foreign key constraints. While flexibility is an advantage, it also increases the risk of inconsistent or poorly structured data if application-level validations are not carefully implemented. This places greater responsibility on developers to maintain data integrity.

