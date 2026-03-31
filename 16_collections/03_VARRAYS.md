# VARRAYs (Variable-Size Arrays)

## 📌 Concept
VARRAYs are ordered collections with a fixed maximum size.

They are best for small lists where order matters and the upper limit is known in advance.

## 🧾 Syntax
```sql
DECLARE
    TYPE t_top_skills IS VARRAY(5) OF VARCHAR2(30);
    v_skills t_top_skills := t_top_skills('SQL', 'PL/SQL');
BEGIN
    v_skills.EXTEND;
    v_skills(3) := 'Oracle';

    DBMS_OUTPUT.PUT_LINE('First skill: ' || v_skills(1));
END;
/
```

## ✅ Example
```sql
DECLARE
    TYPE t_quarter_targets IS VARRAY(4) OF NUMBER;
    v_targets t_quarter_targets := t_quarter_targets(10000, 12000, 15000);
BEGIN
    v_targets.EXTEND;
    v_targets(4) := 18000;

    FOR i IN 1 .. v_targets.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Q' || i || ': ' || v_targets(i));
    END LOOP;
END;
/
```

## 🔢 Using COUNT with VARRAYs
```sql
DECLARE
    TYPE t_marks IS VARRAY(5) OF NUMBER;
    v_marks t_marks := t_marks(78, 85);
BEGIN
    v_marks.EXTEND;
    v_marks(3) := 91;

    DBMS_OUTPUT.PUT_LINE('COUNT = ' || v_marks.COUNT); -- 3
    DBMS_OUTPUT.PUT_LINE('LIMIT = ' || v_marks.LIMIT); -- 5

    FOR i IN 1 .. v_marks.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Mark ' || i || ': ' || v_marks(i));
    END LOOP;
END;
/
```

## ⚠️ Common Mistakes
- Exceeding declared maximum size (`VARRAY(n)`)
- Treating VARRAYs like unbounded lists
- Forgetting constructor initialization before assigning elements

## 💡 Tips
- Use VARRAYs when order and compact size are important
- Use `LIMIT` to verify maximum capacity
- Prefer nested tables when size can grow unpredictably
