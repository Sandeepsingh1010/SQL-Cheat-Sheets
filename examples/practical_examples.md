# Practical SQL Examples

## 🎯 Real-World Scenarios

### Scenario 1: Employee Salary Report
```sql
-- Find top earners per department with their manager
SELECT
    d.department_name,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.salary,
    m.first_name || ' ' || m.last_name AS manager_name,
    RANK() OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS rank
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > (SELECT AVG(salary) FROM employees)
ORDER BY d.department_name, e.salary DESC;
```

### Scenario 2: Sales Performance Tracking
```sql
-- Track sales with monthly comparison
SELECT
    sales_rep_id,
    rep_name,
    EXTRACT(MONTH FROM sale_date) AS month,
    SUM(amount) AS monthly_sales,
    LAG(SUM(amount)) OVER (PARTITION BY sales_rep_id ORDER BY EXTRACT(MONTH FROM sale_date)) AS prev_month
FROM sales
GROUP BY sales_rep_id, rep_name, EXTRACT(MONTH FROM sale_date)
HAVING SUM(amount) > 10000
ORDER BY sales_rep_id, month;
```

### Scenario 3: Data Audit Trail
```sql
-- Create audit trigger when data changes
CREATE TABLE audit_log (
    change_id NUMBER PRIMARY KEY,
    table_name VARCHAR2(50),
    operation VARCHAR2(10),
    old_value VARCHAR2(4000),
    new_value VARCHAR2(4000),
    changed_by VARCHAR2(50),
    changed_date TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE OR REPLACE TRIGGER emp_audit
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO audit_log (table_name, operation, new_value, changed_by)
        VALUES ('EMPLOYEES', 'INSERT', :NEW.first_name || ':' || :NEW.salary, USER);
    ELSIF UPDATING THEN
        INSERT INTO audit_log (table_name, operation, old_value, new_value, changed_by)
        VALUES ('EMPLOYEES', 'UPDATE', :OLD.salary, :NEW.salary, USER);
    ELSIF DELETING THEN
        INSERT INTO audit_log (table_name, operation, old_value, changed_by)
        VALUES ('EMPLOYEES', 'DELETE', :OLD.first_name || ':' || :OLD.employee_id, USER);
    END IF;
    COMMIT;
END emp_audit;
/
```

### Scenario 4: Bulk Data Load
```sql
-- Load and validate new employee data
DECLARE
    CURSOR new_emp_cursor IS
        SELECT temp_emp_id, first_name, salary, dept_id
        FROM temp_employees
        WHERE processed = 'N';

    v_emp_count NUMBER := 0;
    v_error_count NUMBER := 0;
BEGIN
    FOR emp_rec IN new_emp_cursor LOOP
        BEGIN
            INSERT INTO employees (employee_id, first_name, salary, department_id)
            VALUES (emp_seq.NEXTVAL, emp_rec.first_name, emp_rec.salary, emp_rec.dept_id);

            v_emp_count := v_emp_count + 1;

            UPDATE temp_employees SET processed = 'Y'
            WHERE temp_emp_id = emp_rec.temp_emp_id;

        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                v_error_count := v_error_count + 1;
                INSERT INTO error_log VALUES (emp_rec.temp_emp_id, 'Duplicate ID', SYSDATE);
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Loaded: ' || v_emp_count || ' Errors: ' || v_error_count);
    COMMIT;
END;
/
```

### Scenario 5: Data Synchronization
```sql
-- Sync employee data between two systems
MERGE INTO prod_employees pe
USING staging_employees se
ON (pe.employee_id = se.employee_id)
WHEN MATCHED AND se.last_updated > pe.last_updated THEN
    UPDATE SET
        pe.first_name = se.first_name,
        pe.salary = se.salary,
        pe.department_id = se.department_id,
        pe.last_updated = SYSDATE
WHEN NOT MATCHED THEN
    INSERT (employee_id, first_name, salary, department_id, last_updated)
    VALUES (se.employee_id, se.first_name, se.salary, se.department_id, SYSDATE);
```

### Scenario 6: Recursive Query (Org Hierarchy)
```sql
-- Find all employees under a manager recursively
WITH emp_hierarchy AS (
    -- Start with specific manager
    SELECT employee_id, first_name, manager_id, 0 AS level
    FROM employees
    WHERE employee_id = 100

    UNION ALL

    -- Get all subordinates recursively
    SELECT e.employee_id, e.first_name, e.manager_id, h.level + 1
    FROM employees e
    INNER JOIN emp_hierarchy h ON e.manager_id = h.employee_id
)
SELECT * FROM emp_hierarchy
ORDER BY level, employee_id;
```

## 🛠️ Maintenance Scripts

```sql
-- Find unused indexes
SELECT index_name, table_name
FROM user_indexes
WHERE index_name NOT IN (SELECT index_name FROM user_ind_statistics WHERE access_count > 0);

-- Check table sizes
SELECT table_name, ROUND(bytes/1024/1024, 2) AS size_mb
FROM user_segments
ORDER BY bytes DESC;

-- Find blocked sessions
SELECT a.sid, a.username, b.sql_text
FROM v$session a
JOIN v$sql b ON a.sql_address = b.address;
```

## 📝 Tips for Production

✓ Always test in DEV first
✓ Use transactions for multi-step operations
✓ Create backups before bulk changes
✓ Monitor performance with EXPLAIN
✓ Use bind variables in dynamic SQL
✓ Log important changes
✓ Document complex queries
✓ Version control all code
