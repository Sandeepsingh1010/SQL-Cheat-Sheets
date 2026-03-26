# Aggregate Functions

## 📌 Concept
Aggregate functions compute a single result from multiple rows. Used with GROUP BY to summarize data by categories.

## 🧾 Common Aggregate Functions

| Function | Purpose |
|----------|---------|
| COUNT | Count rows or non-NULL values |
| SUM | Total of numeric column |
| AVG | Average of numeric column |
| MIN | Minimum value |
| MAX | Maximum value |
| LISTAGG | Concatenate string values |
| STDDEV | Standard deviation |
| VARIANCE | Statistical variance |

## ✅ Examples

### COUNT
```sql
-- Count all rows
SELECT COUNT(*) AS total_employees
FROM employees;

-- Count non-NULL values only
SELECT COUNT(commission_pct) AS employees_with_commission
FROM employees;

-- Count distinct values
SELECT COUNT(DISTINCT department_id) AS num_departments
FROM employees;

-- Conditional count
SELECT COUNT(CASE WHEN salary > 5000 THEN 1 END) AS high_earners
FROM employees;
```

### SUM
```sql
-- Total salary
SELECT SUM(salary) AS total_payroll
FROM employees;

-- Sum by department
SELECT department_id, SUM(salary) AS dept_payroll
FROM employees
GROUP BY department_id;

-- Sum with WHERE
SELECT SUM(salary) AS high_earner_total
FROM employees
WHERE salary > 5000;
```

### AVG
```sql
-- Average salary
SELECT AVG(salary) AS avg_salary
FROM employees;

-- Avoid NULL: AVG ignores NULL
SELECT AVG(commission_pct) AS avg_commission
FROM employees;

-- Average by category
SELECT
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;
```

### MIN / MAX
```sql
-- Minimum and maximum
SELECT
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary
FROM employees;

-- Min/max by category
SELECT
    department_id,
    MIN(hire_date) AS earliest_hire,
    MAX(hire_date) AS latest_hire
FROM employees
GROUP BY department_id;
```

### LISTAGG
```sql
-- Concatenate strings (comma-separated)
SELECT
    department_id,
    LISTAGG(first_name, ', ') WITHIN GROUP (ORDER BY first_name) AS employees
FROM employees
GROUP BY department_id;

-- Custom delimiter
SELECT
    department_id,
    LISTAGG(first_name, ' | ') WITHIN GROUP (ORDER BY first_name) AS employee_list
FROM employees
GROUP BY department_id;
```

### Multiple Aggregates
```sql
SELECT
    department_id,
    COUNT(*) AS emp_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    STDDEV(salary) AS salary_stddev
FROM employees
GROUP BY department_id
ORDER BY dept_id;
```

### HAVING with Aggregates
```sql
-- Filter aggregates
SELECT
    department_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 5000;

-- Multiple having conditions
SELECT
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5
   AND AVG(salary) > 4000;
```

### Aggregate with CASE
```sql
-- Conditional aggregates
SELECT
    SUM(CASE WHEN salary > 5000 THEN salary ELSE 0 END) AS high_earner_total,
    COUNT(CASE WHEN salary > 5000 THEN 1 END) AS high_earners,
    SUM(CASE WHEN salary <= 5000 THEN salary ELSE 0 END) AS low_earner_total
FROM employees;
```

## ⚠️ Common Mistakes

- SELECT non-aggregate column without GROUP BY
  ```sql
  -- ✗ WRONG
  SELECT first_name, COUNT(*)
  FROM employees;

  -- ✓ RIGHT
  SELECT department_id, COUNT(*)
  FROM employees
  GROUP BY department_id;
  ```

- Using WHERE instead of HAVING for aggregates
- Forgetting NULL doesn't count in COUNT (except COUNT(*))
- Using aggregates in WHERE (use HAVING instead)

## 💡 Tips

- COUNT(*) counts all rows including NULL
- COUNT(column) counts non-NULL values
- AVG ignores NULL values
- SUM of NULLs = NULL (use COALESCE if needed)
- Use DISTINCT in aggregates: COUNT(DISTINCT dept_id)
- Combine multiple aggregates for detailed reporting
- Order GROUP BY results with ORDER BY for readability
