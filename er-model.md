# Conceptual ER Model

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : places
    CUSTOMERS {
        int customer_id PK
        varchar customer_name
        varchar city
        date joined_on
    }
    ORDERS {
        int order_id PK
        int customer_id FK
        date ordered_on
        varchar order_status
        numeric amount_inr
    }
```

## Reading the diagram
- `CUSTOMERS ||` means each order is associated with exactly one customer.
- `o{ ORDERS` means a customer can have zero or many orders.
- `customer_id` is the primary key in `customers` and a foreign key in `orders`.
