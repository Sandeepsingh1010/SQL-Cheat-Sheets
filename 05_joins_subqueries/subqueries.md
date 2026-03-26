# Subqueries

## 📌 Concept
A subquery (inner query) is a query nested inside another SQL statement. Used to solve complex problems in steps.

## 🧾 Types of Subqueries

| Type | Location | Rows Returned | Example Use |
|------|----------|---------------|-------------|
| Scalar | SELECT | Single value | Column in SELECT |
| Inline View | FROM | Multiple | FROM subquery |
| WHERE | WHERE | Multiple | Filter with IN, comparison |
| Correlated | WHERE | Multiple | References outer query |

## ✅ Examples

### Scalar Subquery (Returns 1 Row, 1 Column)

```sql
-- Get average salary for comparison
SELECT
    first_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS avg_salary,
    salary - (SELECT AVG(salary) FROM employees) AS diff_from_avg
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Most recent hire date
SELECT
    employee_id,
    first_name,
    hire_date,
    (SELECT MAX(hire_date) FROM employees) AS latest_hire
FROM employees;
```

### Subquery in WHERE Clause

```sql
-- Simple comparison
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- IN operator with subquery
SELECT * FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments
    WHERE location_id = 1700
);

-- NOT IN with subquery
SELECT * FROM employees
WHERE employee_id NOT IN (
    SELECT employee_id FROM assignments
);
```

### Inline View (Subquery in FROM)

```sql
-- Use subquery results as table
SELECT
    department_id,
    dept_avg_salary,
    salary,
    salary - dept_avg_salary AS diff_from_dept_avg
FROM (
    SELECT
        e.employee_id,
        e.first_name,
        e.salary,
        e.department_id,
        AVG(e.salary) OVER (PARTITION BY e.department_id) AS dept_avg_salary
    FROM employees e
) emp_by_dept
WHERE salary > dept_avg_salary;

-- Ranking within departments
SELECT *
FROM (
    SELECT
        first_name,
        salary,
        department_id,
        ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
    FROM employees
)
WHERE rank <= 3;
```

### EXISTS Operator

```sql
-- More efficient than IN for large datasets
SELECT DISTINCT d.department_id, d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e
    WHERE e.department_id = d.department_id
);

-- NOT EXISTS (no employees in department)
SELECT d.department_id, d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e
    WHERE e.department_id = d.department_id
);
```

### Correlated Subquery

```sql
-- Subquery references column from outer query
SELECT
    first_name,
    salary,
    (SELECT AVG(salary)
     FROM employees e2
     WHERE e2.department_id = e1.department_id
    ) AS dept_avg_salary
FROM employees e1;

-- Find employees earning more than their dept avg
SELECT first_name, salary, department_id
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

### Multiple Subqueries

```sql
-- Complex filtering with multiple levels
SELECT
    first_name,
    salary,
    department_id
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
  AND department_id IN (
      SELECT department_id FROM departments
      WHERE manager_id IN (
          SELECT employee_id FROM employees
          WHERE job_id = 'MANAGER'
      )
  );
```

### HAVING with Subquery

```sql
-- Group having counts
SELECT
    department_id,
    COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > (
    SELECT AVG(dept_count)
    FROM (
        SELECT COUNT(*) AS dept_count
        FROM employees
        GROUP BY department_id
    )
);
```

## ⚠️ Common Mistakes

- Scalar subquery returning multiple rows (error)
  ```sql
  -- ✗ ERROR if subquery returns > 1 row
  SELECT * FROM employees
  WHERE salary = (SELECT salary FROM employees);

  -- ✓ Use IN or EXISTS
  WHERE salary IN (SELECT salary FROM employees);
  ```

- Correlated subquery referencing wrong table
- Using NOT IN with NULL values (returns no rows)
  ```sql
  -- ✗ WRONG if subquery has NULL
  SELECT * FROM employees
  WHERE employee_id NOT IN (SELECT manager_id FROM employees);
  -- Returns no rows because NULL in NOT IN = NULL

  -- ✓ RIGHT
  SELECT * FROM employees
  WHERE employee_id NOT IN (
      SELECT manager_id FROM employees
      WHERE manager_id IS NOT NULL
  );
  ```

- Performance issues with repeated subqueries

## 💡 Tips

- Use EXISTS for existence checks (faster than IN for large sets)
- Scalar subqueries useful for computed columns
- Inline views simplify complex queries
- Correlated subqueries run once per outer row (potentially slow)
- Test subqueries independently first
- UNION/CTE alternatives may be more efficient
- Use subquery in SELECT for added columns
- Comment subqueries for readability
