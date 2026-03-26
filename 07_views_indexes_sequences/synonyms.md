# Synonyms

## 📌 Concept
A synonym is an alias for a database object (table, view, procedure, function, sequence, etc.). Provides shorthand access or hides original object location.

## 🧾 Syntax
```sql
CREATE [PUBLIC] SYNONYM synonym_name FOR schema.object_name;
DROP SYNONYM [PUBLIC] synonym_name;
```

## ✅ Examples

### Private Synonym
```sql
-- Simple synonym
CREATE SYNONYM emp FOR employees;

-- Use synonym
SELECT * FROM emp;  -- Same as: SELECT * FROM employees;

-- Synonym for another schema's table
CREATE SYNONYM dept FOR hr.departments;
SELECT * FROM dept;
```

### Public Synonym
```sql
-- All users can access
CREATE PUBLIC SYNONYM countries_pub FOR hr.countries;

-- Any user can query
SELECT * FROM countries_pub;
```

### Synonym for Complex Objects
```sql
-- Synonym for view
CREATE SYNONYM employee_salary_view FOR hr.emp_salary_view;

-- Synonym for procedure
CREATE SYNONYM hire_employee FOR hr.hire_employee_proc;
```

### Drop Synonym
```sql
DROP SYNONYM emp;
DROP PUBLIC SYNONYM countries_pub;
```

## ⚠️ Common Mistakes

- Creating synonym without schema reference (may reference wrong schema)
- Dropping synonym but original table still exists
- Not specifying schema for cross-schema synonyms

## 💡 Tips

- Use for backward compatibility (rename without breaking code)
- Hide original object location (security)
- Simplify long object names
- PUBLIC synonyms shared among all users
- Synonyms don't affect performance
- Check USER_SYNONYMS view to list synonyms
