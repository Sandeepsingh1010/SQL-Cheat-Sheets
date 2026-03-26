# HR Database Setup Guide

Complete SQL script to set up a practice database with sample data.

## 📋 Overview

The `hr_database_setup.sql` script creates a complete HR Company database with:
- **6 Tables** with proper constraints and relationships
- **5 Sequences** for auto-incrementing primary keys
- **13 Indexes** for query optimization
- **60+ Sample Records** ready for practice

## 🎯 What Gets Created

### Tables (with relationships)
1. **job_titles** - Job positions and salary ranges
2. **departments** - Company departments with budgets
3. **employees** - Employee records with hierarchical manager relationships
4. **projects** - Company projects in progress
5. **assignments** - Employees assigned to projects
6. **salary_history** - Historical salary changes

### Constraints & Integrity
- ✅ PRIMARY KEY constraints
- ✅ FOREIGN KEY constraints (referential integrity)
- ✅ UNIQUE constraints
- ✅ NOT NULL constraints
- ✅ CHECK constraints (validation)
- ✅ DEFAULT values

### Database Objects
- ✅ 5 Sequences for auto-generating IDs
- ✅ 13 Indexes on frequently queried columns
- ✅ Proper data types and sizes

### Sample Data
- ✅ 15 Employees (CEO to Junior Dev)
- ✅ 6 Departments
- ✅ 10 Job Titles
- ✅ 6 Projects
- ✅ 15 Project Assignments
- ✅ 5 Salary History Records

## 🚀 How to Run

### Option 1: Using SQL Developer (GUI)
1. Open SQL Developer
2. Connect to your database
3. File → Open → Select `hr_database_setup.sql`
4. Click Execute (F5) or Run Script (F9)
5. Review the verification output at the bottom

### Option 2: Using SQL*Plus (Command Line)
```bash
sqlplus username/password@database_name
SQL> @hr_database_setup.sql
```

### Option 3: Using SQLcl
```bash
sql username/password@database_name
SQL> @hr_database_setup.sql
```

## ⚠️ Important Notes

### What This Script Does
1. **Drops existing objects** - Removes old tables, sequences if they exist
2. **Creates sequences** - For auto-incrementing primary keys
3. **Creates tables** - With all constraints and relationships
4. **Creates indexes** - For performance optimization
5. **Inserts sample data** - 60+ records for practice
6. **Displays verification** - Shows record counts and data summary

### Prerequisites
- Connected to an Oracle database
- Proper privileges to create/drop tables, sequences, indexes
- Enough tablespace for the data

### Database Compatibility
- Oracle 11g or newer
- Works with Oracle 12c, 18c, 19c, 21c

## 📊 Data Structure

```
                    employees (1001-1015)
                         ↑
            ┌────────────┼────────────┐
            ↓            ↓            ↓
        CEO(1)      VP_SALES(2)  VP_TECH(3)
            ↓            ↓            ↓
      departments   managers     employees
            ↓
         projects (1-6)
            ↓
      assignments
      (employees → projects)
            ↓
      salary_history
```

## 🔍 Practice Scenarios

This setup allows you to practice:

### Basic Queries (SELECT, WHERE)
```sql
SELECT * FROM employees WHERE dept_id = 3;
SELECT emp_id, first_name, salary FROM employees WHERE salary > 100000;
```

### JOINs
```sql
SELECT e.first_name, d.dept_name, j.job_title
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
JOIN job_titles j ON e.job_id = j.job_id;
```

### Aggregations (GROUP BY, HAVING)
```sql
SELECT dept_id, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 80000;
```

### Subqueries
```sql
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### Self-JOINs (Manager relationships)
```sql
SELECT e.first_name AS employee, m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;
```

### Correlated Subqueries
```sql
SELECT first_name FROM employees e
WHERE EXISTS (SELECT 1 FROM assignments a WHERE a.emp_id = e.emp_id);
```

### Window Functions (advanced)
```sql
SELECT first_name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;
```

## 📈 Data Distribution

| Topic | Count | Details |
|-------|-------|---------|
| Employees | 15 | Mix of roles: CEO, VPs, Managers, Developers, Analysts |
| Departments | 6 | Executive, Sales, Technology, Marketing, HR, Finance |
| Projects | 6 | 3 Active, 1 Planning (future), 1 Completed, varies by status |
| Assignments | 15 | Employees assigned to multiple projects |
| Salary History | 5 | Track salary changes and promotions |
| Job Titles | 10 | Various positions with min/max salary ranges |

## 🎓 Learning Path with This Data

1. **Start with Simple Queries**
   - `SELECT * FROM employees;`
   - `SELECT * FROM departments;`

2. **Add Filtering**
   - `WHERE dept_id = 3`
   - `WHERE status = 'ACTIVE'`

3. **Learn JOINs**
   - `INNER JOIN` employees with departments
   - `LEFT JOIN` departments with employees

4. **Practice Filtering**
   - `IN` / `NOT IN` operators
   - `EXISTS` / `NOT EXISTS`

5. **Aggregation Practice**
   - `COUNT()`, `AVG()`, `SUM()`
   - `GROUP BY`, `HAVING`

6. **Complex Queries**
   - Correlated subqueries
   - Multiple JOINs
   - Set operations

## 💡 Tips for Practice

1. **Start simple** - Run basic SELECT queries first
2. **Test JOINs** - Try joining 2, then 3 tables
3. **Use WHERE wisely** - Filter before aggregating
4. **Check relationships** - Understand foreign keys before writing complex queries
5. **Review sample data** - Understand what data represents what
6. **Re-run script** - You can re-run anytime to reset data
7. **Modify and experiment** - Practice changing the INSERT statements

## 🔄 Reset Data

If you want to start fresh:
```sql
@hr_database_setup.sql
```

This drops all objects and recreates them with fresh sample data.

## 📝 Customization

To modify the script:
1. Change employee names/data in INSERT statements
2. Add more sample records
3. Modify salary ranges in job_titles
4. Add more projects or assignments
5. Modify constraints based on your needs

## ✅ Verification Queries

Run these to verify setup was successful:

```sql
-- Check all tables exist
SELECT table_name FROM user_tables WHERE table_name LIKE '%' ORDER BY table_name;

-- Count records in each table
SELECT 'Employees' AS tbl, COUNT(*) FROM employees
UNION ALL SELECT 'Departments', COUNT(*) FROM departments
UNION ALL SELECT 'Projects', COUNT(*) FROM projects
UNION ALL SELECT 'Assignments', COUNT(*) FROM assignments;

-- Check sequences are working
SELECT emp_seq.NEXTVAL FROM dual;

-- Check indexes exist
SELECT index_name, table_name FROM user_indexes WHERE table_name IN ('EMPLOYEES', 'DEPARTMENTS', 'PROJECTS');
```

## ❓ FAQ

**Q: Can I run this multiple times?**
A: Yes! Each run drops old objects and creates fresh data.

**Q: What if I get permission errors?**
A: You may need DBA privileges or contact your database administrator.

**Q: Can I modify the data?**
A: Yes! After setup, you can INSERT, UPDATE, DELETE as needed for practice.

**Q: How much space does this take?**
A: Very minimal - less than 1MB of storage.

---

Ready to practice SQL? Run the script and start querying! 🚀
