# FULL JOIN (FULL OUTER JOIN)

## 📌 Concept
FULL JOIN returns all rows from both tables. If there's no match, NULL appears for unmatched side.

## 🧾 Syntax
```sql
SELECT columns
FROM table1
FULL JOIN table2
ON table1.column = table2.column;
```

## ✅ Example
```sql
-- Simple FULL JOIN
SELECT e.first_name, d.department_name
FROM employees e
FULL JOIN departments d
ON e.department_id = d.department_id;

-- All employees and departments
SELECT COALESCE(e.first_name, 'No employee') AS employee,
       COALESCE(d.department_name, 'No department') AS department
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id = d.department_id
ORDER BY d.department_name;

-- Find unmatched records
SELECT e.first_name, d.department_name
FROM employees e
FULL JOIN departments d
ON e.department_id = d.department_id
WHERE e.employee_id IS NULL OR d.department_id IS NULL;

-- FULL JOIN with LEFT + RIGHT UNION (Oracle alternative)
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
UNION
SELECT e.first_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;
```

## ⚠️ Common Mistakes
- Using UNION syntax unnecessarily
- Not handling NULL values properly
- Forgetting FULL JOIN shows all rows from both tables
- Oracle may not have FULL OUTER JOIN (use UNION workaround)

## 💡 Tips
- FULL JOIN includes unmatched rows from both tables
- Use COALESCE to handle NULL values
- Oracle may require UNION of LEFT and RIGHT JOINs
- Always include WHERE IS NULL to find unmatched records
