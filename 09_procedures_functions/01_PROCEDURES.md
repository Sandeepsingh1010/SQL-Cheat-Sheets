# PL/SQL Procedures

## 📌 Concept
Procedures are stored PL/SQL programs that perform specific tasks. They can have input/output parameters.

## 🧾 Syntax
```sql
CREATE PROCEDURE procedure_name (
    parameter1 [MODE] datatype,
    parameter2 [MODE] datatype
)
AS
BEGIN
    -- Executable statements
END;
/
```

Modes:
- IN: Input parameter (default)
- OUT: Output parameter
- IN OUT: Both input and output

## ✅ Example
```sql
-- Simple procedure (no parameters)
CREATE PROCEDURE print_employees AS
BEGIN
    FOR emp_rec IN (SELECT first_name, salary FROM employees) LOOP
        DBMS_OUTPUT.PUT_LINE(emp_rec.first_name || ': ' || emp_rec.salary);
    END LOOP;
END;
/

-- Procedure with IN parameter
CREATE PROCEDURE get_employee_salary (
    p_emp_id IN NUMBER
) AS
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary
    FROM employees
    WHERE employee_id = p_emp_id;

    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
END;
/

-- Procedure with OUT parameter
CREATE PROCEDURE get_emp_details (
    p_emp_id IN NUMBER,
    p_name OUT VARCHAR2,
    p_salary OUT NUMBER
) AS
BEGIN
    SELECT first_name, salary
    INTO p_name, p_salary
    FROM employees
    WHERE employee_id = p_emp_id;
END;
/

-- Execute procedure
BEGIN
    print_employees;
END;
/

-- Call procedure with parameters
DECLARE
    v_name VARCHAR2(100);
    v_salary NUMBER;
BEGIN
    get_emp_details(100, v_name, v_salary);
    DBMS_OUTPUT.PUT_LINE(v_name || ' - ' || v_salary);
END;
/
```

## 💡 Tips
- Use CREATE OR REPLACE for easier updates
- IN parameters pass data to procedure
- OUT parameters return values
- IN OUT allows both directions
- Always handle exceptions
- Use p_ prefix for parameters (convention)
