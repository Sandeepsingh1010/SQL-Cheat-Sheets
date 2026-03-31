# PL/SQL Loops

## 📌 Concept
Loops repeat a block of code multiple times based on conditions or across collections.

## 🧾 Syntax

### Simple Loop
```sql
LOOP
    statements;
    EXIT WHEN condition;
END LOOP;
```

### FOR Loop
```sql
FOR counter IN 1..10 LOOP
    statements;
END LOOP;
```

### WHILE Loop
```sql
WHILE condition LOOP
    statements;
END LOOP;
```

## ✅ Example
```sql
DECLARE
    v_count NUMBER := 1;
    v_total NUMBER := 0;
BEGIN
    -- Simple loop with EXIT
    LOOP
        v_total := v_total + v_count;
        v_count := v_count + 1;
        EXIT WHEN v_count > 10;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Sum 1-10: ' || v_total);

    -- FOR loop
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Number: ' || i);
    END LOOP;

    -- FOR loop REVERSE
    FOR i IN REVERSE 5..1 LOOP
        DBMS_OUTPUT.PUT_LINE('Countdown: ' || i);
    END LOOP;

    -- WHILE loop
    v_count := 1;
    WHILE v_count <= 3 LOOP
        DBMS_OUTPUT.PUT_LINE('While: ' || v_count);
        v_count := v_count + 1;
    END LOOP;
END;
/
```

## ⚠️ Common Mistakes
- Infinite LOOP without EXIT condition
- Forgetting to increment counter in WHILE
- Using = instead of := in assignment
- Not updating loop variable

## 💡 Tips
- FOR loops manage counter automatically
- Use REVERSE for descending order
- EXIT WHEN ends loop prematurely
- Use CONTINUE to skip to next iteration
- Name loop variables clearly
- Use `LEAST()` to cap loop limits safely (example: `FOR i IN 1..LEAST(v_requested_count, 100) LOOP`)
