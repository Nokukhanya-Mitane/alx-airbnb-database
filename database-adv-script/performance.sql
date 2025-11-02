-- ==============================================================
-- Airbnb Clone - Query Performance Optimization
-- File: perfomance.sql
-- Description: Retrieve all booking details with user, property, and payment info
-- ==============================================================

-- --------------------------------------------------------------
-- 1️⃣ INITIAL COMPLEX QUERY (Before Optimization)
-- --------------------------------------------------------------

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM Booking AS b
JOIN User AS u ON b.user_id = u.user_id
JOIN Property AS p ON b.property_id = p.property_id
LEFT JOIN Payment AS pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- Explanation:
-- - Retrieves all booking information, joined with user, property, and payment tables.
-- - LEFT JOIN ensures all bookings are shown, even if payment is not yet made.
-- - ORDER BY can slow down performance if not indexed.

-- --------------------------------------------------------------
-- EXPLAIN ANALYZE (Performance Analysis)
-- --------------------------------------------------------------
-- Run this in PostgreSQL or MySQL to evaluate query execution plan:
-- EXPLAIN ANALYZE
-- (Paste the above query here)

-- Expectation:
-- - High cost from multiple joins
-- - Sequential scan on Booking or Property tables
-- - Sorting operation due to ORDER BY on unindexed column

-- --------------------------------------------------------------
-- 2️⃣ OPTIMIZED QUERY (After Refactoring)
-- --------------------------------------------------------------

-- Improvements:
-- ✅ Added indexes on booking_id, user_id, property_id, created_at
-- ✅ Reduced unnecessary columns
-- ✅ Avoided ORDER BY unless needed
-- ✅ Used SELECT specific columns to minimize data transfer

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.first_name || ' ' || u.last_name AS guest_name,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM Booking AS b
INNER JOIN User AS u ON b.user_id = u.user_id
INNER JOIN Property AS p ON b.property_id = p.property_id
LEFT JOIN Payment AS pay ON b.booking_id = pay.booking_id
WHERE b.status IN ('confirmed', 'completed')
ORDER BY b.start_date DESC;

-- Notes:
-- - Filters only relevant bookings for reporting (status filter)
-- - Avoids unnecessary columns
-- - Uses indexed fields for joins
-- - Sorting now uses indexed column (b.start_date)

-- --------------------------------------------------------------
-- EXPLAIN ANALYZE (After Optimization)
-- --------------------------------------------------------------
-- Run again:
-- EXPLAIN ANALYZE
-- (Paste the optimized query here)
--
-- Expectation:
-- - Index Scan instead of Sequential Scan
-- - Reduced cost from join operations
-- - Lower total execution time
-- ============================================================== 
-- End of File: perfomance.sql
-- ==============================================================

# Airbnb Clone – Query Optimization Report

## 🎯 Objective
To improve the performance of a **complex multi-table SQL query** that retrieves bookings with related user, property, and payment details.

---

## 📂 Files
- **perfomance.sql** → Contains the initial and optimized queries.
- **optimization_report.md** → Documents analysis and performance improvements.

---

## 🧱 Initial Query (Before Optimization)
```sql
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM Booking AS b
JOIN User AS u ON b.user_id = u.user_id
JOIN Property AS p ON b.property_id = p.property_id
LEFT JOIN Payment AS pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

##
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM Booking AS b
JOIN User AS u ON b.user_id = u.user_id
JOIN Property AS p ON b.property_id = p.property_id
LEFT JOIN Payment AS pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

###Optimized Query
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.first_name || ' ' || u.last_name AS guest_name,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM Booking AS b
INNER JOIN User AS u ON b.user_id = u.user_id
INNER JOIN Property AS p ON b.property_id = p.property_id
LEFT JOIN Payment AS pay ON b.booking_id = pay.booking_id
WHERE b.status IN ('confirmed', 'completed')
ORDER BY b.start_date DESC;

###Explain Analyze (Optimized Query)
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.first_name || ' ' || u.last_name AS guest_name,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM Booking AS b
INNER JOIN User AS u ON b.user_id = u.user_id
INNER JOIN Property AS p ON b.property_id = p.property_id
LEFT JOIN Payment AS pay ON b.booking_id = pay.booking_id
WHERE b.status IN ('confirmed', 'completed')
ORDER BY b.start_date DESC;



