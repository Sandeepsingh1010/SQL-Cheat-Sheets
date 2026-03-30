# PL/SQL Variables and Data Types

## 📌 Concept
Variables store data values during PL/SQL execution. Data types define what kind of data they can hold.

## 🧾 Common Data Types
```sql
-- Numeric
NUMBER
NUMBER(p, s)        -- p=precision, s=scale
INTEGER
BINARY_INTEGER

-- Text
VARCHAR2(size)
CHAR(size)

-- Date
DATE

-- Boolean
BOOLEAN             -- TRUE, FALSE, NULL
```

## ✅ Example
```sql
DECLARE
    -- Numeric variables
    v_employee_id NUMBER;
    v_salary NUMBER(10, 2);
    v_age INTEGER;

    -- Text variables
    v_first_name VARCHAR2(50);
    v_email VARCHAR2(100);

    -- Date variable
    v_hire_date DATE;

    -- Boolean variable
    v_is_active BOOLEAN;

    -- Variable using table column type
    v_dept_id employees.department_id%TYPE;

BEGIN
    -- Assign values
    v_employee_id := 101;
    v_first_name := 'John';
    v_salary := 5000.50;
    v_hire_date := SYSDATE;
    v_is_active := TRUE;

    -- Use %TYPE for column reference
    v_dept_id := 10;

    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
END;
/
```

## 💡 Tips
- Use %TYPE to reference table column types
- Use %ROWTYPE for entire row
- Name variables with v_ prefix (convention)
- Initialize variables to NULL by default
- Use := for assignment (not =)
- Boolean can be TRUE, FALSE, or NULL
