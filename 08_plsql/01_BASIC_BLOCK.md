# PL/SQL Basic Block

## 📌 Concept
A PL/SQL block is a unit of code containing declarations, executable statements, and exception handling.

## 🧾 Syntax
```sql
DECLARE
    -- Variable declarations
    variable_name datatype;
BEGIN
    -- Executable statements
    NULL;
EXCEPTION
    -- Exception handling
    WHEN exception_name THEN
        DBMS_OUTPUT.PUT_LINE('Error message');
END;
/
```

## ✅ Example
```sql
-- Simple PL/SQL block
DECLARE
    v_emp_id NUMBER;
    v_salary NUMBER;
    v_name VARCHAR2(100);
BEGIN
    -- Query employee data
    SELECT employee_id, salary, first_name || ' ' || last_name
    INTO v_emp_id, v_salary, v_name
    FROM employees
    WHERE employee_id = 100;

    -- Display result
    DBMS_OUTPUT.PUT_LINE('Employee: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

## ⚠️ Common Mistakes
- Missing forward slash `/` at end
- Wrong data type for variable
- Not handling exceptions
- Forgetting INTO clause in SELECT

## 💡 Tips
- Always end block with `/` on new line
- Use DECLARE for variables
- Use INTO to assign query results to variables
- Use DBMS_OUTPUT.PUT_LINE for output
- Handle NO_DATA_FOUND and OTHERS exceptions
