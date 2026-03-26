# PL/SQL Conditional Statements

## 📌 Concept
Conditional statements (IF-THEN-ELSE) execute different code blocks based on conditions.

## 🧾 Syntax

### IF-THEN
```sql
IF condition THEN
    statements;
END IF;
```

### IF-THEN-ELSE
```sql
IF condition THEN
    statements;
ELSE
    statements;
END IF;
```

### IF-ELSIF-ELSE
```sql
IF condition1 THEN
    statements;
ELSIF condition2 THEN
    statements;
ELSE
    statements;
END IF;
```

## ✅ Example
```sql
DECLARE
    v_salary NUMBER := 5000;
    v_grade VARCHAR2(1);
BEGIN
    -- Simple IF
    IF v_salary > 10000 THEN
        DBMS_OUTPUT.PUT_LINE('High salary');
    END IF;

    -- IF-ELSE
    IF v_salary > 7000 THEN
        DBMS_OUTPUT.PUT_LINE('Good salary');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Average salary');
    END IF;

    -- IF-ELSIF-ELSE
    IF v_salary >= 10000 THEN
        v_grade := 'A';
    ELSIF v_salary >= 7000 THEN
        v_grade := 'B';
    ELSIF v_salary >= 5000 THEN
        v_grade := 'C';
    ELSE
        v_grade := 'D';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Grade: ' || v_grade);
END;
/
```

## 💡 Tips
- Use ELSIF (not ELSEIF)
- Conditions use =, <>, <, >, <=, >=
- Use AND, OR, NOT for complex conditions
- THEN is required
- NULL comparisons: use IS NULL, not = NULL
