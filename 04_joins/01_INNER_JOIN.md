# INNER JOIN

## 📌 Concept
INNER JOIN returns rows where there's a match in both tables. Only matching records are included.

## 🧾 Syntax
```sql
SELECT columns
FROM table1
INNER JOIN table2
ON table1.column = table2.column;
```

## ✅ Example
```sql
-- Simple INNER JOIN
SELECT e.first_name, e.salary, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- Join multiple tables
SELECT e.first_name, d.department_name, j.job_title
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id;

-- With WHERE clause
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'IT'
ORDER BY e.first_name;

-- Using comma syntax (older Oracle style)
SELECT e.first_name, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;
```

## ⚠️ Common Mistakes
- Forgetting the ON condition
- Using wrong join column
- Mixing comma syntax with INNER JOIN
- Assuming all rows are included

## 💡 Tips
- Use INNER JOIN keyword for clarity (not comma syntax)
- Use table aliases (e, d) for readability
- Always specify join columns explicitly
- INNER JOIN shows only matching records
