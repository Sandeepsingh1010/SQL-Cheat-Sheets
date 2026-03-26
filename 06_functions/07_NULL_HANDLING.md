# NULL Handling

## 📌 Concept
NULL represents missing or unknown data. Special functions handle NULL values since normal comparison operators don't work with NULL.

## 🧾 Key Points

- NULL is not the same as 0 or empty string ''
- NULL compared with anything (including NULL) returns NULL
- Aggregate functions ignore NULL (except COUNT(*))
- Special functions: NVL, COALESCE, NULLIF, IS NULL

## ✅ Examples

### IS NULL / IS NOT NULL

```sql
-- Check for NULL
SELECT * FROM employees
WHERE commission_pct IS NULL;

-- Check for NOT NULL
SELECT * FROM employees
WHERE commission_pct IS NOT NULL;

-- Multiple NULL checks
SELECT *
FROM employees
WHERE commission_pct IS NULL
  OR manager_id IS NULL;
```

### NVL (Null Value Replacement)

```sql
-- Replace NULL with default
SELECT
    first_name,
    NVL(commission_pct, 0) AS commission
FROM employees;

-- NVL in calculations
SELECT
    first_name,
    salary,
    salary + NVL(commission_pct, 0) AS total_compensation
FROM employees;

-- NVL with different types
SELECT
    first_name,
    NVL(middle_name, 'No Middle Name') AS middle
FROM employees;

-- Nested NVL
SELECT
    first_name,
    NVL(manager_id, NVL(director_id, 999)) AS supervisor_id
FROM employees;
```

### COALESCE (Multiple Null Checks)

```sql
-- Check multiple columns, return first non-NULL
SELECT
    COALESCE(commission_pct, bonus_pct, 0) AS incentive
FROM employees;

-- In concatenation
SELECT
    first_name || ' ' ||
    COALESCE(middle_name, '') || ' ' ||
    last_name AS full_name
FROM employees;

-- Find first available contact method
SELECT
    COALESCE(phone, cell_phone, email, 'No Contact') AS contact
FROM employees;
```

### NULLIF (Return NULL if Values Match)

```sql
-- Return NULL if values equal
SELECT
    employee_id,
    salary,
    commission_pct,
    NULLIF(commission_pct, 0) AS actual_commission  -- NULL if 0
FROM employees;

-- Avoid division by zero
SELECT
    employee_id,
    sales,
    quota,
    sales / NULLIF(quota, 0) AS sales_to_quota_ratio  -- NULL if quota=0
FROM sales_reps;
```

### NULL in Arithmetic

```sql
-- Any NULL in arithmetic = NULL
SELECT
    first_name,
    salary + commission_pct AS total  -- NULL if commission_pct is NULL
FROM employees;

-- Use NVL to prevent NULL propagation
SELECT
    first_name,
    salary + NVL(commission_pct, 0) AS total
FROM employees;
```

### NULL in Comparisons

```sql
-- ✗ WRONG - doesn't find NULL values
SELECT * FROM employees WHERE salary = NULL;      -- Returns 0 rows

-- ✓ RIGHT
SELECT * FROM employees WHERE salary IS NULL;     -- Finds NULL values

-- ✗ WRONG
SELECT * FROM employees WHERE salary != 5000;     -- Doesn't include NULL

-- ✓ RIGHT
SELECT * FROM employees
WHERE salary != 5000 OR salary IS NULL;
```

### NULL in Aggregate Functions

```sql
-- AVG ignores NULL
SELECT AVG(commission_pct) FROM employees;        -- Excludes NULLs

-- SUM ignores NULL
SELECT SUM(bonus) FROM employees;                 -- Excludes NULLs

-- COUNT(*) includes NULL rows
SELECT COUNT(*) FROM employees;

-- COUNT(column) excludes NULL
SELECT COUNT(commission_pct) FROM employees;

-- Handle NULL in aggregates
SELECT
    COUNT(*) AS total_rows,
    COUNT(commission_pct) AS non_null_commission,
    AVG(NVL(commission_pct, 0)) AS avg_with_null_as_zero
FROM employees;
```

### NULL in CASE Statements

```sql
-- CASE with NULL checks
SELECT
    first_name,
    CASE
        WHEN commission_pct IS NULL THEN 'No Commission'
        WHEN commission_pct = 0 THEN 'Zero Commission'
        ELSE 'Earns Commission'
    END AS commission_status
FROM employees;
```

### NULL in ORDER BY

```sql
-- NULL values in sorting
SELECT * FROM employees
ORDER BY commission_pct;                          -- NULL first (default)

SELECT * FROM employees
ORDER BY commission_pct NULLS LAST;              -- NULL at end

SELECT * FROM employees
ORDER BY commission_pct DESC NULLS FIRST;        -- NULL at beginning
```

## ⚠️ Common Mistakes

- Using = to check NULL (use IS NULL)
- Forgetting NULL propagates in arithmetic
- Not handling NULL in joins (matches NULL but may not work as expected)
- Aggregate functions behavior with NULL (skip NULL, don't count as 0)
- COALESCE vs NVL confusion (COALESCE more flexible)

## 💡 Tips

- Always use IS NULL and IS NOT NULL for NULL checks
- Use NVL for simple NULL replacements (2 arguments)
- Use COALESCE for multiple possible NULL columns (many arguments)
- NULL is "unknown" conceptually - treat it as such
- Be explicit about NULL handling in reports
- Test queries with NULL and non-NULL data
- Remember: NULL != NULL (NULL = NULL is NULL, not true)
