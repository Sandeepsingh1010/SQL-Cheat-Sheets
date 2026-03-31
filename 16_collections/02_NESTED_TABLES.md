# Nested Tables

## 📌 Concept
Nested tables are unbounded collections indexed by integer.

They can be used in PL/SQL and can also be stored in database columns, which makes them flexible for both procedural and SQL contexts.

## 🧾 Syntax
```sql
DECLARE
    TYPE t_numbers IS TABLE OF NUMBER;
    v_nums t_numbers := t_numbers(10, 20, 30);
BEGIN
    v_nums.EXTEND;
    v_nums(4) := 40;

    DBMS_OUTPUT.PUT_LINE('Count: ' || v_nums.COUNT);
END;
/
```

## ✅ Example
```sql
DECLARE
    TYPE t_names IS TABLE OF VARCHAR2(50);
    v_names t_names := t_names('Alice', 'Bob', 'Charlie');
BEGIN
    v_names.DELETE(2); -- remove Bob (collection becomes sparse)
    v_names.EXTEND;
    v_names(v_names.LAST) := 'Diana';

    -- Sparse-safe iteration
    FOR i IN v_names.FIRST .. v_names.LAST LOOP
        IF v_names.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE('Name: ' || v_names(i));
        END IF;
    END LOOP;
END;
/
```

## 🔢 Using COUNT with Nested Tables
```sql
DECLARE
    TYPE t_nums IS TABLE OF NUMBER;
    v_nums t_nums := t_nums(10, 20, 30, 40);
BEGIN
    v_nums.DELETE(2); -- creates a gap

    DBMS_OUTPUT.PUT_LINE('COUNT = ' || v_nums.COUNT); -- 3
    DBMS_OUTPUT.PUT_LINE('LAST  = ' || v_nums.LAST);  -- 4

    FOR i IN v_nums.FIRST .. v_nums.LAST LOOP
        IF v_nums.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE('Index ' || i || ': ' || v_nums(i));
        END IF;
    END LOOP;
END;
/
```

## ⚠️ Common Mistakes
- Forgetting to initialize with constructor before using elements
- Assuming no gaps after `DELETE`
- Using `COUNT` as last index in sparse nested tables

## 💡 Tips
- Use constructors like `t_type(...)` for quick initialization
- For sparse cases, combine range loop with `EXISTS`
- Use nested tables when you need SQL and PL/SQL interoperability
