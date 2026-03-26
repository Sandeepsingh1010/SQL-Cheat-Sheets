# Correlated Subqueries

## 📌 Concept
A correlated subquery references columns from the outer query. It executes once for each outer query row, making it powerful but potentially slow on large datasets.

## 🧾 Structure

```sql
SELECT column1, column2
FROM table1 outer_alias
WHERE column1 operator (
    SELECT aggregated_value
    FROM table2 inner_alias
    WHERE inner_alias.key = outer_alias.key
);
```

## ✅ Examples

### Row-by-Row Comparison

```sql
-- Find employees earning more than their department average
SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- Employees with above-average commission
SELECT first_name, commission_pct
FROM employees e1
WHERE commission_pct > (
    SELECT AVG(commission_pct)
    FROM employees e2
    WHERE e1.job_id = e2.job_id
);
```

### EXISTS with Correlated

```sql
-- Departments with employees earning > 5000
SELECT d.department_id, d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
      AND e.salary > 5000
);

-- Employees with at least one assignment
SELECT e.employee_id, e.first_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM assignments a
    WHERE a.employee_id = e.employee_id
);
```

### Ranking Within Groups

```sql
-- Top 3 employees per department (correlated approach)
SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    e.department_id
FROM employees e
WHERE 3 >= (
    SELECT COUNT(*)
    FROM employees e2
    WHERE e2.department_id = e.department_id
      AND e2.salary >= e.salary
)
ORDER BY e.department_id, e.salary DESC;
```

### Matching Against Multiple Conditions

```sql
-- Orders with items matching customer's usual product category
SELECT o.order_id, o.customer_id, o.order_date
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.order_id = o.order_id
      AND EXISTS (
          SELECT 1
          FROM customer_orders co
          WHERE co.customer_id = o.customer_id
            AND co.product_category = (
                SELECT category FROM products
                WHERE product_id = oi.product_id
            )
      )
);
```

### Running Totals

```sql
-- Cumulative salary by hire date
SELECT
    e1.employee_id,
    e1.first_name,
    e1.hire_date,
    e1.salary,
    (SELECT SUM(e2.salary)
     FROM employees e2
     WHERE e2.hire_date <= e1.hire_date
    ) AS cumulative_salary
FROM employees e1
ORDER BY e1.hire_date;
```

## ⚠️ Common Mistakes

- Joining incorrectly between outer and inner query
- Forgetting WHERE clause correlation (becomes non-correlated)
- Performance issues with large datasets (each row executes subquery)
- NULL handling in correlated conditions
- Mixing up table aliases between outer/inner queries

## 💡 Tips

- Use clear aliases (e, e1, e2) to distinguish outer/inner
- Test subquery independently with hardcoded outer value first
- Consider performance: correlated = potentially N executions
- Modern alternative: Window functions or CTEs often faster
- EXISTS usually faster than COUNT for "has records" checks
- Always specify correlation in WHERE clause
- Can use multiple correlated subqueries in single query
