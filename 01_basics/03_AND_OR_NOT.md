# AND, OR, NOT Operators

## 📌 Concept
Logical operators combine multiple conditions in WHERE clauses to create more complex filters.

## 🧾 Syntax
```sql
SELECT *
FROM table_name
WHERE condition1 AND condition2;

SELECT *
FROM table_name
WHERE condition1 OR condition2;

SELECT *
FROM table_name
WHERE NOT condition;
```

## ✅ Example
```sql
-- AND operator (both conditions must be true)
SELECT first_name, salary, department_id
FROM employees
WHERE salary > 5000 AND department_id = 10;

-- OR operator (at least one condition must be true)
SELECT first_name, salary
FROM employees
WHERE department_id = 10 OR department_id = 20;

-- NOT operator
SELECT first_name
FROM employees
WHERE NOT department_id = 10;

-- Combining operators
SELECT first_name, salary, department_id
FROM employees
WHERE (department_id = 10 OR department_id = 20)
  AND salary > 5000;
```

## ⚠️ Common Mistakes
- Forgetting parentheses when combining operators
- Operator precedence issues (AND has higher precedence than OR)
- Using confusing logic without clarity

## 💡 Tips
- Use parentheses to clarify intent and avoid precedence issues
- AND has higher precedence than OR in Oracle
- Use NOT sparingly; often clearer to use opposite operator (e.g., `!=` instead of `NOT =`)
