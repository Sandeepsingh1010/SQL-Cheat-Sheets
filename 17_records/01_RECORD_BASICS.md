# PL/SQL Record Basics

## 📌 Concept
A `RECORD` is a composite PL/SQL data type that groups related fields into one variable.

Use records when you want structured in-memory data (similar to a row object) but with only the fields you need.

## 🧾 Syntax
```sql
DECLARE
    TYPE t_employee_rec IS RECORD (
        employee_id NUMBER,
        first_name  VARCHAR2(50),
        salary      NUMBER(10,2)
    );

    v_emp t_employee_rec;
BEGIN
    v_emp.employee_id := 100;
    v_emp.first_name  := 'Steven';
    v_emp.salary      := 24000;

    DBMS_OUTPUT.PUT_LINE(v_emp.first_name || ' - ' || v_emp.salary);
END;
/
```

## ✅ Example
```sql
DECLARE
    TYPE t_order_summary_rec IS RECORD (
        order_id      NUMBER,
        customer_name VARCHAR2(100),
        total_amount  NUMBER(12,2),
        order_status  VARCHAR2(20)
    );

    v_order t_order_summary_rec;
BEGIN
    v_order.order_id      := 501;
    v_order.customer_name := 'ABC Corp';
    v_order.total_amount  := 999.50;
    v_order.order_status  := 'SHIPPED';

    DBMS_OUTPUT.PUT_LINE('Order ' || v_order.order_id || ': ' || v_order.order_status);
END;
/
```

## ⚠️ Common Mistakes
- Declaring field names that conflict with reserved words
- Forgetting that all fields default to NULL unless assigned
- Mixing table column type changes with hardcoded record field types

## 💡 Tips
- Use `%TYPE` in record fields for schema-aligned data types
- Keep record fields focused on one business purpose
- Use dot notation (`v_rec.field_name`) consistently for readability
