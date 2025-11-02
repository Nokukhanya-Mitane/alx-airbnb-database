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


