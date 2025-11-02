-- ==========================================================
-- Airbnb Clone Database
-- Task: Implement Partitioning on Booking Table
-- ==========================================================

-- 1️⃣ Drop old tables if they exist
DROP TABLE IF EXISTS Booking CASCADE;

-- 2️⃣ Create the main partitioned table
CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    total_price NUMERIC(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (start_date);

-- 3️⃣ Create partitions for specific date ranges
-- Example: Yearly partitions (you can adjust by month or quarter if needed)
CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- 4️⃣ Create a default partition for old or future records
CREATE TABLE Booking_default PARTITION OF Booking DEFAULT;

-- 5️⃣ Add indexes to improve partition performance
CREATE INDEX idx_booking_2023_start_date ON Booking_2023 (start_date);
CREATE INDEX idx_booking_2024_start_date ON Booking_2024 (start_date);
CREATE INDEX idx_booking_2025_start_date ON Booking_2025 (start_date);

-- 6️⃣ Example Query for fetching bookings by date range (optimized by partition pruning)
EXPLAIN ANALYZE
SELECT booking_id, user_id, property_id, start_date, end_date
FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- 7️⃣ Example Insertion to verify partition routing
INSERT INTO Booking (user_id, property_id, start_date, end_date, status, total_price)
VALUES
(1, 101, '2023-06-15', '2023-06-20', 'completed', 1200.00),
(2, 202, '2024-09-10', '2024-09-15', 'confirmed', 800.00),
(3, 303, '2025-01-05', '2025-01-12', 'pending', 950.00);

-- 8️⃣ Example: Query to confirm which partitions hold the data
SELECT tableoid::regclass AS partition_name, COUNT(*) AS total_rows
FROM Booking
GROUP BY partition_name;
