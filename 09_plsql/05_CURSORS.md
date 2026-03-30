# PL/SQL Cursors

## 📌 Concept
Cursors allow processing of query results one row at a time in PL/SQL.

## 🧾 Syntax

### Implicit Cursor
```sql
DECLARE
    v_name VARCHAR2(100);
BEGIN
    SELECT first_name INTO v_name
    FROM employees WHERE employee_id = 100;
    DBMS_OUTPUT.PUT_LINE(v_name);
END;
/
```

### Explicit Cursor
```sql
DECLARE
    CURSOR cursor_name IS
        SELECT columns FROM table;
    v_row cursor_name%ROWTYPE;
BEGIN
    OPEN cursor_name;
    FETCH cursor_name INTO v_row;
    CLOSE cursor_name;
END;
/
```

## ✅ Example
```sql
-- Explicit cursor with loop
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, salary
        FROM employees
        WHERE department_id = 10;

    v_emp_rec emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_emp_rec.first_name || ': ' || v_emp_rec.salary);
    END LOOP;
    CLOSE emp_cursor;
END;
/

-- Cursor FOR loop (simpler)
DECLARE
    CURSOR emp_cursor IS
        SELECT first_name, salary
        FROM employees
        WHERE department_id = 10;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ': ' || emp_rec.salary);
    END LOOP;
END;
/
```

## 💡 Tips
- Explicit cursor: OPEN, FETCH, CLOSE
- Cursor FOR loop is simpler and auto-opens/closes
- Use %ROWTYPE for row records
- %NOTFOUND checks if FETCH found a row
- %FOUND checks if FETCH was successful
- %ROWCOUNT returns number of rows fetched
