# JOIN Types

## 📌 Concept
JOINs combine rows from two or more tables. Understand all join types for effective data retrieval from normalized databases.

## 🧾 Visual Reference

```
INNER JOIN: Intersecting data only (∩)
LEFT OUTER: All left + matching right
RIGHT OUTER: All right + matching left
FULL OUTER: All data from both tables
CROSS JOIN: Every combination
```

## ✅ Examples

### INNER JOIN

```sql
-- Only matching records from both tables
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- Multiple INNER JOINs
SELECT
    e.first_name,
    d.department_name,
    j.job_title,
    e.salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE e.salary > 5000;
```

### LEFT OUTER JOIN

```sql
-- All from left table, matching from right
SELECT
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT OUTER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- Find departments with no employees
SELECT d.department_id, d.department_name
FROM departments d
LEFT OUTER JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;
```

### RIGHT OUTER JOIN

```sql
-- All from right table, matching from left
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM employees e
RIGHT OUTER JOIN departments d ON e.department_id = d.department_id;
```

### FULL OUTER JOIN

```sql
-- All data from both tables
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.department_id
ORDER BY e.employee_id;

-- Find unmatched records (data quality check)
SELECT
    e.employee_id,
    e.first_name,
    d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IS NULL OR d.department_id IS NULL;
```

### CROSS JOIN

```sql
-- Cartesian product - every combination
SELECT
    e.employee_id,
    e.first_name,
    j.job_id,
    j.job_title
FROM employees e
CROSS JOIN jobs j;

-- Practical: All possible shift assignments
SELECT
    e.employee_id,
    e.first_name,
    sb.shift_id,
    sb.shift_name
FROM employees e
CROSS JOIN shift_blocks sb
WHERE sb.start_date = TRUNC(SYSDATE);
```

### Self Join

```sql
-- Join table to itself - useful for hierarchies
SELECT
    e.employee_id AS employee_id,
    e.first_name AS employee_name,
    m.employee_id AS manager_id,
    m.first_name AS manager_name
FROM employees e
LEFT OUTER JOIN employees m ON e.manager_id = m.employee_id;

-- Org hierarchy depth
SELECT
    e1.first_name AS level_1_manager,
    e2.first_name AS level_2_manager,
    e3.first_name AS level_3_employee
FROM employees e1
INNER JOIN employees e2 ON e1.employee_id = e2.manager_id
INNER JOIN employees e3 ON e2.employee_id = e3.manager_id;
```

## ⚠️ Common Mistakes

- Forgetting ON clause (results in CROSS JOIN)
- Using WHERE in LEFT JOIN (filters out left table rows)
  ```sql
  -- ✗ WRONG - filters departments before join
  SELECT d.*, e.*
  FROM departments d
  LEFT OUTER JOIN employees e ON d.department_id = e.department_id
  WHERE e.salary > 5000;  -- Removes departments with no high earners

  -- ✓ RIGHT
  SELECT d.*, e.*
  FROM departments d
  LEFT OUTER JOIN employees e ON e.department_id = d.department_id
    AND e.salary > 5000;
  ```

- Wrong join condition (different columns)
- Not using table aliases with multiple tables
- Unclear which table is "left" and "right"

## 💡 Tips

- Always use aliases (e for employees, d for departments)
- INNER JOIN - use when want only matching data
- LEFT JOIN - use to find non-matching left table records
- RIGHT JOIN - less common, rewrite as LEFT on other table
- FULL JOIN - see unmatched data (rare in practice)
- Multiple JOINs evaluate left-to-right
- Performance: Join on indexed columns (PK/FK)
- Test JOIN output to verify you get expected row count
- Self-joins useful for hierarchical data
