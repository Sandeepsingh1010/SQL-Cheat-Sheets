# Aggregate Functions

## 📌 Concept
Aggregate functions summarize values across multiple rows, used with GROUP BY or for overall calculations.

## 🧾 Syntax and Examples

### COUNT
```sql
-- Count rows
SELECT COUNT(*) FROM employees;                    -- Total employees
SELECT COUNT(commission_pct) FROM employees;       -- Non-NULL commission_pcts
SELECT COUNT(DISTINCT department_id) FROM employees;  -- Unique departments
```

### SUM
```sql
-- Sum values
SELECT SUM(salary) FROM employees;
SELECT SUM(salary) FROM employees WHERE department_id = 10;
```

### AVG
```sql
-- Average value
SELECT AVG(salary) FROM employees;
SELECT AVG(salary) FROM employees WHERE hire_date > SYSDATE - 365;
```

### MIN / MAX
```sql
-- Minimum and maximum values
SELECT MIN(salary), MAX(salary) FROM employees;
SELECT MIN(hire_date), MAX(hire_date) FROM employees;
```

### GROUP_CONCAT (with GROUP BY)
```sql
-- Multiple aggregates by group
SELECT
    department_id,
    COUNT(*) AS emp_count,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;
```

## ✅ Practical Example
```sql
SELECT
    department_id,
    COUNT(*) AS num_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 5000
ORDER BY total_salary DESC;
```

## ⚠️ Common Mistakes
- Using aggregate without GROUP BY
- Forgetting all non-aggregated columns in GROUP BY
- Using WHERE instead of HAVING for aggregate filters

## 💡 Tips
- COUNT(*) counts all rows including NULL
- COUNT(column) ignores NULL values
- Aggregates ignore NULL except COUNT(*)
- Use GROUP BY to aggregate by categories
- Use HAVING after GROUP BY to filter groups
