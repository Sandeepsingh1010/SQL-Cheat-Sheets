# CROSS JOIN

## 📌 Concept
CROSS JOIN produces a Cartesian product - every row from table1 paired with every row from table2. Results can be very large!

## 🧾 Syntax
```sql
SELECT columns
FROM table1
CROSS JOIN table2;

-- Alternative comma syntax
SELECT columns
FROM table1, table2;
```

## ✅ Example
```sql
-- Simple CROSS JOIN
SELECT e.first_name, d.department_name
FROM employees e
CROSS JOIN departments d;

-- Generate all possible combinations
SELECT DISTINCT d.department_name, j.job_title
FROM departments d
CROSS JOIN jobs j;

-- Useful for generating date ranges
SELECT DATE '2024-01-01' + ROWNUM - 1 AS date_value
FROM (SELECT * FROM employees CROSS JOIN departments)
WHERE ROWNUM <= 365;

-- Create a matrix/grid
SELECT e.first_name, d.department_name
FROM employees e
CROSS JOIN departments d
WHERE ROWNUM <= 100;
```

## ⚠️ Common Mistakes
- Not realizing the result size (n x m rows)
- Using CROSS JOIN unintentionally with comma syntax
- Creating millions of rows by accident
- Missing WHERE clause constraints

## 💡 Tips
- Produces n × m rows (can be huge!)
- Use WHERE to limit result set
- Useful for generating combinations
- Avoid unless specifically needed
- Always limit results to avoid system overload
