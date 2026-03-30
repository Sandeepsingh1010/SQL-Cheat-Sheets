# Common Errors & Fixes

## SQL Errors

### ORA-00923: FROM keyword not found
**Problem:** Missing FROM in SELECT
```sql
-- ✗ WRONG
SELECT first_name WHERE salary > 5000;

-- ✓ RIGHT
SELECT first_name FROM employees WHERE salary > 5000;
```

### ORA-00904: Column not found
**Problem:** Misspelled column or table name
```sql
-- ✗ WRONG
SELECT first_name, salary FROM employees WHERE salery > 5000;

-- ✓ RIGHT
SELECT first_name, salary FROM employees WHERE salary > 5000;
```

### ORA-00913: Too many values
**Problem:** Wrong column count in INSERT
```sql
-- ✗ WRONG
INSERT INTO employees VALUES (100, 'John');  -- Needs all columns

-- ✓ RIGHT
INSERT INTO employees (employee_id, first_name) VALUES (100, 'John');
```

### ORA-01722: Invalid number
**Problem:** Text where number expected
```sql
-- ✗ WRONG
SELECT * FROM employees WHERE salary = 'five thousand';

-- ✓ RIGHT
SELECT * FROM employees WHERE salary = 5000;
```

### ORA-02291: Integrity constraint violated
**Problem:** Foreign key doesn't exist
```sql
-- ✗ WRONG
INSERT INTO employees (dept_id) VALUES (999);  -- No department 999

-- ✓ RIGHT
-- First ensure department exists
INSERT INTO employees (dept_id) VALUES (10);
```

## PL/SQL Errors

### PLS-00103: Encountered symbol
**Problem:** Missing semicolon or syntax error
```sql
-- ✗ WRONG
DECLARE v_name VARCHAR2(50)  -- Missing semicolon
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_name);

-- ✓ RIGHT
DECLARE
    v_name VARCHAR2(50);
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_name);
```

### NO_DATA_FOUND
**Problem:** SELECT INTO finds no rows
```sql
-- ✗ WRONG - crashes if no row found
SELECT name INTO v_name FROM employees WHERE id = 999;

-- ✓ RIGHT
BEGIN
    SELECT name INTO v_name FROM employees WHERE id = 999;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        v_name := 'Not Found';
END;
```

### TOO_MANY_ROWS
**Problem:** SELECT INTO returns multiple rows
```sql
-- ✗ WRONG - returns > 1 row
SELECT name INTO v_name FROM employees WHERE salary > 5000;

-- ✓ RIGHT
FOR rec IN (SELECT name FROM employees WHERE salary > 5000) LOOP
    DBMS_OUTPUT.PUT_LINE(rec.name);
END LOOP;
```

## Logical Errors

### Wrong Results with NULL
**Problem:** NULL comparisons always false
```sql
-- ✗ WRONG - returns no rows
SELECT * FROM employees WHERE commission = NULL;

-- ✓ RIGHT
SELECT * FROM employees WHERE commission IS NULL;
```

### GROUP BY Without Aggregate
**Problem:** Selecting non-grouped columns
```sql
-- ✗ WRONG - ORA-00979
SELECT first_name, COUNT(*) FROM employees GROUP BY department_id;

-- ✓ RIGHT
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id;
```

### TRUNCATE Without WHERE
**Problem:** Accidental deletion of all rows
```sql
-- ✗ WRONG - deletes entire table!
TRUNCATE TABLE employees;

-- ✓ RIGHT - delete specific rows
DELETE FROM employees WHERE hire_date < '01-JAN-2020';
```

## Prevention Checklist

- [ ] Test with actual data first
- [ ] Use meaningful variable/column names
- [ ] Check spelling carefully
- [ ] Verify data types match
- [ ] Test NULL values separately
- [ ] Review constraints before INSERT/UPDATE
- [ ] Use * sparingly (list columns explicitly)
- [ ] Comment complex logic
- [ ] Create test tables for risky operations
- [ ] Back up data before DELETE/TRUNCATE
