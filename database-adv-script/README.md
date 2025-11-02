# Airbnb Clone – Advanced SQL Joins

## 🎯 Objective
This module demonstrates advanced SQL joins used in the Airbnb Clone database to retrieve complex, relational data efficiently.

---

## 📂 Files
- **joins_queries.sql** → Contains SQL scripts for INNER, LEFT, and FULL OUTER JOIN queries.

---

## 🧠 Queries Overview

### 1️⃣ INNER JOIN – Bookings with Users
Retrieves all bookings along with the user who made each booking.

```sql
SELECT 
    b.booking_id, b.property_id, b.start_date, b.end_date, 
    u.user_id, u.first_name, u.last_name, u.email
FROM Booking AS b
INNER JOIN User AS u
    ON b.user_id = u.user_id;

###2️⃣ LEFT JOIN – Properties with Reviews

Retrieves all properties and their reviews, including properties that have no reviews.

SELECT 
    p.property_id, p.name, p.location, r.review_id, r.rating, r.comment
FROM Property AS p
LEFT JOIN Review AS r
    ON p.property_id = r.property_id;


Result: Includes all properties, even if reviews are missing (review columns will be NULL).

###3️⃣ FULL OUTER JOIN – Users and Bookings

Retrieves all users and all bookings, even if no relationship exists between them.

SELECT 
    u.user_id, u.first_name, b.booking_id, b.status
FROM User AS u
FULL OUTER JOIN Booking AS b
    ON u.user_id = b.user_id;


Result: Combines all users and all bookings — useful for auditing or data integrity checks.

🧩 Database Tables Used

User

Property

Booking

Review

⚙️ Execution

Run the queries in your SQL environment (e.g., MySQL, PostgreSQL, or SQLite):

psql -d airbnb_clone_db -f joins_queries.sql
