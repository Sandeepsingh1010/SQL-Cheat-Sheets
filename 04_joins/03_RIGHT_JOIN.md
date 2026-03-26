# RIGHT JOIN (RIGHT OUTER JOIN)

## 📌 Concept
RIGHT JOIN returns all rows from the right table and matching rows from the left table. Unmatched left rows show NULL.

## 🧾 Syntax
```sql
SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.column = table2.column;
```

## ✅ Example
```sql
-- Simple RIGHT JOIN
SELECT e.first_name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

-- All departments and their employees
SELECT d.department_name, e.first_name
FROM employees e
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY d.department_name;

-- Find departments with no employees
SELECT d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

-- RIGHT JOIN with WHERE
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS emp_count
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name;
```

## ⚠️ Common Mistakes
- Confusing RIGHT JOIN with LEFT JOIN
- Using RIGHT JOIN when reordering tables would be clearer
- Not checking for NULL in unmatched rows
- Forgetting all right table rows are included

## 💡 Tips
- RIGHT JOIN preserves all rows from right table
- Often clearer to swap tables and use LEFT JOIN
- Use when you need all rows from right table
- NULL appears for unmatched left table rows
