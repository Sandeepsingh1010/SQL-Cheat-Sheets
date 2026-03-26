# DISTINCT Keyword

## 📌 Concept
DISTINCT removes duplicate rows from query results, showing only unique values.

## 🧾 Syntax
```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

## ✅ Example
```sql
-- Find all unique departments
SELECT DISTINCT department_id
FROM employees;

-- Find unique combinations
SELECT DISTINCT department_id, job_id
FROM employees;

-- Find unique first names (without duplicates)
SELECT DISTINCT first_name
FROM employees
ORDER BY first_name;

-- Count unique departments
SELECT COUNT(DISTINCT department_id)
FROM employees;
```

## ⚠️ Common Mistakes
- Using DISTINCT on all columns (defeats the purpose of uniqueness)
- Not considering NULL values (NULL is distinct from another NULL)
- Using DISTINCT with aggregate functions incorrectly
- Forgetting DISTINCT can result in massive result sets

## 💡 Tips
- DISTINCT applies to all columns listed, not just one
- DISTINCT can impact performance on large datasets
- Use with ORDER BY to make results more readable
- NULL values are treated as a single distinct value
