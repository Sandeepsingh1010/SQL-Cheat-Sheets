# INSERT Statement

## 📌 Concept
INSERT adds new rows of data into a table. You can insert single or multiple rows at once.

## 🧾 Syntax
```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

## ✅ Example
```sql
-- Insert single row with all columns
INSERT INTO employees (employee_id, first_name, last_name, salary, hire_date)
VALUES (101, 'John', 'Smith', 5000, SYSDATE);

-- Insert without specifying columns (must provide all)
INSERT INTO employees
VALUES (102, 'Jane', 'Doe', 6000, SYSDATE);

-- Insert with default values
INSERT INTO orders (order_id, customer_id, amount)
VALUES (1, 100, 250.00);

-- Insert from SELECT
INSERT INTO employees_backup
SELECT * FROM employees
WHERE department_id = 10;

-- Insert multiple rows (Oracle 9i+)
INSERT ALL
    INTO employees (employee_id, first_name, salary) VALUES (201, 'Alice', 5500)
    INTO employees (employee_id, first_name, salary) VALUES (202, 'Bob', 5700)
SELECT * FROM dual;
```

## ⚠️ Common Mistakes
- Column order mismatch between INSERT and VALUES
- Forgetting to quote text values
- Inserting NULL into NOT NULL columns
- Wrong number of values

## 💡 Tips
- Always specify column names for clarity
- Use SYSDATE for current date
- Insert from SELECT is useful for bulk operations
- Multiple INSERT ALL is faster than separate INSERTs
