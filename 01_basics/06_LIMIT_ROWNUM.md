# LIMIT / ROWNUM (Oracle)

## 📌 Concept
Limit the number of rows returned in a result set. Oracle uses ROWNUM or FETCH to achieve this.

## 🧾 Syntax
```sql
-- Oracle 12c and later (FETCH)
SELECT column1, column2, ...
FROM table_name
ORDER BY column_name
FETCH FIRST n ROWS ONLY;

-- Oracle older version (ROWNUM)
SELECT * FROM table_name
WHERE ROWNUM <= n;
```

## ✅ Example
```sql
-- Get first 5 employees (modern Oracle)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY;

-- Skip first 10 rows and get 5 rows
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;

-- Get top 10% of employees by salary
SELECT first_name, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 10 PERCENT ROWS ONLY;

-- ROWNUM method (older Oracle)
SELECT * FROM employees
WHERE ROWNUM <= 5
ORDER BY salary DESC;
```

## ⚠️ Common Mistakes
- Using LIMIT instead of FETCH in Oracle (MySQL syntax)
- Forgetting ORDER BY with FETCH
- ROWNUM applied before sorting (use subquery)
- Mixing OFFSET and ROWNUM

## 💡 Tips
- Use FETCH FIRST for modern Oracle (12c+)
- Always use ORDER BY with FETCH FIRST for meaningful results
- ROWNUM counts generated rows, not final rows (needs subquery)
- OFFSET is for pagination
