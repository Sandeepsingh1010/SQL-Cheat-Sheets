# EXISTS, IN, ANY, ALL Operators

## 📌 Concept
These comparison operators work with subqueries to filter results based on complex conditions across multiple tables.

## 🧾 Comparison

| Operator | Use Case | Null Handling | Performance |
|----------|----------|---------------|-------------|
| IN | Value in list | NULL makes row unknown | Good for small sets |
| NOT IN | Value not in list | NULL problems | Avoid with NULL |
| EXISTS | Records exist (any row) | Handles NULL fine | Best for large sets |
| NOT EXISTS | No matching records | Handles NULL fine | Best for large sets |
| ANY | Compare to any in list | Handles NULL | Use with caution |
| ALL | Compare to all in list | Handles NULL | Use with caution |

## ✅ Examples

### IN Operator

```sql
-- Simple list
SELECT * FROM employees
WHERE department_id IN (10, 20, 30);

-- Subquery with IN
SELECT * FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments
    WHERE location_id = 1700
);

-- Multiple columns
SELECT * FROM orders
WHERE (customer_id, product_id) IN (
    SELECT customer_id, product_id
    FROM customer_preferences
);
```

### NOT IN

```sql
-- Simple list
SELECT * FROM employees
WHERE department_id NOT IN (10, 20);

-- Subquery (be careful with NULL!)
SELECT * FROM employees
WHERE employee_id NOT IN (
    SELECT manager_id FROM employees
    WHERE manager_id IS NOT NULL  -- IMPORTANT: exclude NULL
);

-- Problem with NULL
SELECT * FROM employees
WHERE employee_id NOT IN (SELECT manager_id FROM employees);
-- Returns NOTHING if manager_id contains NULL!
```

### EXISTS

```sql
-- Check if employees exist in department
SELECT d.department_id, d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- Better for large datasets than IN
SELECT DISTINCT d.department_id, d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
      AND e.salary > 5000
);

-- EXISTS uses minimal data (just checks existence)
SELECT * FROM employees e
WHERE EXISTS (
    SELECT 1  -- Could be anything - just checks if row exists
    FROM assignments a
    WHERE a.employee_id = e.employee_id
);
```

### NOT EXISTS

```sql
-- No matching records
SELECT d.department_id, d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

-- Employees with no assignments
SELECT e.employee_id, e.first_name
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM assignments a
    WHERE a.employee_id = e.employee_id
);

-- Complex NOT EXISTS
SELECT *
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM projects p
    WHERE NOT EXISTS (
        SELECT 1
        FROM assignments a
        WHERE a.employee_id = e.employee_id
          AND a.project_id = p.project_id
    )
);
```

### ANY Operator

```sql
-- Salary greater than ANY (i.e., any manager's minimum)
SELECT * FROM employees
WHERE salary > ANY (
    SELECT salary FROM employees
    WHERE job_id = 'MANAGER'
);

-- Equal to any value in list
SELECT * FROM employees
WHERE salary = ANY (SELECT salary FROM employees WHERE department_id = 10);
-- Equivalent to: WHERE salary IN (SELECT ...)

-- Less than any
SELECT * FROM products
WHERE price < ANY (
    SELECT list_price FROM price_list
);
```

### ALL Operator

```sql
-- Salary greater than ALL (i.e., all employees in dept 10)
SELECT * FROM employees
WHERE salary > ALL (
    SELECT salary FROM employees
    WHERE department_id = 10
);

-- Not equal to all (exclude these values)
SELECT * FROM employees
WHERE salary <> ALL (
    SELECT salary FROM employees
    WHERE job_id = 'ADMIN'
);

-- Product price <= all prices in category
SELECT * FROM products p
WHERE price <= ALL (
    SELECT price FROM products
    WHERE category = p.category
);
```

## ⚠️ Common Mistakes

- NOT IN with NULL values
  ```sql
  -- ✗ WRONG - NO RESULTS if any manager_id is NULL
  WHERE employee_id NOT IN (SELECT manager_id FROM employees)

  -- ✓ RIGHT
  WHERE employee_id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL)
  ```

- Confusing ANY with ANY() aggregate function
- Using ALL when EXISTS would be clearer
- Performance: IN slower than EXISTS for large subqueries
- Forgetting colons with := in some contexts

## 💡 Tips

- **EXISTS**: Best for "is there at least one?" questions
- **IN**: Best for small fixed lists or explicit values
- **ANY**: Compare value to any in set (≥, >, <, ≤)
- **ALL**: Compare value to all in set (stricter condition)
- EXISTS is generally faster than IN on large datasets
- Always handle NULL explicitly with NOT IN
- Use SELECT 1 in EXISTS (don't need column data, just existence)
- Combine EXISTS/NOT EXISTS for set operations
