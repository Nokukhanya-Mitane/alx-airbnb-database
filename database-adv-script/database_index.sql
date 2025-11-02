-- ==============================================================
-- Airbnb Clone - Index Optimization Script
-- File: database_index.sql
-- Description: Create indexes to improve query performance
-- ==============================================================

-- --------------------------------------------------------------
-- 1️⃣ USER TABLE INDEXES
-- --------------------------------------------------------------

-- Index on email for quick login and lookup (used in authentication)
CREATE INDEX idx_user_email ON User(email);

-- Index on role for faster filtering by user type (guest, host, admin)
CREATE INDEX idx_user_role ON User(role);

-- --------------------------------------------------------------
-- 2️⃣ PROPERTY TABLE INDEXES
-- --------------------------------------------------------------

-- Index on location for faster searches and filtering
CREATE INDEX idx_property_location ON Property(location);

-- Index on pricepernight for range queries (used in filtering/sorting)
CREATE INDEX idx_property_price ON Property(pricepernight);

-- Index on host_id to optimize joins with User table
CREATE INDEX idx_property_host_id ON Property(host_id);

-- --------------------------------------------------------------
-- 3️⃣ BOOKING TABLE INDEXES
-- --------------------------------------------------------------

-- Index on user_id to optimize user-booking relationships
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on property_id to optimize joins with Property table
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on status for filtering by booking state (pending, confirmed, canceled)
CREATE INDEX idx_booking_status ON Booking(status);

-- Index on start_date for searching upcoming bookings
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- --------------------------------------------------------------
-- 4️⃣ PERFORMANCE TESTING (Optional)
-- Run EXPLAIN or ANALYZE to measure performance before and after indexing.
-- --------------------------------------------------------------
-- Example (PostgreSQL):
-- EXPLAIN ANALYZE 
-- SELECT * FROM Booking WHERE user_id = 'user-1234' AND status = 'confirmed';
-- --------------------------------------------------------------

-- ============================================================== 
-- End of File: database_index.sql
-- ==============================================================
