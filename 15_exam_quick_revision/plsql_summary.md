# PL/SQL Quick Summary

## 📌 Essential Syntax

### Block Structure
```sql
[DECLARE
    declarations;]
BEGIN
    statements;
[EXCEPTION
    error_handling;]
END;
/
```

### Variables
```sql
DECLARE
    v_name VARCHAR2(50) := 'default value';
    v_count NUMBER;
    v_date DATE := SYSDATE;
    v_flag BOOLEAN := TRUE;
BEGIN
    -- use variables
END;
```

### Loops
```sql
-- FOR loop
FOR i IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE(i);
END LOOP;

-- WHILE loop
WHILE condition LOOP
    statements;
END LOOP;

-- LOOP with EXIT
LOOP
    statements;
    IF condition THEN EXIT; END IF;
END LOOP;
```

### Conditional Logic
```sql
IF condition THEN
    statements;
ELSIF condition THEN
    statements;
ELSE
    statements;
END IF;
```

### Cursors
```sql
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, first_name FROM employees;
    v_emp_rec emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    FETCH emp_cursor INTO v_emp_rec;
    CLOSE emp_cursor;
END;
```

### Exception Handling
```sql
BEGIN
    -- code
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data');
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
```

### Procedures
```sql
CREATE PROCEDURE proc_name (p_param1 IN/OUT datatype) AS
BEGIN
    -- code
END proc_name;
/

EXEC proc_name(value);
```

### Functions
```sql
CREATE FUNCTION func_name (p_param1 datatype)
RETURN datatype AS
BEGIN
    RETURN value;
END func_name;
/

SELECT func_name(value) FROM dual;
```

## Common Data Types

| Type | Use |
|------|-----|
| NUMBER(p,s) | Decimal numbers |
| INTEGER | Whole numbers |
| VARCHAR2(n) | Variable text |
| CHAR(n) | Fixed text |
| DATE | Date and time |
| BOOLEAN | TRUE/FALSE |
| CLOB | Large text |
| BLOB | Binary data |

## Common Built-in Functions

```sql
DBMS_OUTPUT.PUT_LINE()    -- Print output
SQLCODE                   -- Error code
SQLERRM                   -- Error message
SYSDATE                   -- Current date/time
SYSTIMESTAMP             -- With milliseconds
```

## Important Concepts

- **%ROWTYPE**: Record type matching table row
- **%TYPE**: Variable type matching column type
- **INTO**: Fetch single row result
- **FETCH**: Get row from  cursor
- **OPEN**: Start cursor
- **CLOSE**: Stop cursor
- **Implicit Cursor**: Automatic for SQL statements
- **Explicit Cursor**: User-defined for repetition

## Quick Checklist

✓ Set SERVEROUTPUT ON
✓ Use meaningful variable names (v_ prefix)
✓ Always have exception handling
✓ Test with data
✓ Comment complex logic
✓ Use NULL checks
✓ Close cursors when done
