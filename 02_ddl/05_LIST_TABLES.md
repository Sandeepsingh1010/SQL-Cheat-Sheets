# List All Available Tables

## 📌 Concept
The data dictionary stores metadata about database objects. You can query various views to list tables, along with information about their owner, creation date, and other details.

## 🧾 Common Methods

### 1. **List Your Own Tables** (Current User)
```sql
-- Simplest method - list tables you own
SELECT table_name
FROM user_tables
ORDER BY table_name;
```

**Output:**
```
TABLE_NAME
---------------------
EMPLOYEES
DEPARTMENTS
PROJECTS
ORDERS
```

### 2. **List Tables with Details**
```sql
-- Owner, table name, number of rows, creation date
SELECT table_name,
       num_rows,
       created,
       last_ddl_time
FROM user_tables
ORDER BY table_name;
```

### 3. **List All Tables (All Users)** ⚠️ Admin Only
```sql
-- Requires DBA privilege or SELECT on dba_tables
SELECT owner, table_name
FROM dba_tables
ORDER BY owner, table_name;
```

### 4. **List Accessible Tables** (What You Can See)
```sql
-- All tables you have access to, including other users' tables
SELECT owner, table_name
FROM all_tables
ORDER BY owner, table_name;
```

### 5. **Search for Specific Table**
```sql
-- Find tables matching a pattern (case-insensitive)
SELECT table_name
FROM user_tables
WHERE UPPER(table_name) LIKE '%EMP%'
ORDER BY table_name;
```

### 6. **List with Storage Info**
```sql
-- Table name and size information
SELECT table_name,
       num_rows,
       ROUND(bytes/1024/1024, 2) AS size_mb,
       last_ddl_time
FROM user_tables
ORDER BY bytes DESC;
```

## 🔍 Data Dictionary Views

| View | Purpose | Access Level |
|------|---------|--------------|
| `USER_TABLES` | Tables you own | Your tables |
| `ALL_TABLES` | Tables you can access | Your + granted tables |
| `DBA_TABLES` | All tables in database | Admin only |

## ✅ Common Queries

### Find Tables by Owner
```sql
SELECT owner, table_name, num_rows
FROM all_tables
WHERE owner = 'SCOTT'
ORDER BY table_name;
```

### Find Empty Tables
```sql
SELECT table_name, num_rows
FROM user_tables
WHERE num_rows = 0 OR num_rows IS NULL
ORDER BY table_name;
```

### List Tables with Column Count
```sql
SELECT t.table_name,
       COUNT(c.column_name) AS column_count
FROM user_tables t
LEFT JOIN user_tab_columns c ON t.table_name = c.table_name
GROUP BY t.table_name
ORDER BY table_name;
```

### Find Recently Modified Tables
```sql
SELECT table_name, last_ddl_time
FROM user_tables
WHERE last_ddl_time >= TRUNC(SYSDATE) - 7  -- Last 7 days
ORDER BY last_ddl_time DESC;
```

### List Temporary Tables
```sql
SELECT table_name, duration
FROM user_tables
WHERE temporary = 'Y';
```

## 💡 Tips & Tricks

- **USER_TABLES** is always available and fastest for your own tables
- **ALL_TABLES** includes tables from other users you have permissions for
- **DBA_TABLES** requires admin privilege but shows everything
- Use `num_rows` to find unused/empty tables (may be NULL if stats not gathered)
- Run `ANALYZE TABLE tablename COMPUTE STATISTICS;` to update row counts
- For large databases, filter by owner first to reduce query time

## ⚠️ Common Issues

```sql
-- ✗ WRONG - This won't work directly
SELECT * FROM all_tables_in_database;

-- ✓ RIGHT - Use the correct data dictionary view
SELECT * FROM all_tables;

-- ✗ WRONG - Case sensitivity
SELECT * FROM USER_TABLES;  -- May fail on some systems

-- ✓ RIGHT - Use as shown in examples
SELECT * FROM user_tables;
```

## 🔗 Related Dictionary Views

- `user_columns` - Column details
- `user_indexes` - Index information
- `user_constraints` - Constraint details
- `user_views` - View definitions
- `user_sequences` - Sequence objects
