# Basic Triggers

## 📌 Concept
A trigger is code that automatically executes in response to specific database events (INSERT, UPDATE, DELETE) on a table.

## 🧾 Syntax
```sql
CREATE [OR REPLACE] TRIGGER trigger_name
[BEFORE|AFTER] [INSERT|UPDATE|DELETE] ON table_name
[FOR EACH ROW]
BEGIN
    trigger_body;
END trigger_name;
/

-- INSTEAD OF trigger (typically on a view)
CREATE [OR REPLACE] TRIGGER trigger_name
INSTEAD OF [INSERT|UPDATE|DELETE] ON view_name
FOR EACH ROW
BEGIN
    trigger_body;
END trigger_name;
/
```

## 🔄 Trigger Type Comparison

| Trigger Type | Applies To | When It Fires | Typical Use |
|--------------|------------|---------------|-------------|
| BEFORE | Tables | Before DML executes | Validation, default values |
| AFTER | Tables | After DML executes | Auditing/logging |
| INSTEAD OF | Views (especially complex views) | Replaces original DML | Route DML to base tables |

## ✅ Examples

### Simple AFTER INSERT Trigger
```sql
CREATE TRIGGER emp_audit_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (
        action, employee_id, first_name, timestamp
    ) VALUES (
        'INSERT', :NEW.employee_id, :NEW.first_name, SYSDATE
    );
END emp_audit_trigger;
/
```

### UPDATE Trigger
```sql
CREATE TRIGGER emp_update_trigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF :NEW.salary < :OLD.salary THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot decrease');
    END IF;

    :NEW.last_updated := SYSDATE;
END emp_update_trigger;
/
```

### INSTEAD OF INSERT Trigger (on View)
```sql
-- Example view joining two tables
CREATE OR REPLACE VIEW emp_dept_v AS
SELECT e.employee_id,
       e.first_name,
       e.department_id,
       d.department_name
FROM employees e
JOIN departments d ON d.department_id = e.department_id;

-- Insert into view by routing to base table(s)
CREATE OR REPLACE TRIGGER emp_dept_v_ins_trg
INSTEAD OF INSERT ON emp_dept_v
FOR EACH ROW
BEGIN
    INSERT INTO employees (employee_id, first_name, department_id)
    VALUES (:NEW.employee_id, :NEW.first_name, :NEW.department_id);
END;
/
```

### INSTEAD OF UPDATE Trigger (on View)
```sql
CREATE OR REPLACE TRIGGER emp_dept_v_upd_trg
INSTEAD OF UPDATE ON emp_dept_v
FOR EACH ROW
BEGIN
    UPDATE employees
    SET first_name = :NEW.first_name,
        department_id = :NEW.department_id
    WHERE employee_id = :OLD.employee_id;
END;
/
```

### DELETE Trigger
```sql
CREATE TRIGGER emp_archive_trigger
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_archive
    SELECT * FROM TABLE(:OLD);
END emp_archive_trigger;
/
```

## ⚠️ Common Mistakes

- Infinite cascading triggers
- Poor trigger performance
- Complex business logic (use procedures instead)
- Forgetting FOR EACH ROW (affects all rows)
- Using INSTEAD OF trigger on a table (it is for views)
- Assuming RAISE_APPLICATION_ERROR only logs; it stops the DML statement

## 💡 Tips

- Use for audit trails, validation
- BEFORE for validation, AFTER for logging
- Use INSTEAD OF triggers to make complex views updatable
- Keep simple; complex logic in procedures
- Document trigger purpose
- Test thoroughly
- Use `RAISE_APPLICATION_ERROR` when you must block invalid data changes
