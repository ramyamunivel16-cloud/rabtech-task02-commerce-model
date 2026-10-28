-- Negative tests for PostgreSQL.
-- Each test succeeds only if the invalid row is rejected by the expected constraint.
-- Run after migration + seed fixture. Test IDs use negative values to avoid collisions.

DO $$
BEGIN
    BEGIN
        INSERT INTO customers (customer_id, customer_name, city, joined_on)
        VALUES (-901, 'Duplicate ID test', 'Test City', '2026-10-01');
        INSERT INTO customers (customer_id, customer_name, city, joined_on)
        VALUES (-901, 'Duplicate ID test 2', 'Test City', '2026-10-02');
        RAISE EXCEPTION 'FAIL BR-01: duplicate customer_id was accepted';
    EXCEPTION WHEN unique_violation THEN
        RAISE NOTICE 'PASS BR-01: duplicate customer_id rejected';
    END;

    BEGIN
        INSERT INTO customers (customer_id, customer_name, city, joined_on)
        VALUES (-902, NULL, 'Test City', '2026-10-01');
        RAISE EXCEPTION 'FAIL BR-02: NULL customer_name was accepted';
    EXCEPTION WHEN not_null_violation THEN
        RAISE NOTICE 'PASS BR-02: NULL customer_name rejected';
    END;

    BEGIN
        INSERT INTO orders (order_id, customer_id, ordered_on, order_status, amount_inr)
        VALUES (-903, -999999, '2026-10-01', 'PLACED', 10.00);
        RAISE EXCEPTION 'FAIL BR-03: orphan order was accepted';
    EXCEPTION WHEN foreign_key_violation THEN
        RAISE NOTICE 'PASS BR-03: order for missing customer rejected';
    END;

    BEGIN
        INSERT INTO orders (order_id, customer_id, ordered_on, order_status, amount_inr)
        VALUES (-904, 1, '2026-10-01', 'REFUNDED', 10.00);
        RAISE EXCEPTION 'FAIL BR-04: invalid order_status was accepted';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PASS BR-04: invalid order_status rejected';
    END;

    BEGIN
        INSERT INTO orders (order_id, customer_id, ordered_on, order_status, amount_inr)
        VALUES (-905, 1, '2026-10-01', 'PLACED', -0.01);
        RAISE EXCEPTION 'FAIL BR-05: negative amount was accepted';
    EXCEPTION WHEN check_violation THEN
        RAISE NOTICE 'PASS BR-05: negative amount rejected';
    END;
END $$;
