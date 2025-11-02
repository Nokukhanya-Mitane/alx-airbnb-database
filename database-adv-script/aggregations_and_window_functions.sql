-- ==============================================================
--  Airbnb Clone - Aggregations and Window Functions
--  File: aggregations_and_window_functions.sql
--  Description: Demonstrates use of SQL aggregate and window functions
-- ==============================================================

-- --------------------------------------------------------------
-- 1️⃣ AGGREGATION QUERY
-- Find the total number of bookings made by each user
-- --------------------------------------------------------------

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM User AS u
LEFT JOIN Booking AS b 
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- Explanation:
-- - COUNT(b.booking_id): counts bookings per user.
-- - LEFT JOIN ensures users with 0 bookings are included.
-- - GROUP BY groups data by user.
-- --------------------------------------------------------------

-- --------------------------------------------------------------
-- 2️⃣ WINDOW FUNCTION QUERY
-- Rank properties based on the total number of bookings
-- --------------------------------------------------------------

SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property AS p
LEFT JOIN Booking AS b 
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;

-- Explanation:
-- - COUNT(b.booking_id): counts total bookings per property.
-- - RANK() OVER(ORDER BY ...): assigns rank based on bookings.
-- - Ties receive the same rank; next rank is skipped.
-- - Can use ROW_NUMBER() for sequential ranking if preferred.

-- ============================================================== 
-- End of File: aggregations_and_window_functions.sql
-- ==============================================================
