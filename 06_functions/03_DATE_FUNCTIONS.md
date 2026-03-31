# Date Functions

## 📌 Concept
Date functions retrieve, format, and manipulate date values in Oracle SQL.

## 🧾 Syntax and Examples

### SYSDATE / SYSTIMESTAMP
```sql
-- Current date/time
SELECT SYSDATE FROM dual;              -- Today's date
SELECT SYSTIMESTAMP FROM dual;         -- With time/timezone
```

### ADD_MONTHS
```sql
-- Add months to date
SELECT ADD_MONTHS(SYSDATE, 3) FROM dual;   -- 3 months from today
SELECT ADD_MONTHS(hire_date, 12) FROM employees;  -- 1 year later
```

### MONTHS_BETWEEN
```sql
-- Months between two dates
SELECT MONTHS_BETWEEN(SYSDATE, hire_date) FROM employees;
```

### NEXT_DAY
```sql
-- Next occurrence of a day
SELECT NEXT_DAY(SYSDATE, 'Friday') FROM dual;
```

### LAST_DAY
```sql
-- Last day of month
SELECT LAST_DAY(SYSDATE) FROM dual;
```

### TRUNC (for dates)
```sql
-- Truncate date to start of period
SELECT TRUNC(SYSDATE, 'MONTH') FROM dual;    -- First of month
SELECT TRUNC(SYSDATE, 'YEAR') FROM dual;     -- First of year
```

### TO_DATE / TO_CHAR
```sql
-- Convert text to date
SELECT TO_DATE('2024-03-26', 'YYYY-MM-DD') FROM dual;

-- Convert date to text
SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY') FROM dual;
```

### Weekday Information (Sunday, Monday, etc.)
```sql
-- Full weekday name (use FM to remove right-padding spaces)
SELECT TO_CHAR(SYSDATE, 'FMDay') AS weekday_name FROM dual;

-- Short weekday name
SELECT TO_CHAR(SYSDATE, 'Dy') AS weekday_short FROM dual;

-- Weekday number based on NLS territory settings
SELECT TO_CHAR(SYSDATE, 'D') AS weekday_number FROM dual;

-- Force English weekday output regardless of session language
SELECT TO_CHAR(SYSDATE, 'FMDay', 'NLS_DATE_LANGUAGE=ENGLISH') AS weekday_en
FROM dual;
```

### Filter Rows by Weekday
```sql
-- Example: only Monday hires
SELECT employee_id, first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'FMDay', 'NLS_DATE_LANGUAGE=ENGLISH') = 'Monday';
```

### Current Time Parts (Without EXTRACT)
```sql
-- Get hour/minute/second as text parts
SELECT
    TO_CHAR(SYSTIMESTAMP, 'HH24') AS current_hour,
    TO_CHAR(SYSTIMESTAMP, 'MI')   AS current_minute,
    TO_CHAR(SYSTIMESTAMP, 'SS')   AS current_second
FROM dual;

-- HH24 text format
SELECT TO_CHAR(SYSTIMESTAMP, 'HH24:MI:SS') AS current_time
FROM dual;
```

### Check Time of Day (Morning/Afternoon/Evening)
```sql
SELECT
    CASE
        WHEN TO_NUMBER(TO_CHAR(SYSTIMESTAMP, 'HH24')) BETWEEN 5 AND 11 THEN 'Morning'
        WHEN TO_NUMBER(TO_CHAR(SYSTIMESTAMP, 'HH24')) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN TO_NUMBER(TO_CHAR(SYSTIMESTAMP, 'HH24')) BETWEEN 17 AND 21 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day
FROM dual;
```

## ✅ Practical Example
```sql
SELECT
    first_name,
    hire_date,
    MONTHS_BETWEEN(SYSDATE, hire_date) AS months_employed,
    ADD_MONTHS(hire_date, 1) AS one_month_after_hire
FROM employees
WHERE hire_date > TO_DATE('2023-01-01', 'YYYY-MM-DD');
```

## 💡 Tips
- SYSDATE is current date (no time precision)
- DATE arithmetic: date + 1 = next day
- Use TO_DATE for string conversions
- TO_CHAR formats dates for display
- Format codes: YYYY (year), MM (month), DD (day)
- Use `TO_CHAR(SYSTIMESTAMP, 'HH24:MI:SS')` for time-of-day checks without EXTRACT
- Use `FMDay` to remove trailing spaces in weekday names
- `TO_CHAR(date, 'D')` depends on NLS territory for weekday numbering
