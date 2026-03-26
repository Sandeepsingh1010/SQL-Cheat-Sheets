# PL/SQL Functions

## 📌 Concept
Functions are stored PL/SQL programs that return a single value. They can be used in SQL queries.

## 🧾 Syntax
```sql
CREATE FUNCTION function_name (
    parameter1 datatype,
    parameter2 datatype
) RETURN return_datatype
AS
BEGIN
    -- Executable statements
    RETURN value;
END;
/
```

## ✅ Example
```sql
-- Simple function
CREATE FUNCTION get_employee_count RETURN NUMBER AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM employees;
    RETURN v_count;
END;
/

-- Function with parameters
CREATE FUNCTION calculate_annual_bonus (
    p_salary IN NUMBER,
    p_bonus_percent IN NUMBER
) RETURN NUMBER AS
    v_bonus NUMBER;
BEGIN
    v_bonus := p_salary * (p_bonus_percent / 100);
    RETURN v_bonus;
END;
/

-- Function returning employee name
CREATE FUNCTION get_full_name (
    p_emp_id IN NUMBER
) RETURN VARCHAR2 AS
    v_name VARCHAR2(200);
BEGIN
    SELECT first_name || ' ' || last_name
    INTO v_name
    FROM employees
    WHERE employee_id = p_emp_id;

    RETURN v_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Employee not found';
END;
/

-- Use function in SELECT query
SELECT
    employee_id,
    get_full_name(employee_id) AS full_name,
    salary,
    calculate_annual_bonus(salary, 10) AS bonus
FROM employees;

-- Execute function in PL/SQL
DECLARE
    v_bonus NUMBER;
BEGIN
    v_bonus := calculate_annual_bonus(5000, 15);
    DBMS_OUTPUT.PUT_LINE('Bonus: ' || v_bonus);
END;
/
```

## ⚠️ Common Mistakes
- Forgetting RETURN statement
- Wrong RETURN data type
- No RETURN in EXCEPTION handler
- Using OUT parameters (functions return only one value)

## 💡 Tips
- Functions must have RETURN statement
- Functions return single value only
- Functions can be used in SQL queries
- Use RETURN NULL for no value scenario
- Always use CREATE OR REPLACE for updates
