# Records with Cursors

## 📌 Concept
Records and cursors are commonly used together to process query results row by row.

You can fetch into:
- a `%ROWTYPE` record tied to cursor shape
- a custom `RECORD` matching selected columns

## 🧾 Syntax Pattern
```sql
DECLARE
    CURSOR c_emp IS
        SELECT employee_id, first_name, salary
        FROM employees
        WHERE department_id = 10;

    v_emp c_emp%ROWTYPE;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_emp;
        EXIT WHEN c_emp%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_emp.employee_id || ': ' || v_emp.first_name);
    END LOOP;
    CLOSE c_emp;
END;
/
```

## ✅ Example: Custom RECORD with Cursor
```sql
DECLARE
    CURSOR c_sales IS
        SELECT order_id, customer_id, total_amount
        FROM orders
        WHERE total_amount > 1000;

    TYPE t_sales_rec IS RECORD (
        order_id     orders.order_id%TYPE,
        customer_id  orders.customer_id%TYPE,
        total_amount orders.total_amount%TYPE
    );

    v_sale t_sales_rec;
BEGIN
    OPEN c_sales;
    LOOP
        FETCH c_sales INTO v_sale;
        EXIT WHEN c_sales%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Order ' || v_sale.order_id || ' = ' || v_sale.total_amount);
    END LOOP;
    CLOSE c_sales;
END;
/
```

## ✅ Example: BULK COLLECT INTO Record Collection
```sql
DECLARE
    TYPE t_emp_rec IS RECORD (
        employee_id employees.employee_id%TYPE,
        first_name  employees.first_name%TYPE,
        salary      employees.salary%TYPE
    );

    TYPE t_emp_tab IS TABLE OF t_emp_rec;
    v_emps t_emp_tab;
BEGIN
    SELECT employee_id, first_name, salary
    BULK COLLECT INTO v_emps
    FROM employees
    WHERE department_id = 10;

    FOR i IN 1 .. v_emps.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_emps(i).employee_id || ': ' || v_emps(i).first_name);
    END LOOP;
END;
/
```

## ✅ Example: Parameterized Cursor with Variables + RECORD
```sql
DECLARE
    CURSOR c_emp_filtered (p_dept_id NUMBER, p_min_salary NUMBER) IS
        SELECT employee_id, first_name, salary
        FROM employees
        WHERE department_id = p_dept_id
          AND salary >= p_min_salary;

    TYPE t_emp_rec IS RECORD (
        employee_id employees.employee_id%TYPE,
        first_name  employees.first_name%TYPE,
        salary      employees.salary%TYPE
    );

    v_emp t_emp_rec;
    v_dept_id NUMBER := 60;
    v_min_sal NUMBER := 6000;
BEGIN
    OPEN c_emp_filtered(v_dept_id, v_min_sal);
    LOOP
        FETCH c_emp_filtered INTO v_emp;
        EXIT WHEN c_emp_filtered%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_emp.first_name || ' => ' || v_emp.salary);
    END LOOP;
    CLOSE c_emp_filtered;
END;
/
```

## ⚠️ Common Mistakes
- Mismatch between cursor select list and fetch target fields
- Forgetting `EXIT WHEN cursor_name%NOTFOUND`
- Leaving cursor open on early exit paths

## 💡 Tips
- Use cursor FOR loops when possible (auto open/fetch/close)
- Use `%ROWTYPE` for stable query shapes
- Use custom `RECORD` when selecting computed columns
- Use `BULK COLLECT INTO` when many rows are needed in memory at once
- Use parameterized cursors to pass variable filters safely and clearly
