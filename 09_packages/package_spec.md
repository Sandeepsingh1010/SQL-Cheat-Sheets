# Package Specification

## 📌 Concept
A package groups related procedures and functions into a single named unit. Specification (SPEC) defines public interface, Body implements.

## 🧾 Syntax
```sql
CREATE [OR REPLACE] PACKAGE package_name AS
    -- Declaration of procedures/functions/types
    PROCEDURE proc_name(parameters);
    FUNCTION func_name(parameters) RETURN datatype;
END package_name;
/
```

## ✅ Examples

### Simple Package Spec
```sql
CREATE PACKAGE employee_mgmt AS
    PROCEDURE hire_employee(
        p_first_name IN VARCHAR2,
        p_salary IN NUMBER
    );

    FUNCTION get_employee_count RETURN NUMBER;

    FUNCTION calculate_bonus(p_salary NUMBER) RETURN NUMBER;
END employee_mgmt;
/
```

## 💡 Tips

- SPEC is contract, BODY is implementation
- Public procedures defined in SPEC
- Private procedures only in BODY
- Good for organization and security
- Compile SPEC first, then BODY
