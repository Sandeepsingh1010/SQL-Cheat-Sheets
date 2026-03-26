# Single-Row Functions

## 📌 Concept
Single-row functions operate on one row at a time and return one result per input row. Includes string, numeric, and date manipulation.

## 🧾 Categories

| Type | Functions | Use Case |
|------|-----------|----------|
| String | SUBSTR, LENGTH, UPPER, LOWER, TRIM, REPLACE | Text manipulation |
| Numeric | ABS, ROUND, TRUNC, MOD, POWER, CEIL, FLOOR | Math operations |
| Date | SYSDATE, ADD_MONTHS, MONTHS_BETWEEN, EXTRACT | Date calculations |

## ✅ String Functions

### SUBSTR
```sql
-- Extract substring
SELECT SUBSTR('Hello World', 1, 5) AS result FROM dual;  -- 'Hello'
SELECT SUBSTR('Hello World', 7) AS result FROM dual;     -- 'World'
SELECT SUBSTR('Hello World', -5) AS result FROM dual;    -- 'World' (from end)

-- Get last letter
SELECT SUBSTR(first_name, -1) AS last_letter
FROM employees;
```

### LENGTH
```sql
SELECT first_name, LENGTH(first_name) AS name_length
FROM employees
WHERE LENGTH(first_name) > 10;
```

### UPPER / LOWER / INITCAP
```sql
SELECT
    UPPER(first_name) AS upper_name,
    LOWER(last_name) AS lower_name,
    INITCAP(first_name) AS proper_name
FROM employees;
```

### TRIM / LTRIM / RTRIM
```sql
SELECT TRIM('  spaces  ') AS trimmed FROM dual;      -- 'spaces'
SELECT LTRIM('xxxHelloxxx', 'x') FROM dual;          -- 'Helloxxx'
SELECT RTRIM('xxxHelloxxx', 'x') FROM dual;          -- 'xxxHello'
```

### REPLACE
```sql
SELECT REPLACE(email, '@example.com', '@newdomain.com')
FROM employees;

-- Replace all occurrences
SELECT REPLACE(description, 'old', 'new')
FROM products;
```

### INSTR (Find Position)
```sql
SELECT INSTR('Hello World', 'o') AS position FROM dual;  -- 5
SELECT INSTR(email, '@') AS at_position
FROM employees;
```

## ✅ Numeric Functions

### ABS (Absolute Value)
```sql
SELECT ABS(-50) AS absolute FROM dual;            -- 50
SELECT ABS(salary - 5000) AS difference
FROM employees;
```

### ROUND
```sql
SELECT ROUND(123.456, 2) FROM dual;      -- 123.46 (2 decimals)
SELECT ROUND(123.456, 0) FROM dual;      -- 123 (integer)
SELECT ROUND(1234.567, -1) FROM dual;    -- 1230 (to tens)
```

### TRUNC (Truncate/Cut)
```sql
SELECT TRUNC(123.456, 2) FROM dual;      -- 123.45
SELECT TRUNC(salary) FROM employees;     -- Remove decimals
```

### CEIL / FLOOR
```sql
SELECT CEIL(123.1) FROM dual;            -- 124
SELECT FLOOR(123.9) FROM dual;           -- 123
```

### MOD (Remainder)
```sql
SELECT MOD(10, 3) FROM dual;             -- 1
SELECT employee_id FROM employees
WHERE MOD(employee_id, 2) = 0;           -- Even IDs
```

### POWER / SQRT
```sql
SELECT POWER(2, 8) FROM dual;            -- 256
SELECT SQRT(16) FROM dual;               -- 4
```

## ✅ Date Functions

### SYSDATE / SYSTIMESTAMP
```sql
SELECT SYSDATE FROM dual;                        -- Current date
SELECT SYSTIMESTAMP FROM dual;                   -- With milliseconds

-- Use in calculations
SELECT SYSDATE, SYSDATE + 1 AS tomorrow
FROM dual;
```

### ADD_MONTHS
```sql
SELECT ADD_MONTHS(SYSDATE, 3) AS in_3_months FROM dual;
SELECT ADD_MONTHS(hire_date, 1) AS review_date
FROM employees;
```

### MONTHS_BETWEEN
```sql
SELECT MONTHS_BETWEEN(SYSDATE, '01-JAN-2020') AS months FROM dual;
SELECT
    first_name,
    ROUND(MONTHS_BETWEEN(SYSDATE, hire_date) / 12, 1) AS years_employed
FROM employees;
```

### EXTRACT
```sql
SELECT
    EXTRACT(YEAR FROM SYSDATE) AS year,
    EXTRACT(MONTH FROM SYSDATE) AS month,
    EXTRACT(DAY FROM SYSDATE) AS day
FROM dual;

-- Find employees hired in specific year
SELECT * FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 2020;
```

### TRUNC (for dates)
```sql
SELECT TRUNC(SYSDATE) FROM dual;                 -- Midnight today
SELECT TRUNC(SYSDATE, 'MM') FROM dual;          -- First of month
SELECT TRUNC(SYSDATE, 'YYYY') FROM dual;        -- Jan 1 of year
```

## ⚠️ Common Mistakes

- SUBSTR starting position is 1-based (not 0)
- LENGTH with NULL values (returns NULL)
- ROUND vs TRUNC confusion (TRUNC doesn't round)
- Date arithmetic with strings instead of DATE type
- INSTR not finding case-sensitive matches

## 💡 Tips

- Always use UPPER/LOWER for case-insensitive comparisons
- TRIM whitespace before comparisons
- SUBSTR with negative index counts from end
- Use TRUNC(date, 'MM') for date bucketing
- Combine string functions for complex transformations
