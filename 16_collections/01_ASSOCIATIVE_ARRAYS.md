# Associative Arrays (Index-By Tables)

## 📌 Concept
Associative arrays store values as key-value pairs in PL/SQL memory.

Keys can be numeric (`PLS_INTEGER`) or string (`VARCHAR2`). This type is ideal for fast lookups and temporary maps during procedural logic.

## 🧾 Syntax
```sql
DECLARE
    TYPE t_salary_map IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_salaries t_salary_map;
BEGIN
    v_salaries(100) := 5000;
    v_salaries(101) := 6200;

    DBMS_OUTPUT.PUT_LINE('Emp 100 Salary: ' || v_salaries(100));
END;
/
```

## ✅ Example
```sql
DECLARE
    TYPE t_dept_name_map IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    v_depts t_dept_name_map;
    i PLS_INTEGER;
BEGIN
    v_depts(10) := 'Administration';
    v_depts(20) := 'Marketing';
    v_depts(50) := 'Shipping';

    -- Sparse-safe iteration using FIRST/NEXT
    i := v_depts.FIRST;
    WHILE i IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Dept ' || i || ': ' || v_depts(i));
        i := v_depts.NEXT(i);
    END LOOP;
END;
/
```

## ⚠️ Common Mistakes
- Assuming indexes are always consecutive
- Iterating with `FOR i IN 1..COUNT` on sparse keys
- Reading a key that does not exist without `EXISTS`

## 💡 Tips
- Use associative arrays for fast in-memory lookups
- Prefer `FIRST` and `NEXT` for traversal
- Check existence with `EXISTS(index)` before read operations
