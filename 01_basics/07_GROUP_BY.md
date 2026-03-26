# GROUP BY Clause

## 📌 Concept
GROUP BY groups rows that have the same values in specified columns. It's used with aggregate functions to summarize data.

## 🧾 Syntax
```sql
SELECT column1, COUNT(*)
FROM table_name
GROUP BY column1;
```

## ✅ Example
```sql
-- Count employees per department
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id;

-- Average salary per department
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- Multiple columns
SELECT department_id, job_id, COUNT(*) AS count
FROM employees
GROUP BY department_id, job_id;

-- With ORDER BY
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY total_salary DESC;
```

## ⚠️ Common Mistakes
- Using columns in SELECT that aren't in GROUP BY (without aggregate)
- Forgetting GROUP BY when using aggregate functions
- Grouping by wrong columns
- Using WHERE instead of HAVING for aggregate filter

## 💡 Tips
- All non-aggregated columns in SELECT must be in GROUP BY
- Use aggregate functions: COUNT(), SUM(), AVG(), MIN(), MAX()
- Use HAVING to filter groups (not WHERE)
- Group by multiple columns for detailed summaries
