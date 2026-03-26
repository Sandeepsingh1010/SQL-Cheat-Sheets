# ALTER TABLE Statement

## 📌 Concept
ALTER TABLE modifies existing table structure: add, drop, or modify columns, or add/drop constraints.

## 🧾 Syntax
```sql
-- Add column
ALTER TABLE table_name ADD column_name datatype;

-- Modify column
ALTER TABLE table_name MODIFY column_name datatype;

-- Drop column
ALTER TABLE table_name DROP COLUMN column_name;

-- Add constraint
ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column);
```

## ✅ Example
```sql
-- Add new column
ALTER TABLE employees ADD phone_number VARCHAR2(20);

-- Modify column size
ALTER TABLE employees MODIFY first_name VARCHAR2(100);

-- Add NOT NULL constraint
ALTER TABLE employees MODIFY email VARCHAR2(100) NOT NULL;

-- Drop a column
ALTER TABLE employees DROP COLUMN phone_number;

-- Add UNIQUE constraint
ALTER TABLE employees ADD CONSTRAINT uk_email UNIQUE (email);

-- Add FOREIGN KEY
ALTER TABLE employees
ADD CONSTRAINT fk_dept FOREIGN KEY (department_id) REFERENCES departments(department_id);
```

## ⚠️ Common Mistakes
- Attempting to modify a column with existing data incompatibly
- Dropping a column referenced by another table
- Not naming constraints (harder to manage later)
- Trying to add NOT NULL to an empty column

## 💡 Tips
- Name constraints explicitly (uk_*, fk_*, pk_*, ck_*)
- Can't reduce VARCHAR2 size if data exists
- SET UNUSED is safer than DROP for large tables
- MODIFY changes structure, SET UNUSED delays changes
