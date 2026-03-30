# SQL One-Page Summary

## 📌 Quick Reference

### SELECT Statement
```sql
SELECT column1, column2
FROM table_name
WHERE condition
GROUP BY column1
HAVING aggregate_condition
ORDER BY column1;
```

### Data Types
| Type | Use | Example |
|------|-----|---------|
| NUMBER | Numbers, decimals | NUMBER(10,2) |
| VARCHAR2 | Text (variable) | VARCHAR2(50) |
| DATE | Date/time | DATE |
| CHAR | Fixed text | CHAR(10) |

### Common Functions
```sql
-- String Functions
UPPER(), LOWER(), LENGTH(), SUBSTR(), TRIM(), REPLACE()

-- Numeric Functions
ROUND(), TRUNC(), ABS(), MOD(), POWER()

-- Date Functions
SYSDATE, ADD_MONTHS(), MONTHS_BETWEEN(), EXTRACT()

-- Aggregate Functions
COUNT(), SUM(), AVG(), MIN(), MAX(), LISTAGG()

-- NULL Handling
NVL(col, default), COALESCE(col1, col2, default), NULLIF()
```

### JOIN Keywords
```sql
INNER JOIN      -- Matching rows only
LEFT OUTER JOIN -- All left + matching right
RIGHT OUTER JOIN -- All right + matching left
FULL OUTER JOIN -- All data from both
CROSS JOIN      -- Cartesian product
```

### DML Statements
```sql
-- INSERT
INSERT INTO table VALUES (...);

-- UPDATE
UPDATE table SET column = value WHERE condition;

-- DELETE
DELETE FROM table WHERE condition;

-- MERGE
MERGE INTO target USING source ON (condition)
  WHEN MATCHED THEN UPDATE SET ...
  WHEN NOT MATCHED THEN INSERT ...;
```

### DDL Statements
```sql
-- CREATE TABLE
CREATE TABLE name (col datatype constraints);

-- ALTER TABLE
ALTER TABLE name ADD COLUMN / MODIFY COLUMN / DROP COLUMN;

-- DROP TABLE
DROP TABLE name;

-- TRUNCATE
TRUNCATE TABLE name;
```

### Filtering
```sql
WHERE column = value           -- Exact match
WHERE column > value           -- Comparison
WHERE column BETWEEN x AND y   -- Range
WHERE column IN (a, b, c)      -- List
WHERE column LIKE 'pattern'    -- Pattern
WHERE column IS NULL           -- NULL check
WHERE condition1 AND condition2 -- AND operator
WHERE condition1 OR condition2  -- OR operator
```

### Grouping & Aggregation
```sql
GROUP BY column              -- Group rows
HAVING aggregate_condition   -- Filter after grouping
COUNT(*)                     -- Row count
COUNT(DISTINCT column)       -- Unique values
SUM(), AVG(), MIN(), MAX()   -- Aggregates
```

### Sorting & Limiting
```sql
ORDER BY column [ASC|DESC]   -- Sort results
ROWNUM <= n                  -- Limit rows (Oracle)
```

### Subqueries
```sql
-- Scalar subquery (1 row, 1 column)
SELECT (SELECT MAX(salary) FROM employees);

-- IN operator
WHERE column IN (SELECT ...);

-- EXISTS operator
WHERE EXISTS (SELECT 1 FROM ...);
```

### NULL Handling Quick Rules
| Scenario | Result |
|----------|--------|
| 5 + NULL | NULL |
| 'text' = NULL | NULL |
| NULL = NULL | NULL |
| NULL IS NULL | TRUE |
| COUNT(*) | Includes NULL |
| COUNT(col) | Excludes NULL |

## CommonSyntax Errors

| Error | Cause |
|-------|-------|
| ORA-00923 | Missing FROM keyword |
| ORA-00904 | Column not found |
| ORA-00913 | Wrong number of columns |
| ORA-01722 | Invalid number format |
| ORA-02291 | Integrity constraint violated |

## Exam Tips

✓ Test every query before submitting
✓ Check NULL handling in WHERE clauses
✓ Verify GROUP BY includes all non-aggregate columns
✓ Remember DISTINCT vs GROUP BY
✓ Test with actual data
✓ Comment complex logic
✓ Use meaningful aliases
