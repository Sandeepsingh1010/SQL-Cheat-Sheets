# DELETE Statement

## 📌 Concept
DELETE removes rows from a table. Use WHERE to specify which rows to delete. Without WHERE, all rows are deleted!

## 🧾 Syntax
```sql
DELETE FROM table_name
WHERE condition;
```

## ✅ Example
```sql
-- Delete specific row
DELETE FROM employees
WHERE employee_id = 101;

-- Delete rows matching condition
DELETE FROM orders
WHERE order_date < DATE '2020-01-01';

-- Delete with complex condition
DELETE FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'IT')
  AND salary < 3000;

-- Delete all rows (caution!)
DELETE FROM temp_table;

-- Delete and rollback if needed
BEGIN
    DELETE FROM employees WHERE department_id = 10;
    -- Check results before commit
    COMMIT;
END;
/
```

## ⚠️ Common Mistakes
- Forgetting WHERE clause (deletes entire table!)
- Deleting rows referenced by foreign keys
- Not using COMMIT/ROLLBACK appropriately
- Case sensitivity in text conditions

## 💡 Tips
- Test with SELECT first using same WHERE
- Always use WHERE unless you want to delete all
- Use COMMIT/ROLLBACK to make permanent or undo
- Consider TRUNCATE for deleting all rows (faster)
- Can recover deleted data within transaction
