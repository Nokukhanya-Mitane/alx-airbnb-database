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

# Airbnb Clone – SQL Subqueries

## 🎯 Objective
This task demonstrates how to use **subqueries** (both correlated and non-correlated) in SQL to extract complex insights from the Airbnb Clone database.

---

## 📂 Files
- **subqueries.sql** → Contains SQL examples of correlated and non-correlated subqueries.

---

## 🧠 Queries Overview

### 1️⃣ Non-Correlated Subquery – Properties with Average Rating > 4.0
Retrieves all properties whose **average review rating** is higher than 4.0.

```sql
SELECT p.property_id, p.name, p.location
FROM Property AS p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review AS r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
Result: Returns all properties that consistently receive high ratings.

2️⃣ Correlated Subquery – Users with More Than 3 Bookings
Retrieves users who have made more than three bookings.

sql
Copy code
SELECT u.user_id, u.first_name, u.last_name
FROM User AS u
WHERE (
    SELECT COUNT(*)
    FROM Booking AS b
    WHERE b.user_id = u.user_id
) > 3;
Result: Returns users who are frequent guests (made over three bookings).

🧩 Database Tables Used
User

Property

Review

Booking

⚙️ How to Run
Run the queries in your SQL client (PostgreSQL, MySQL, etc.):

bash
Copy code
psql -d airbnb_clone_db -f subqueries.sql
🧠 Concepts Covered
Subquery in WHERE clause

IN operator with subqueries

GROUP BY and HAVING for aggregation

Correlated subqueries with table references

# Airbnb Clone – Aggregations and Window Functions

## 🎯 Objective
This task demonstrates how to use **SQL aggregate functions** (like `COUNT`) and **window functions** (`RANK`, `ROW_NUMBER`) to analyze Airbnb database data.

---

## 📂 Files
- **aggregations_and_window_functions.sql** – Contains the SQL queries for aggregation and ranking operations.

---

## 🧠 Queries Overview

### 1️⃣ Total Number of Bookings per User
This query counts how many bookings each user has made.

```sql
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
Result: Displays each user with the number of bookings they made, sorted by the highest first.

2️⃣ Rank Properties by Number of Bookings
This query ranks properties based on their booking popularity using a window function.

sql
Copy code
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
Result: Displays properties ranked from most to least booked.

⚙️ How to Run
To execute the queries, run:

bash
Copy code
psql -d airbnb_clone_db -f aggregations_and_window_functions.sql
or, in MySQL:

bash
Copy code
mysql -u root -p airbnb_clone_db < aggregations_and_window_functions.sql
🧩 Tables Used
User

Property

Booking
