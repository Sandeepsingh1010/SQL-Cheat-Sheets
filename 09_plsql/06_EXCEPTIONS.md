# PL/SQL Exception Handling

## 📌 Concept
Exceptions are runtime errors raised during PL/SQL execution. You can handle predefined Oracle exceptions, define your own exceptions, and raise user-friendly application errors.

## 🧾 Syntax
```sql
DECLARE
    -- User-defined exception
    e_custom_error EXCEPTION;

    -- Optional mapping of ORA code to named exception
    e_fk_violation EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_fk_violation, -2292);

    v_emp_id employees.employee_id%TYPE := 999999;
    v_salary employees.salary%TYPE;
BEGIN
    -- Raises NO_DATA_FOUND if employee does not exist
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = v_emp_id;

    -- Business rule check using user-defined exception
    IF v_salary < 0 THEN
        RAISE e_custom_error;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No rows matched the query.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Query returned more than one row.');
    WHEN e_fk_violation THEN
        DBMS_OUTPUT.PUT_LINE('Cannot delete parent row: child records exist.');
    WHEN e_custom_error THEN
        DBMS_OUTPUT.PUT_LINE('Custom business rule failed.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/
```

## ✅ Example 1: User-Defined Exception
```sql
DECLARE
    e_invalid_raise_pct EXCEPTION;
    v_raise_pct NUMBER := 35;
BEGIN
    IF v_raise_pct > 20 THEN
        RAISE e_invalid_raise_pct;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Raise accepted.');
EXCEPTION
    WHEN e_invalid_raise_pct THEN
        DBMS_OUTPUT.PUT_LINE('Raise percentage cannot exceed 20%.');
END;
/
```

## ✅ Example 2: Raise User Error for UI/API
```sql
CREATE OR REPLACE PROCEDURE update_salary_safe (
    p_emp_id      IN employees.employee_id%TYPE,
    p_new_salary  IN employees.salary%TYPE
) AS
BEGIN
    IF p_new_salary <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary must be greater than zero.');
    END IF;

    UPDATE employees
    SET salary = p_new_salary
    WHERE employee_id = p_emp_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Employee not found for provided ID.');
    END IF;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20003, 'Duplicate value violates unique constraint.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20999, 'Unexpected system error: ' || SQLERRM);
END;
/
```

## 🔢 Common Oracle Error Codes
| ORA Code | Name / Meaning | Typical Handling |
|----------|----------------|------------------|
| ORA-00001 | `DUP_VAL_ON_INDEX` (unique constraint) | Show duplicate value message |
| ORA-01403 | `NO_DATA_FOUND` | Inform user no record exists |
| ORA-01422 | `TOO_MANY_ROWS` | Tighten query filter |
| ORA-01722 | Invalid number | Validate numeric input before SQL |
| ORA-02291 | Parent key not found (FK) | Ensure parent row exists first |
| ORA-02292 | Child row found (FK) | Prevent delete or cascade safely |
| ORA-06502 | Numeric/value error | Check variable size/type and conversion |
| ORA-01861 | Literal does not match format string | Use explicit `TO_DATE` format mask |

## 🏷️ Recommended User Error Range
Use `RAISE_APPLICATION_ERROR` with codes from **-20000 to -20999**.

Suggested convention:
- `-20001` to `-20049`: Validation errors
- `-20050` to `-20079`: Business rule violations
- `-20080` to `-20099`: Data integrity checks
- `-20999`: Generic fallback unexpected error

## ⚠️ Common Mistakes
- Using `WHEN OTHERS THEN NULL` (hides errors)
- Returning raw Oracle errors directly to end users
- Not re-raising when logging critical failures
- Forgetting specific handlers before `WHEN OTHERS`

## 💡 Tips
- Handle known exceptions explicitly first, then `WHEN OTHERS`
- Use `SQLCODE` and `SQLERRM` for diagnostics/logging
- Keep user messages simple; keep technical details in logs
- Standardize application error code usage across procedures
