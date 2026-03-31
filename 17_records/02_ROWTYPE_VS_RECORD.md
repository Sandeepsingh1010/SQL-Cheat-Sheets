# %ROWTYPE vs RECORD

## 📌 Concept
Both `%ROWTYPE` and `RECORD` represent grouped fields, but they are used for different needs.

- `%ROWTYPE`: mirrors an entire table row or cursor row automatically
- `RECORD`: custom structure with only selected fields

## 🧾 Quick Comparison

| Feature | `%ROWTYPE` | `RECORD` |
|---------|------------|----------|
| Field source | Table/cursor definition | Manual custom definition |
| Auto-updates with schema | Yes | No (manual updates needed) |
| Includes all columns | Yes | No (only what you define) |
| Best for | Full row processing | DTO-like custom payloads |

## ✅ Example: `%ROWTYPE`
```sql
DECLARE
    v_emp employees%ROWTYPE;
BEGIN
    SELECT *
    INTO v_emp
    FROM employees
    WHERE employee_id = 100;

    DBMS_OUTPUT.PUT_LINE(v_emp.first_name || ' ' || v_emp.last_name);
END;
/
```

## ✅ Example: `RECORD`
```sql
DECLARE
    TYPE t_emp_light_rec IS RECORD (
        full_name VARCHAR2(120),
        annual_salary NUMBER(12,2)
    );

    v_emp t_emp_light_rec;
BEGIN
    SELECT first_name || ' ' || last_name,
           salary * 12
    INTO v_emp.full_name,
         v_emp.annual_salary
    FROM employees
    WHERE employee_id = 100;

    DBMS_OUTPUT.PUT_LINE(v_emp.full_name || ' - ' || v_emp.annual_salary);
END;
/
```

## ⚠️ Common Mistakes
- Using `SELECT *` with `RECORD` that does not match every selected column
- Assuming `%ROWTYPE` is always efficient when only 1-2 fields are needed
- Forgetting to update custom `RECORD` when business fields change

## 💡 Tips
- Prefer `%ROWTYPE` for full-row maintenance operations
- Prefer `RECORD` for lightweight projections and APIs
- Combine `RECORD` fields with `%TYPE` for safer typing
