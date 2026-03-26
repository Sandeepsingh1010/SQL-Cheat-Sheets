# HAVING Clause

## 📌 Concept
HAVING filters groups created by GROUP BY, similar to WHERE but for aggregate functions.

## 🧾 Syntax
```sql
SELECT column1, COUNT(*)
FROM table_name
GROUP BY column1
HAVING COUNT(*) > value;
```

## ✅ Example
```sql
-- Find departments with more than 10 employees
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;

-- Find departments with average salary > 5000
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 5000;

-- Multiple conditions
SELECT department_id, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5 AND AVG(salary) > 4000;

-- With ORDER BY
SELECT job_id, COUNT(*) AS count
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 3
ORDER BY count DESC;
```

## ⚠️ Common Mistakes
- Using WHERE instead of HAVING for aggregate conditions
- Using column aliases in HAVING (may not work)
- Confusing HAVING with WHERE
- Forgetting GROUP BY when using HAVING

## 💡 Tips
- WHERE filters rows before grouping
- HAVING filters groups after aggregation
- Use functions in HAVING, not raw columns
- Always include GROUP BY with HAVING
