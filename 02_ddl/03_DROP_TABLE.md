# DROP TABLE Statement

## 📌 Concept
DROP TABLE removes a table and all its data from the database. This action is permanent and cannot be undone.

## 🧾 Syntax
```sql
DROP TABLE table_name;

DROP TABLE table_name CASCADE CONSTRAINTS;
```

## ✅ Example
```sql
-- Drop a single table
DROP TABLE employees;

-- Drop table with foreign key references
DROP TABLE employees CASCADE CONSTRAINTS;

-- Drop and recycle (Oracle feature)
DROP TABLE temp_table;

-- Purge to free space immediately
DROP TABLE temp_table PURGE;
```

## ⚠️ Common Mistakes
- Dropping a table with data you need
- Not considering foreign key constraints
- Forgetting CASCADE CONSTRAINTS if table is referenced
- Not backing up data before dropping

## 💡 Tips
- Always backup before dropping important tables
- Use CASCADE CONSTRAINTS to drop a table referenced by others
- Use PURGE to immediately free space (default: recycle bin)
- In recycle bin, use FLASHBACK TABLE to recover
- Dropped tables go to recycle bin (can be recovered)
