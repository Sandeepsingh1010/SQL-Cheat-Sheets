# String Functions

## 📌 Concept
String functions manipulate and analyze text data in Oracle SQL.

## 🧾 Syntax and Examples

### LENGTH
```sql
-- Returns string length
SELECT LENGTH('Hello') FROM dual;  -- Returns 5
```

### UPPER / LOWER / INITCAP
```sql
SELECT UPPER('hello'), LOWER('HELLO'), INITCAP('hello world')
FROM dual;  -- HELLO, hello, Hello World
```

### SUBSTR
```sql
-- Extract substring (position 1-based in Oracle)
SELECT SUBSTR('Hello World', 1, 5) FROM dual;  -- Hello
SELECT SUBSTR('Hello World', 7) FROM dual;     -- World
```

### INSTR
```sql
-- Find position of substring
SELECT INSTR('Hello World', 'o') FROM dual;  -- 5
```

### REPLACE
```sql
-- Replace substring
SELECT REPLACE('Hello World', 'World', 'Oracle') FROM dual;
-- Hello Oracle
```

### TRIM / LTRIM / RTRIM
```sql
-- Remove leading/trailing spaces
SELECT TRIM('  Hello  ') FROM dual;  -- Hello
SELECT LTRIM('  Hello') FROM dual;   -- Hello
SELECT RTRIM('Hello  ') FROM dual;   -- Hello
```

### CONCAT / ||
```sql
-- Concatenate strings
SELECT CONCAT('Hello', ' World') FROM dual;
SELECT 'Hello' || ' ' || 'World' FROM dual;
```

## ✅ Practical Example
```sql
SELECT
    employee_id,
    UPPER(first_name) AS first_name,
    LENGTH(last_name) AS last_name_length,
    SUBSTR(email, 1, INSTR(email, '@') - 1) AS email_prefix
FROM employees;
```

## 💡 Tips
- Positions in Oracle are 1-based, not 0-based
- Use || for concatenation (easier than CONCAT)
- SUBSTR with 3 args: (string, start, length)
- INSTR returns 0 if substring not found
