-- Migration 001: initial commerce schema
-- PostgreSQL. Run in a dedicated empty database for the cleanest first run.
-- Safe to re-run when the tables already match this schema.

BEGIN;

CREATE TABLE IF NOT EXISTS customers (
    customer_id   INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city          VARCHAR(80) NOT NULL,
    joined_on     DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id     INTEGER PRIMARY KEY,
    customer_id  INTEGER NOT NULL REFERENCES customers(customer_id),
    ordered_on   DATE NOT NULL,
    order_status VARCHAR(20) NOT NULL
        CHECK (order_status IN ('PLACED', 'PAID', 'CANCELLED')),
    amount_inr   NUMERIC(10,2) NOT NULL
        CHECK (amount_inr >= 0)
);

COMMIT;
