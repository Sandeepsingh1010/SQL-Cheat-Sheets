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
```

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

## 💡 Tips

- Use for audit trails, validation
- BEFORE for validation, AFTER for logging
- Keep simple; complex logic in procedures
- Document trigger purpose
- Test thoroughly
