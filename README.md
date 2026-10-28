# Task 02 — Business Rules to Executable Relational Model

## Project scope
This project uses the uploaded RabTech Academy `commerce-seed-data.sql` as its source. The starter file defines two PostgreSQL tables:

- `customers(customer_id, customer_name, city, joined_on)`
- `orders(order_id, customer_id, ordered_on, order_status, amount_inr)`

It includes four customers and six orders. This is a small commerce example, not an internship-management schema.

## Deliverables
- `docs/business-rules.md`: entities, states, cardinality, retention notes, and five rules.
- `docs/er-model.md`: ER diagram in Mermaid format.
- `migrations/001_create_commerce_tables.sql`: idempotent initial schema migration.
- `fixtures/001_seed_commerce.sql`: repeatable sample-data fixture.
- `tests/negative_tests.sql`: invalid inserts that must be rejected.
- `docs/run-and-submit.md`: execution and public-link submission steps.

## Requirements
PostgreSQL 12+ recommended. Use a **dedicated empty database** for the cleanest run.

## Quick start (psql)
Create a database first, for example:
```sql
CREATE DATABASE rabtech_commerce;
```
Then from a terminal:
```bash
psql -d rabtech_commerce -v ON_ERROR_STOP=1 -f migrations/001_create_commerce_tables.sql
psql -d rabtech_commerce -v ON_ERROR_STOP=1 -f fixtures/001_seed_commerce.sql
psql -d rabtech_commerce -v ON_ERROR_STOP=1 -f tests/negative_tests.sql
```
Run these commands from the project root. If using pgAdmin, open each SQL file in Query Tool and execute in the same order.

## Expected result
- Migration creates the two related tables.
- Fixture inserts four customers and six orders. Re-running the fixture does not duplicate these IDs.
- Negative tests print `PASS` notices for each expected rejection. If an invalid insert succeeds, the test raises an exception and the script fails.

## Important implementation notes
1. `CREATE TABLE IF NOT EXISTS` makes the initial migration safe to re-run in a cleanly managed database. It does not retrofit constraints onto a table that already existed with a different definition. For a reliable first run, use an empty database. The uploaded starter SQL already creates tables with the intended constraints, so do not run both the starter file and this migration as separate setup steps in the same database.
2. The source file does not define an order-status transition workflow (for example, whether `CANCELLED` can later become `PAID`). This project restricts allowed status values only.
3. The source file does not specify data-retention periods or deletion policy. Those are recorded as decisions needing business-owner confirmation; this project does not invent a retention duration.
4. `NOT NULL` prevents missing values, but it does not reject empty strings or whitespace-only names/cities. The source starter uses `NOT NULL`, so this project preserves that behavior rather than silently adding a stricter rule.

## Files
See `docs/` for the written design and `migrations/`, `fixtures/`, and `tests/` for executable SQL.
