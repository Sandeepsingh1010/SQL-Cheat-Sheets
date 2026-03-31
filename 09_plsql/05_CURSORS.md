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

### Parameterized Cursor (Cursor with Variable)
```sql
DECLARE
    CURSOR c_emp_by_dept (p_dept_id NUMBER) IS
        SELECT employee_id, first_name, salary
        FROM employees
        WHERE department_id = p_dept_id;

    v_emp c_emp_by_dept%ROWTYPE;
    v_target_dept NUMBER := 50;
BEGIN
    OPEN c_emp_by_dept(v_target_dept);
    LOOP
        FETCH c_emp_by_dept INTO v_emp;
        EXIT WHEN c_emp_by_dept%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_emp.employee_id || ' - ' || v_emp.first_name);
    END LOOP;
    CLOSE c_emp_by_dept;
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

-- Cursor FOR loop with variable
DECLARE
    v_min_salary NUMBER := 7000;

    CURSOR emp_cursor (p_min_salary NUMBER) IS
        SELECT first_name, salary
        FROM employees
        WHERE salary >= p_min_salary;
BEGIN
    FOR emp_rec IN emp_cursor(v_min_salary) LOOP
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
- Use parameterized cursors when query filters come from variables
