# Constraints

## 📌 Concept
Constraints enforce rules on table data to maintain data integrity. They ensure only valid data is inserted or updated.

## 🧾 Types of Constraints

| Constraint | Purpose |
|-----------|---------|
| PRIMARY KEY | Uniquely identifies each row |
| FOREIGN KEY | Links to primary key in another table |
| UNIQUE | Ensures column values are unique |
| NOT NULL | Requires a value (no empty cells) |
| CHECK | Ensures values meet a condition |
| DEFAULT | Provides default value if not specified |

## ✅ Examples

### PRIMARY KEY
```sql
-- Single-column primary key
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    salary NUMBER
);

-- Composite primary key (multiple columns)
CREATE TABLE orders (
    order_id NUMBER,
    line_item NUMBER,
    product_id NUMBER,
    quantity NUMBER,
    PRIMARY KEY (order_id, line_item)
);

-- Constraint with name
CREATE TABLE departments (
    department_id NUMBER,
    department_name VARCHAR2(50),
    CONSTRAINT pk_departments PRIMARY KEY (department_id)
);
```

### FOREIGN KEY
```sql
-- Basic FOREIGN KEY
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    department_id NUMBER,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Named constraint with CASCADE DELETE
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE
);
```

### UNIQUE Constraint
```sql
-- Single unique column
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) UNIQUE,
    email VARCHAR2(100)
);

-- Unique constraint with name
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    ssn VARCHAR2(11),
    CONSTRAINT uk_employees_ssn UNIQUE (ssn)
);

-- Composite unique (multiple columns together unique)
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    order_number VARCHAR2(20),
    order_year NUMBER,
    CONSTRAINT uk_order_number UNIQUE (order_number, order_year)
);
```

### NOT NULL Constraint
```sql
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    salary NUMBER NOT NULL,
    email VARCHAR2(100)  -- Can be NULL
);
```

### CHECK Constraint
```sql
-- Simple value check
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    salary NUMBER CHECK (salary > 0),
    age NUMBER CHECK (age >= 18),
    status VARCHAR2(20) CHECK (status IN ('ACTIVE', 'INACTIVE', 'RETIRED'))
);

-- Named CHECK constraint with complex condition
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    CONSTRAINT chk_dates CHECK (ship_date >= order_date)
);
```

### DEFAULT Value
```sql
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    hire_date DATE DEFAULT SYSDATE,
    status VARCHAR2(20) DEFAULT 'ACTIVE',
    creation_date TIMESTAMP DEFAULT SYSTIMESTAMP
);
```

### Multiple Constraints
```sql
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL UNIQUE,
    price NUMBER NOT NULL CHECK (price > 0),
    category VARCHAR2(50),
    stock_quantity NUMBER DEFAULT 0,
    created_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category)
        REFERENCES product_categories(category_id)
);
```

## ⚠️ Common Mistakes

- PRIMARY KEY column containing NULL
- UNIQUE constraint allowing duplicates (should be UNIQUE NOT NULL)
- FOREIGN KEY referencing non-existent primary key
- CHECK constraint allowing invalid values
- Not naming constraints (makes ALTER difficult)
- Forgetting CASCADE on FOREIGN KEY when needed
- NOT NULL on column that should allow NULL

## 💡 Tips

- Always name constraints for easier maintenance
- Use PRIMARY KEY on all tables
- Use FOREIGN KEY to maintain referential integrity
- CHECK constraints fail silently on invalid inserts
- Use UNIQUE + NOT NULL for alternative keys
- DEFAULT values reduce NULL handling in application code
- Naming convention: pk_table, fk_table_ref, uk_table_col, chk_table_rule
