# WHERE Clause

## 📌 Concept
The WHERE clause filters rows based on specified conditions. It allows you to retrieve only the data that meets your criteria.

## 🧾 Syntax
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

## ✅ Example
```sql
-- Simple equality
SELECT first_name, salary
FROM employees
WHERE department_id = 10;

-- Comparison operators
SELECT first_name, salary
FROM employees
WHERE salary > 5000;

-- Text matching
SELECT first_name, last_name
FROM employees
WHERE last_name = 'Smith';

-- NULL check
SELECT first_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
```

## ⚠️ Common Mistakes
- Using `=` for NULL instead of `IS NULL`
- Forgetting quotes around text values
- Using numbers as strings without quotes
- Missing the WHERE clause when filtering is needed

## 💡 Tips
- Always use `IS NULL` or `IS NOT NULL` for NULL comparisons
- String comparisons are case-insensitive by default in Oracle
- Use comparison operators: `>`, `<`, `>=`, `<=`, `!=`, `<>`
