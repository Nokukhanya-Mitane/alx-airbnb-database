# Database Schema (DDL) – AirBnB Database

## Objective
Define the database schema for the AirBnB system by writing SQL statements that:
- Create all required tables and relationships.
- Enforce primary and foreign key constraints.
- Apply validation rules and indexing for optimal performance.

---

## Tables Created

| Table Name | Description |
|-------------|--------------|
| **users** | Stores user details (guest, host, or admin) |
| **properties** | Stores property/listing details |
| **bookings** | Tracks reservations by users for properties |
| **payments** | Manages payments for bookings |
| **reviews** | Stores user reviews for properties |
| **messages** | Stores private messages between users |

---

## Key Constraints and Features
- **Primary keys**: All use UUIDs.
- **Foreign keys**: Enforce referential integrity across entities.
- **ENUM checks**: Used for controlled values (`role`, `status`, `payment_method`).
- **Indexes**: Added on frequently queried columns like `email`, `property_id`, `booking_id`.
- **Cascading deletes**: When a parent record (user, property, or booking) is removed, dependent records are deleted.

---

## Example Run (PostgreSQL)
To create the schema in your database:
```bash
psql -U <username> -d airbnb_db -f schema.sql
