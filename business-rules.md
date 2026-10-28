# Business Rules and Relational Model

## 1. Source-based scope
The uploaded `commerce-seed-data.sql` defines `customers` and `orders`. The schema and rules below are based on that file. The assignment dashboard mentions a narrative business brief, but no separate narrative brief was supplied; therefore, rules beyond the starter SQL are marked as decisions to confirm.

## 2. Entities and attributes

### Customer
- `customer_id`: integer, primary key
- `customer_name`: varchar(100), required
- `city`: varchar(80), required
- `joined_on`: date, required

### Order
- `order_id`: integer, primary key
- `customer_id`: integer, required foreign key to `customers.customer_id`
- `ordered_on`: date, required
- `order_status`: varchar(20), required; allowed values are `PLACED`, `PAID`, `CANCELLED`
- `amount_inr`: numeric(10,2), required; must be greater than or equal to zero

## 3. Five non-negotiable business rules

| ID | Rule | Executable enforcement |
|---|---|---|
| BR-01 | Every customer has a unique, non-null customer ID. | `PRIMARY KEY (customer_id)` |
| BR-02 | A customer record must have a name, city, and join date. | `NOT NULL` on `customer_name`, `city`, `joined_on` |
| BR-03 | Every order has a unique, non-null order ID and must reference an existing customer. | `PRIMARY KEY (order_id)`, `FOREIGN KEY (customer_id)` |
| BR-04 | Every order must have a date and a status from `PLACED`, `PAID`, or `CANCELLED`. | `NOT NULL` plus `CHECK` on `order_status` |
| BR-05 | An order amount is required and cannot be negative. | `NOT NULL` plus `CHECK (amount_inr >= 0)` |

## 4. States
The source defines these order states:
- `PLACED`
- `PAID`
- `CANCELLED`

The source does **not** define permitted transitions between states, so no transition trigger or transaction workflow is invented here.

## 5. Cardinality and participation
- Customer to Order: **one-to-many (1:N)**.
- One customer may have zero, one, or many orders.
- Every order must belong to exactly one existing customer because `orders.customer_id` is `NOT NULL` and a foreign key.

## 6. Retention and deletion policy
The source file does not specify how long customer or order data must be retained, whether customer deletion should be allowed, or whether orders should be archived. These are unresolved business requirements. The schema uses the default restrictive foreign-key behavior: deleting a customer who still has orders is rejected. Confirm retention duration, legal requirements, and archival/deletion rules with the business owner before production use.

## 7. Constraint mapping
- Primary keys enforce entity identity and uniqueness.
- `NOT NULL` enforces required attributes.
- Foreign key prevents orphan orders.
- `CHECK` enforces the allowed status vocabulary and non-negative amount.
- No transaction boundary is needed for a single insert to enforce these local rules. If a future business operation updates multiple rows as one logical action, wrap those statements in a transaction so they commit or roll back together.
