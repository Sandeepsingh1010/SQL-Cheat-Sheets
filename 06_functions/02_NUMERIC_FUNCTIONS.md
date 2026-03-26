# Numeric Functions

## 📌 Concept
Numeric functions perform mathematical operations and rounding on numbers in Oracle SQL.

## 🧾 Syntax and Examples

### ROUND
```sql
-- Round to specified decimal places
SELECT ROUND(123.456, 2) FROM dual;    -- 123.46
SELECT ROUND(123.456, 0) FROM dual;    -- 123
SELECT ROUND(123.456, -1) FROM dual;   -- 120
```

### TRUNC
```sql
-- Truncate (remove) decimal places
SELECT TRUNC(123.456, 2) FROM dual;    -- 123.45
SELECT TRUNC(123.456) FROM dual;       -- 123
```

### CEIL / FLOOR
```sql
-- Round up/down to nearest integer
SELECT CEIL(123.1) FROM dual;          -- 124
SELECT FLOOR(123.9) FROM dual;         -- 123
```

### ABS
```sql
-- Absolute value
SELECT ABS(-123.45) FROM dual;         -- 123.45
```

### MOD
```sql
-- Remainder (modulo)
SELECT MOD(10, 3) FROM dual;           -- 1
```

### POWER / SQRT
```sql
-- Power and square root
SELECT POWER(2, 3) FROM dual;          -- 8
SELECT SQRT(16) FROM dual;             -- 4
```

## ✅ Practical Example
```sql
SELECT
    employee_id,
    salary,
    ROUND(salary * 1.1, 2) AS salary_plus_10_percent,
    MOD(employee_id, 2) AS is_even
FROM employees;
```

## 💡 Tips
- ROUND: negative places round left of decimal
- TRUNC: simply removes decimals (no rounding)
- Use ROUND for display, TRUNC for calculation
- MOD useful for odd/even detection
