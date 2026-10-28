-- Repeatable seed fixture: re-running will not duplicate these primary keys.
-- The values match the supplied commerce-seed-data.sql.

BEGIN;

INSERT INTO customers (customer_id, customer_name, city, joined_on) VALUES
    (1, 'Aarav Mehta', 'Chennai', '2026-01-03'),
    (2, 'Diya Nair', 'Kochi', '2026-01-10'),
    (3, 'Kabir Shah', 'Pune', '2026-02-02'),
    (4, 'Meera Iyer', 'Bengaluru', '2026-02-15')
ON CONFLICT (customer_id) DO NOTHING;

INSERT INTO orders (order_id, customer_id, ordered_on, order_status, amount_inr) VALUES
    (101, 1, '2026-03-01', 'PAID',      1499.00),
    (102, 1, '2026-03-17', 'CANCELLED',  799.00),
    (103, 2, '2026-03-05', 'PAID',      2499.00),
    (104, 3, '2026-04-02', 'PLACED',     999.00),
    (105, 4, '2026-04-06', 'PAID',      1899.00),
    (106, 2, '2026-04-08', 'PAID',       599.00)
ON CONFLICT (order_id) DO NOTHING;

COMMIT;
