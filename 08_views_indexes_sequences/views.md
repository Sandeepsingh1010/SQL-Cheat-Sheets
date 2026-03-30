# Views

## 📌 Concept
A view is a stored query that appears as a virtual table. It doesn't store data, just the query definition. Used to simplify complex queries and secure sensitive data.

## 🧾 Syntax
```sql
CREATE [OR REPLACE] VIEW view_name AS
SELECT columns
FROM tables
WHERE conditions;

DROP VIEW view_name;
```

## ✅ Examples

### Simple View
```sql
CREATE VIEW employees_view AS
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees;

-- Use view like table
SELECT * FROM employees_view WHERE salary > 5000;
```

### View with Joins
```sql
CREATE VIEW emp_dept_view AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name,
    d.location_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
```

### View with Aggregation
```sql
CREATE VIEW dept_salary_summary AS
SELECT
    department_id,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;
```

### Updatable View
```sql
CREATE VIEW emp_simple_update AS
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM employees;

-- Can INSERT/UPDATE/DELETE through this view
UPDATE emp_simple_update SET salary = 6000 WHERE employee_id = 100;
```

### View with OR REPLACE
```sql
-- Modify view without dropping it
CREATE OR REPLACE VIEW employees_view AS
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    hire_date  -- Added new column
FROM employees;
```

## ⚠️ Common Mistakes

- View not updatable due to GROUP BY/aggregates
- Dropping view destroys dependent views
- Not using ORDER BY in view (no guaranteed order)
- Performance: Complex views can be slow
- Security: Users see only through view (good)

## 💡 Tips

- Use views to simplify complex queries
- Use views to restrict column/row access (security)
- Views are updatable only if based on single table
- Views don't store data (saves space)
- Can join multiple views together
- DROP VIEW with CASCADE to drop dependents
