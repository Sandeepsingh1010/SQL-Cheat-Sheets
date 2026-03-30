# Sequences

## 📌 Concept
A sequence is a database object that generates unique sequential numbers. Commonly used for auto-incrementing primary keys.

## 🧾 Syntax
```sql
CREATE SEQUENCE sequence_name
    START WITH starting_value
    INCREMENT BY increment_value
    MAXVALUE max_value
    MINVALUE min_value
    CYCLE | NOCYCLE;

nextval(sequence_name)
currval(sequence_name)
```

## ✅ Examples

### Create Simple Sequence
```sql
-- Basic sequence
CREATE SEQUENCE emp_id_seq
    START WITH 1
    INCREMENT BY 1;

-- Sequence with specific range
CREATE SEQUENCE product_id_seq
    START WITH 1000
    INCREMENT BY 1
    MAXVALUE 9999
    NOCYCLE;

-- Sequence that cycles (restarts at min)
CREATE SEQUENCE transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 100000
    CYCLE;
```

### Use Sequence in INSERT
```sql
-- Insert with sequence
INSERT INTO employees (employee_id, first_name, salary)
VALUES (emp_id_seq.NEXTVAL, 'John Doe', 5000);

-- Multiple INSERTs with sequence
INSERT INTO employees (employee_id, first_name, salary)
SELECT emp_id_seq.NEXTVAL, temp_first_name, temp_salary
FROM temp_employees;
```

### Use Sequence in UPDATE
```sql
-- Update with current sequence value
UPDATE employees
SET employee_id = emp_id_seq.NEXTVAL
WHERE employee_id IS NULL;

-- Get current value without incrementing
SELECT emp_id_seq.CURRVAL FROM dual;
```

### Generate Sequence for Multiple Tables
```sql
-- Shared sequence for multiple tables
CREATE SEQUENCE global_id_seq
    START WITH 10000
    INCREMENT BY 1;

-- Use in multiple tables
INSERT INTO employees VALUES (global_id_seq.NEXTVAL, 'John', ...);
INSERT INTO customers VALUES (global_id_seq.NEXTVAL, 'ABC Corp', ...);
```

## ⚠️ Common Mistakes

- Gaps in sequence numbers (normal due to ROLLBACK)
- Using sequence value in WHERE without saving first
- Not creating sequence before using it
- MAXVALUE too small (causes error when exceeded)
- Unaware that NEXTVAL increments even on failed insert

## 💡 Tips

- Always save sequence value: `v_id := seq_name.NEXTVAL`
- NEXTVAL increments every time called (even if not used)
- Gaps are normal and expected
- Use START WITH to set next number
- DROP SEQUENCE seq_name to remove
- Sequences don't roll back (by design)
- NOCYCLE throws error at MAXVALUE
- Use consistent naming: _id_seq, _seq, etc.
