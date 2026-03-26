# ORDER BY Clause

## 📌 Concept
ORDER BY sorts the result set by one or more columns in ascending or descending order.

## 🧾 Syntax
```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1 ASC, column2 DESC;
```

## ✅ Example
```sql
-- Sort by single column ascending (default)
SELECT first_name, last_name, salary
FROM employees
ORDER BY last_name;

-- Sort descending
SELECT first_name, salary
FROM employees
ORDER BY salary DESC;

-- Sort by multiple columns
SELECT first_name, last_name, salary
FROM employees
ORDER BY department_id ASC, salary DESC;

-- Sort by column position
SELECT first_name, last_name, salary
FROM employees
ORDER BY 3 DESC;  -- Sort by 3rd column (salary)

-- Sort by alias
SELECT first_name, salary AS annual_salary
FROM employees
ORDER BY annual_salary DESC;
```

## ⚠️ Common Mistakes
- Forgetting O is capital in ORDER BY
- Sorting text numerically
- Using column position incorrectly
- Not specifying ASC/DESC when order matters

## 💡 Tips
- ASC is the default direction
- NULL values appear first in ASC, last in DESC
- You can sort by columns not in the SELECT list
- Sorting by column position is less readable; use column names instead
