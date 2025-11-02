# Airbnb Clone – Booking Table Partitioning Performance Report

## 🎯 Objective
To improve query performance on the large **Booking** table by implementing **table partitioning** based on the `start_date` column.

---

## 🧠 Rationale for Partitioning
As the `Booking` table grows (millions of rows), queries that filter by date (e.g., fetching bookings by year or month) slow down.  
Partitioning divides the table into smaller, more manageable segments, allowing PostgreSQL to **scan only relevant partitions** instead of the entire dataset.

---

## 🧱 Partitioning Strategy
| Partition Name | Date Range | Purpose |
|----------------|-------------|----------|
| Booking_2023 | 2023-01-01 → 2024-01-01 | Historical Data |
| Booking_2024 | 2024-01-01 → 2025-01-01 | Current Year |
| Booking_2025 | 2025-01-01 → 2026-01-01 | Future Bookings |
| Booking_default | All Other Dates | Catch-all partition |

Partition key: `start_date`  
Partition type: **Range Partitioning**

---

## ⚙️ Pre-Partition Query (Before Optimization)
```sql
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

⚙️ Post-Partition Query (After Optimization)
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
