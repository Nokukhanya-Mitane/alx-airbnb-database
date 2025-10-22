# ER Diagram Requirements - AirBnB Database

## Entities
- User
- Property
- Booking
- Payment
- Review
- Message

## Relationships
- User (1) ↔ (M) Property
- User (1) ↔ (M) Booking
- Property (1) ↔ (M) Booking
- Booking (1) ↔ (1) Payment
- Property (1) ↔ (M) Review
- User (1) ↔ (M) Review
- User (1) ↔ (M) Message (as sender)
- User (1) ↔ (M) Message (as recipient)

## Notes
- All primary keys are UUIDs and indexed.
- Foreign keys enforce referential integrity.
- ENUM and CHECK constraints ensure valid data.
- email (User) is unique and indexed.
