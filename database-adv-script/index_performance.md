# Airbnb Clone – Index Optimization and Performance Analysis

## 🎯 Objective
To improve database query performance by identifying frequently queried columns and applying **indexes** to optimize read operations.

---

## 📂 Files
- **database_index.sql** – SQL script for creating indexes.
- **index_performance.md** – Documentation explaining index usage and performance testing.

---

## 🧠 Indexed Tables and Columns

| Table     | Column(s)           | Purpose / Usage                                   | Type of Query Improved |
|------------|--------------------|---------------------------------------------------|-------------------------|
| **User**   | `email`            | User login, authentication                        | `WHERE`, `JOIN`         |
|            | `role`             | Filtering by user type                            | `WHERE`                 |
| **Property** | `location`       | Property search and filtering                     | `WHERE`, `ORDER BY`     |
|            | `pricepernight`    | Sorting and price-range filtering                 | `ORDER BY`, `BETWEEN`   |
|            | `host_id`          | Joining Property with User table                  | `JOIN`                  |
| **Booking** | `user_id`         | Linking bookings to users                         | `JOIN`, `WHERE`         |
|            | `property_id`      | Linking bookings to properties                    | `JOIN`                  |
|            | `status`           | Filtering by booking state                        | `WHERE`                 |
|            | `start_date`       | Searching by date                                 | `WHERE`, `ORDER BY`     |

---

## ⚙️ Example: Before and After Indexing

### 🔍 Query Tested
```sql
EXPLAIN ANALYZE
SELECT * 
FROM Booking 
WHERE user_id = 'user-1234' 
AND status = 'confirmed';
