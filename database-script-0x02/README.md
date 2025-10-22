# Database Seeding – AirBnB Database

## Objective
Populate the AirBnB database with **sample data** that represents realistic system usage.

---

## Contents
- `seed.sql`: SQL script containing INSERT statements for sample data.

---

## Data Overview

| Table | Description | Sample Records |
|--------|--------------|----------------|
| **users** | 5 users (hosts, guests, admin) | Alice (host), Bob (guest), Carol (guest), David (host), Admin |
| **properties** | 3 properties owned by hosts | Seaside Villa, Mountain Cabin, City Apartment |
| **bookings** | 2 sample bookings | Bob and Carol’s reservations |
| **payments** | 1 payment record | Linked to Bob’s booking |
| **reviews** | 2 reviews | Guests reviewing their stays |
| **messages** | 2 messages | Conversation between Bob and Alice |

---

## Running the Seed Script (PostgreSQL)
Run the following command after creating your database and schema:

```bash
psql -U <username> -d airbnb_db -f seed.sql
