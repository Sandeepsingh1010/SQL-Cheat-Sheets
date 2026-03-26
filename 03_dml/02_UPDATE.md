# UPDATE Statement

## 📌 Concept
UPDATE modifies existing data in one or more rows. Always use WHERE to specify which rows to update.

## 🧾 Syntax
```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

## ✅ Example
```sql
-- Update single column for specific row
UPDATE employees
SET salary = 6000
WHERE employee_id = 101;

-- Update multiple columns
UPDATE employees
SET salary = 5500, hire_date = SYSDATE
WHERE department_id = 10;

-- Update with calculation
UPDATE employees
SET salary = salary * 1.1
WHERE department_id = 10;

-- Update from another table
UPDATE employees e
SET salary = (SELECT AVG(salary) FROM employees)
WHERE department_id = 20;

-- Update all rows (be careful!)
UPDATE employees
SET status = 'ACTIVE';
```

## ⚠️ Common Mistakes
- Forgetting WHERE clause (updates entire table!)
- Using = to compare instead of ==
- Updating multiple times when one calculation is needed
- Not considering data type compatibility

## 💡 Tips
- Always test UPDATE with SELECT first
- Use WHERE to target specific rows
- Be careful with multi-table UPDATEs
- COMMIT after verifying correctness
- Use ROLLBACK if you made a mistake
