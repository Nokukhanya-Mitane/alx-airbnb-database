-- AirBnB Database Seed Script
-- Author: Nokukhanya Mitane
-- Project: ALX Airbnb Database
-- Description: Insert sample data into the AirBnB database for testing

-- ================================
-- 1. USERS
-- ================================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (uuid_generate_v4(), 'Alice', 'Smith', 'alice@example.com', 'hashed_password_1', '1234567890', 'host'),
    (uuid_generate_v4(), 'Bob', 'Johnson', 'bob@example.com', 'hashed_password_2', '0987654321', 'guest'),
    (uuid_generate_v4(), 'Carol', 'Brown', 'carol@example.com', 'hashed_password_3', '0712345678', 'guest'),
    (uuid_generate_v4(), 'David', 'Miller', 'david@example.com', 'hashed_password_4', '0823456789', 'host'),
    (uuid_generate_v4(), 'Admin', 'User', 'admin@example.com', 'hashed_password_admin', '0100000000', 'admin');

-- ================================
-- 2. PROPERTIES
-- ================================
-- Assume Alice and David are hosts
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
SELECT
    uuid_generate_v4(), user_id, 'Seaside Villa', 'A beautiful ocean-view villa.', 'Cape Town, South Africa', 1500.00
FROM users WHERE email = 'alice@example.com';

INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
SELECT
    uuid_generate_v4(), user_id, 'Mountain Cabin', 'A cozy cabin in the Drakensberg.', 'KwaZulu-Natal, South Africa', 950.00
FROM users WHERE email = 'david@example.com';

INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
SELECT
    uuid_generate_v4(), user_id, 'City Apartment', 'Modern apartment in Johannesburg CBD.', 'Johannesburg, South Africa', 800.00
FROM users WHERE email = 'alice@example.com';

-- ================================
-- 3. BOOKINGS
-- ================================
-- Bob and Carol make bookings on Alice’s and David’s properties
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT
    uuid_generate_v4(),
    p.property_id,
    u.user_id,
    '2025-10-01',
    '2025-10-05',
    6000.00,
    'confirmed'
FROM properties p
JOIN users u ON u.email = 'bob@example.com'
WHERE p.name = 'Seaside Villa';

INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT
    uuid_generate_v4(),
    p.property_id,
    u.user_id,
    '2025-11-15',
    '2025-11-20',
    4750.00,
    'pending'
FROM properties p
JOIN users u ON u.email = 'carol@example.com'
WHERE p.name = 'Mountain Cabin';

-- ================================
-- 4. PAYMENTS
-- ================================
-- Payment for Bob’s confirmed booking
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
SELECT
    uuid_generate_v4(),
    b.booking_id,
    6000.00,
    'credit_card'
FROM bookings b
JOIN users u ON u.email = 'bob@example.com'
WHERE b.status = 'confirmed';

-- ================================
-- 5. REVIEWS
-- ================================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
SELECT
    uuid_generate_v4(),
    p.property_id,
    u.user_id,
    5,
    'Amazing stay! The villa was spotless and the host was very friendly.'
FROM properties p
JOIN users u ON u.email = 'bob@example.com'
WHERE p.name = 'Seaside Villa';

INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
SELECT
    uuid_generate_v4(),
    p.property_id,
    u.user_id,
    4,
    'Beautiful location, cozy cabin. Could use better Wi-Fi.'
FROM properties p
JOIN users u ON u.email = 'carol@example.com'
WHERE p.name = 'Mountain Cabin';

-- ================================
-- 6. MESSAGES
-- ================================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
SELECT
    uuid_generate_v4(),
    s.user_id,
    r.user_id,
    'Hi Alice, I have a question about the Seaside Villa before booking.'
FROM users s, users r
WHERE s.email = 'bob@example.com' AND r.email = 'alice@example.com';

INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
SELECT
    uuid_generate_v4(),
    s.user_id,
    r.user_id,
    'Hello Bob, sure! What would you like to know?'
FROM users s, users r
WHERE s.email = 'alice@example.com' AND r.email = 'bob@example.com';

-- ================================
-- END OF SEED SCRIPT
-- ================================
