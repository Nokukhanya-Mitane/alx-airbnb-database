-- ==============================================================
--  Airbnb Clone - Advanced SQL Joins
--  File: joins_queries.sql
--  Description: SQL scripts demonstrating INNER, LEFT, and FULL OUTER joins
-- ==============================================================

-- --------------------------------------------------------------
-- 1️⃣ INNER JOIN
-- Retrieve all bookings and the respective users who made them
-- --------------------------------------------------------------
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM Booking AS b
INNER JOIN User AS u
    ON b.user_id = u.user_id
ORDER BY b.created_at DESC;

-- This query returns only bookings that have a valid user (guest) associated with them.

-- --------------------------------------------------------------
-- 2️⃣ LEFT JOIN
-- Retrieve all properties and their reviews, including properties with no reviews
-- --------------------------------------------------------------
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM Property AS p
LEFT JOIN Review AS r
    ON p.property_id = r.property_id
ORDER BY p.created_at DESC;

-- This query ensures that properties without reviews are still included,
-- with NULL values for review fields.

-- --------------------------------------------------------------
-- 3️⃣ FULL OUTER JOIN
-- Retrieve all users and all bookings, even if there is no match
-- --------------------------------------------------------------
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status
FROM User AS u
FULL OUTER JOIN Booking AS b
    ON u.user_id = b.user_id
ORDER BY u.user_id;

-- This query returns:
-- - Users who have bookings
-- - Users with no bookings
-- - Bookings not linked to any existing user (if data inconsistency exists)

-- ============================================================== 
-- End of File: joins_queries.sql
-- ==============================================================
