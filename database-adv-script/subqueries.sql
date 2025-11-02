-- ==============================================================
--  Airbnb Clone - Advanced SQL Subqueries
--  File: subqueries.sql
--  Description: Demonstrates non-correlated and correlated subqueries
-- ==============================================================

-- --------------------------------------------------------------
-- 1️⃣ NON-CORRELATED SUBQUERY
-- Find all properties where the average rating is greater than 4.0
-- --------------------------------------------------------------
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM Property AS p
WHERE p.property_id IN (
    SELECT 
        r.property_id
    FROM Review AS r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.property_id;

-- Explanation:
-- The inner query calculates the average rating per property (GROUP BY property_id)
-- The outer query selects only properties that meet the condition (average rating > 4.0)

-- --------------------------------------------------------------
-- 2️⃣ CORRELATED SUBQUERY
-- Find users who have made more than 3 bookings
-- --------------------------------------------------------------
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM User AS u
WHERE (
    SELECT COUNT(*)
    FROM Booking AS b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.user_id;

-- Explanation:
-- The subquery is correlated because it references the outer query's user_id.
-- For each user, it counts how many bookings they’ve made.
-- Only users with more than 3 bookings are included.

-- ============================================================== 
-- End of File: subqueries.sql
-- ==============================================================
