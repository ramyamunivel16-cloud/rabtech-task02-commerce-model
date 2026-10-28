# Run, Verify, and Submit

## A. Put the files in a GitHub repository
1. Sign in to GitHub and choose **New repository**.
2. Repository name: `rabtech-task02-commerce-model`.
3. Choose **Public** if your academy requires one public link. Do not upload passwords, tokens, or personal data.
4. Create the repository.
5. Choose **Add file → Upload files** and upload this project's folders and files, preserving the folder structure.
6. Commit the files with a message such as `Complete Task 02 commerce relational model`.

Alternatively, use Git:
```bash
git init
git add .
git commit -m "Complete Task 02 commerce relational model"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/rabtech-task02-commerce-model.git
git push -u origin main
```
Replace `YOUR-USERNAME` with your actual GitHub username.

## B. Run the SQL
Use a dedicated, empty PostgreSQL database. From the repository root:
```bash
psql -d rabtech_commerce -v ON_ERROR_STOP=1 -f migrations/001_create_commerce_tables.sql
psql -d rabtech_commerce -v ON_ERROR_STOP=1 -f fixtures/001_seed_commerce.sql
psql -d rabtech_commerce -v ON_ERROR_STOP=1 -f tests/negative_tests.sql
```

The negative tests should print five `PASS` notices. If a bad row is accepted, the test raises a `FAIL` exception. A database administrator or your local PostgreSQL setup may require a username/host option, e.g. `psql -U postgres -d rabtech_commerce ...`.

## C. Verify the sample rows
Run:
```sql
SELECT * FROM customers ORDER BY customer_id;
SELECT * FROM orders ORDER BY order_id;
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY c.customer_id;
```
Expected seeded row counts: 4 customers and 6 orders.

## D. Submit
1. Open the public GitHub repository page.
2. Copy the repository URL from the browser address bar.
3. Return to RabTech Academy → Task 02 → **Submit deliverable**.
4. Paste the repository URL and submit.
5. Confirm the task status changes in the dashboard.

## E. What to say if asked to explain the work
“I modelled customers and orders as related entities. A customer can have many orders, while every order must reference one existing customer. Primary keys protect identity, a foreign key prevents orphan orders, NOT NULL protects required fields, and CHECK constraints restrict order status and order amount. I added repeatable schema and seed scripts, then negative tests that deliberately try invalid inserts and pass only when PostgreSQL rejects them.”

## Checklist
- [ ] ER diagram included
- [ ] Five business rules mapped to constraints
- [ ] Migration script included
- [ ] Repeatable seed fixture included
- [ ] Negative SQL tests included
- [ ] SQL executed in PostgreSQL and all five tests passed
- [ ] Repository is public if required
- [ ] Public repository URL submitted to RabTech Academy
