# Conversion Functions

## 📌 Concept
Conversion functions transform data from one type to another (number to string, string to number, string to date, etc.).

## 🧾 Common Conversions

| From | To | Function |
|------|-------|----------|
| String | Number | TO_NUMBER |
| Number | String | TO_CHAR |
| String | Date | TO_DATE |
| Date | String | TO_CHAR |
| Any | String | CAST or TO_CHAR |
| Any | VARCHAR2 | CAST |

## ✅ Examples

### TO_CHAR (Convert to String)

#### Numbers to Strings
```sql
-- Simple conversion
SELECT TO_CHAR(12345) FROM dual;                    -- '12345'

-- With format codes
SELECT TO_CHAR(12345, '99,999') FROM dual;         -- '12,345'
SELECT TO_CHAR(12345, '$99,999') FROM dual;        -- '$12,345'
SELECT TO_CHAR(12345, '000000') FROM dual;         -- '012345'

-- Format salary in report
SELECT
    first_name,
    TO_CHAR(salary, '$99,999.99') AS formatted_salary
FROM employees;
```

#### Dates to Strings
```sql
-- Common date formats
SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY') FROM dual;        -- 26-Mar-2026
SELECT TO_CHAR(SYSDATE, 'MM/DD/YYYY') FROM dual;         -- 03/26/2026
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual;         -- 2026-03-26
SELECT TO_CHAR(SYSDATE, 'DD Month YYYY') FROM dual;      -- 26 March 2026
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM dual;         -- 14:30:45

-- Format hire dates
SELECT
    first_name,
    TO_CHAR(hire_date, 'DD-MON-YYYY') AS hire_date_formatted
FROM employees
ORDER BY hire_date;
```

### TO_NUMBER (Convert to Number)

```sql
-- Simple conversion
SELECT TO_NUMBER('12345') FROM dual;               -- 12345

-- With format
SELECT TO_NUMBER('12,345', '99,999') FROM dual;    -- 12345
SELECT TO_NUMBER('$1,234.56', '$9,999.99') FROM dual;  -- 1234.56

-- Convert strings from database
SELECT
    employee_id,
    TO_NUMBER(SUBSTR(employee_id, 1, 3)) AS emp_prefix
FROM employees;
```

### TO_DATE (Convert to Date)

```sql
-- Simple conversion
SELECT TO_DATE('26-MAR-2026', 'DD-MON-YYYY') FROM dual;
SELECT TO_DATE('2026/03/26', 'YYYY/MM/DD') FROM dual;
SELECT TO_DATE('03-26-2026', 'MM-DD-YYYY') FROM dual;

-- Parse date strings
SELECT
    employee_id,
    TO_DATE(hire_date_string, 'YYYYMMDD') AS parsed_date
FROM temp_employees;

-- With timestamp
SELECT TO_DATE('2026-03-26 14:30:45', 'YYYY-MM-DD HH24:MI:SS')
FROM dual;
```

### CAST (Alternative Syntax)

```sql
-- CAST for conversions
SELECT CAST('12345' AS NUMBER) FROM dual;
SELECT CAST(12345 AS VARCHAR2(10)) FROM dual;
SELECT CAST('2026-03-26' AS DATE) FROM dual;

-- More readable in some queries
SELECT
    employee_id,
    first_name,
    CAST(salary AS VARCHAR2(10)) AS salary_string
FROM employees;
```

### Implicit Conversions (Usually Automatic)
```sql
-- Oracle automatically converts in many cases
SELECT * FROM employees WHERE employee_id = '100';  -- String to number
SELECT * FROM employees WHERE salary > '5000';      -- String to number (slower)
```

## ⚠️ Common Mistakes

- Wrong date format (causes error or wrong date)
  ```sql
  -- ✗ WRONG - format doesn't match input
  SELECT TO_DATE('2026/03/26', 'DD-MM-YYYY') FROM dual;

  -- ✓ RIGHT
  SELECT TO_DATE('2026/03/26', 'YYYY/MM/DD') FROM dual;
  ```

- Not accounting for NULL values
- Format code case sensitivity (YYYY vs yyyy both work, but MM means month)
- Performance impact of conversions in WHERE clause
- Implicit conversion vs explicit (explicit usually faster)

## 💡 Tips

- Always explicitly specify date format when converting strings
- Use TO_CHAR for nice formatted output/reports
- Use TO_NUMBER for calculations on string columns
- Use TO_DATE consistently for date inputs
- Test format codes with sample data first
- Performance: Convert before WHERE clause if possible
- Use CAST for ANSI-SQL compatibility
- NLS_TERRITORY/NLS_LANGUAGE affect default formats
