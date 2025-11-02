# Airbnb Clone – Query Optimization Report

## 🎯 Objective
To improve the performance of a **complex multi-table SQL query** that retrieves bookings with related user, property, and payment details.

---

## 📂 Files
- **perfomance.sql** → Contains the initial and optimized queries.
- **optimization_report.md** → Documents analysis and performance improvements.

---

## 🧱 Initial Query (Before Optimization)

### 🔍 Query Overview
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
