# Dynamic SQL & Advanced Techniques

## 📌 Concept
Dynamic SQL builds SQL statements at runtime using string concatenation, allowing flexible, reusable code.

## 🧾 Syntax
```sql
EXECUTE IMMEDIATE sql_string [INTO variable]
    [USING bind_variable];
```

## ✅ Examples

### Simple Dynamic Query
```sql
DECLARE
    v_sql VARCHAR2(1000);
    v_count NUMBER;
BEGIN
    v_sql := 'SELECT COUNT(*) FROM employees WHERE salary > :salary';

    EXECUTE IMMEDIATE v_sql
        INTO v_count
        USING 5000;

    DBMS_OUTPUT.PUT_LINE('Count: ' || v_count);
END;
/
```

### Dynamic DML
```sql
DECLARE
    v_table_name VARCHAR2(50) := 'employees';
    v_column_name VARCHAR2(50) := 'salary';
    v_value NUMBER := 6000;
BEGIN
    -- Dynamic UPDATE
    EXECUTE IMMEDIATE 'UPDATE ' || v_table_name ||
                     ' SET ' || v_column_name || ' = :val
                     WHERE employee_id = 100'
        USING v_value;
END;
/
```

### Dynamic INSERT
```sql
DECLARE
    v_sql VARCHAR2(1000);
    v_id NUMBER := 101;
    v_name VARCHAR2(50) := 'Jane Doe';
BEGIN
    v_sql := 'INSERT INTO employees (employee_id, first_name) VALUES (:id, :name)';

    EXECUTE IMMEDIATE v_sql USING v_id, v_name;
    COMMIT;
END;
/
```

## ⚠️ Common Mistakes

- SQL injection (unsanitized user input)
- String concatenation vs bind variables
- Forgetting to commit after DML
- Wrong variable types in USING

## 💡 Tips

- Always use bind variables (:var) not string concatenation
- Validate/sanitize user input
- Test thoroughly
- Use for flexibility, not when static SQL works
