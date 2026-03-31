# Associative Arrays (Index-By Tables)

## 📌 Concept
Associative arrays store values as key-value pairs in PL/SQL memory.
Used to be called PL/SQL table in older times.

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

## ✅ Example: BULK COLLECT INTO + FORALL (High-Volume Update)
```sql
DECLARE
    TYPE t_emp_id_tab IS TABLE OF employees.employee_id%TYPE INDEX BY PLS_INTEGER;
    TYPE t_raise_tab  IS TABLE OF NUMBER INDEX BY PLS_INTEGER;

    v_emp_ids t_emp_id_tab;
    v_raises  t_raise_tab;
    i         PLS_INTEGER;
BEGIN
    -- Collect target rows into associative arrays in one fetch.
    SELECT employee_id,
           salary * 0.05
    BULK COLLECT INTO v_emp_ids, v_raises
    FROM employees
    WHERE department_id = 50;

    -- Apply updates in bulk (faster than row-by-row updates).
    FORALL idx IN v_emp_ids.FIRST .. v_emp_ids.LAST
        UPDATE employees
        SET salary = salary + v_raises(idx)
        WHERE employee_id = v_emp_ids(idx);

    DBMS_OUTPUT.PUT_LINE('Employees updated: ' || SQL%ROWCOUNT);
END;
/
```

## 🔢 Using COUNT with Associative Arrays
```sql
DECLARE
    TYPE t_code_map IS TABLE OF VARCHAR2(10) INDEX BY PLS_INTEGER;
    v_codes t_code_map;
    i PLS_INTEGER;
BEGIN
    v_codes(10) := 'A';
    v_codes(20) := 'B';
    v_codes(50) := 'C';

    DBMS_OUTPUT.PUT_LINE('COUNT = ' || v_codes.COUNT); -- 3

    -- Do not use: FOR i IN 1..v_codes.COUNT
    i := v_codes.FIRST;
    WHILE i IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(i || ' => ' || v_codes(i));
        i := v_codes.NEXT(i);
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
- Use `BULK COLLECT INTO` and `FORALL` for high-volume PL/SQL operations
