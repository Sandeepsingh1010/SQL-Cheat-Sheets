# CREATE TABLE Statement

## 📌 Concept
CREATE TABLE defines a new table structure with columns, data types, and constraints.

## 🧾 Syntax
```sql
CREATE TABLE table_name (
    column1 datatype [constraint],
    column2 datatype [constraint],
    PRIMARY KEY (column1)
);
```

## ✅ Example
```sql
-- Simple table
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    salary NUMBER(10,2),
    hire_date DATE
);

-- Table with constraints
CREATE TABLE departments (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL,
    manager_id NUMBER UNIQUE,
    budget NUMBER(15,2),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Table with default values
CREATE TABLE orders (
    order_id NUMBER PRIMARY KEY,
    order_date DATE DEFAULT SYSDATE,
    customer_id NUMBER NOT NULL,
    status VARCHAR2(20) DEFAULT 'PENDING',
    amount NUMBER(10,2)
);
```

## ⚠️ Common Mistakes
- Using incorrect data types for your data
- Forgetting PRIMARY KEY constraint
- Not defining NOT NULL where required
- Using VARCHAR instead of VARCHAR2 in Oracle

## 💡 Tips
- Oracle uses VARCHAR2, not VARCHAR
- NUMBER(p,s) where p=precision, s=scale
- Use NOT NULL for mandatory columns
- Define constraints inline for clarity
- Use SYSDATE for current date/time
