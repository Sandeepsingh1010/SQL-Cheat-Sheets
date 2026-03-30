# PL/SQL Basics

## 📌 Concept
PL/SQL (Procedural Language/SQL) is Oracle's procedural extension to SQL. It adds programming logic (loops, conditionals, variables) to SQL.

## 🧾 Basic Block Structure
```sql
[DECLARE]
    -- Variable declarations
BEGIN
    -- Executable statements
[EXCEPTION]
    -- Error handling
END;
/
```

## ✅ Examples

### Simple PL/SQL Block
```sql
-- Anonymous block
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;
/

-- Enable output viewing
SET SERVEROUTPUT ON;
```

### Block with Variables
```sql
DECLARE
    v_employee_id NUMBER := 100;
    v_first_name VARCHAR2(50);
    v_salary NUMBER;
BEGIN
    SELECT first_name, salary
    INTO v_first_name, v_salary
    FROM employees
    WHERE employee_id = v_employee_id;

    DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
END;
/
```

### Block with Conditional Logic
```sql
BEGIN
    DECLARE
        v_salary NUMBER := 5000;
    BEGIN
        IF v_salary > 10000 THEN
            DBMS_OUTPUT.PUT_LINE('Senior Level Salary');
        ELSIF v_salary > 5000 THEN
            DBMS_OUTPUT.PUT_LINE('Mid Level Salary');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Junior Level Salary');
        END IF;
    END;
END;
/
```

### Block with Loop
```sql
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Iteration: ' || i);
    END LOOP;
END;
/
```

### Block with Cursor
```sql
BEGIN
    FOR emp_rec IN (SELECT employee_id, first_name, salary FROM employees)
    LOOP
        DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id || ' - ' || emp_rec.first_name);
    END LOOP;
END;
/
```

### Block with Exception Handling
```sql
BEGIN
    DECLARE
        v_employee_id NUMBER := 999;
        v_first_name VARCHAR2(50);
    BEGIN
        SELECT first_name
        INTO v_first_name
        FROM employees
        WHERE employee_id = v_employee_id;

        DBMS_OUTPUT.PUT_LINE('Found: ' || v_first_name);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Employee not found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;
/
```

## ⚠️ Common Mistakes

- Forgetting / at end of block
- INTO clause missing in SELECT
- Variable declared but not used
- Not setting SERVEROUTPUT ON before running
- Exception not handling specific errors

## 💡 Tips

- Use meaningful variable names (v_ prefix standard)
- Always include exception handling
- Use SET SERVEROUTPUT ON in SQL Developer
- Test variables with DBMS_OUTPUT.PUT_LINE
- Comments with -- or /* */
- Each statement ends with semicolon
