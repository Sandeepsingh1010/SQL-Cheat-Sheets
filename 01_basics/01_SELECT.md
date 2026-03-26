# SELECT Statement

## 📌 Concept
The SELECT statement retrieves data from one or more tables. It's the most fundamental SQL command for querying data in Oracle.

## 🧾 Syntax
```sql
SELECT column1, column2, ...
FROM table_name;
```

## ✅ Example
```sql
-- Select all columns
SELECT * FROM employees;

-- Select specific columns
SELECT first_name, last_name, salary
FROM employees;

-- Select with alias
SELECT first_name AS "First Name", salary AS "Annual Salary"
FROM employees;
```

## ⚠️ Common Mistakes
- Forgetting the `FROM` clause
- Using incorrect column names
- Not using quotes for column aliases with spaces
- Mixing uppercase and lowercase without quotes

## 💡 Tips
- Always specify column names instead of `SELECT *` when possible (better performance)
- Use meaningful aliases to make results clearer
- Aliases without quotes are case-insensitive in Oracle
