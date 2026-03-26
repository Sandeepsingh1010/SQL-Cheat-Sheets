# LEFT JOIN (LEFT OUTER JOIN)

## 📌 Concept
LEFT JOIN returns all rows from the left table and matching rows from the right table. Unmatched right rows show NULL.

## 🧾 Syntax
```sql
SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;
```

## ✅ Example
```sql
-- Simple LEFT JOIN
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

-- All employees and their department (if assigned)
SELECT e.first_name, e.salary, d.department_name
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.first_name;

-- Find employees without department
SELECT e.first_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- Multiple LEFT JOINs
SELECT e.first_name, d.department_name, l.location_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations l ON d.location_id = l.location_id;
```

## ⚠️ Common Mistakes
- Forgetting it includes all left table rows
- Not checking for NULL in unmatched rows
- Assuming LEFT JOIN is the same as INNER JOIN
- Wrong join column order

## 💡 Tips
- LEFT JOIN preserves all rows from left table
- Right table unmatched rows show NULL
- Useful for finding missing/unmatched data
- Can chain multiple LEFT JOINs
