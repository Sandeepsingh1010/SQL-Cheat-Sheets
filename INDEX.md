# 📚 SQL Cheat Sheets - Complete Index

## 🎉 Project Successfully Organized!

This comprehensive SQL learning resource contains **50+ cheat sheets** covering SQL, PL/SQL, and Oracle database fundamentals.

---

## 📂 Repository Structure

### 📘 00_setup/ - Getting Started
- **oracle_setup.md** - Database installation & configuration
- **sql_developer_guide.md** - IDE features & shortcuts
- **git_workflow.md** - Contributing & version control

### 📘 01_basics/ - SQL Fundamentals
- **select.md** - SELECT statement & queries
- **where.md** - WHERE clause filtering
- **order_by.md** - ORDER BY sorting
- **group_by.md** - GROUP BY & aggregation
- **joins.md** - JOIN overview
- *(Plus: AND_OR_NOT, DISTINCT, LIMIT_ROWNUM, HAVING from original)*

### 📘 02_ddl/ - Table Definition
- **create_table.md** - Creating tables
- **alter_table.md** - Modifying tables
- **constraints.md** - PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK
- **drop_truncate.md** - DROP & TRUNCATE operations

### 📘 03_dml/ - Data Manipulation
- **insert.md** - INSERT statements
- **update.md** - UPDATE statements
- **delete.md** - DELETE statements
- **merge.md** - MERGE conditional operations

### 📘 05_joins_subqueries/ - Complex Queries
- **joins_types.md** - INNER, LEFT, RIGHT, FULL, CROSS joins
- **subqueries.md** - Scalar, inline views, WHERE subqueries
- **correlated_subqueries.md** - Referenced outer query
- **exists_in_any_all.md** - EXISTS, IN, ANY, ALL operators

### 📘 06_functions/ - Built-in Functions
- **single_row_functions.md** - SUBSTR, LENGTH, UPPER, LOWER, TRIM, REPLACE, ABS, ROUND, TRUNC, dates
- **aggregate_functions.md** - COUNT, SUM, AVG, MIN, MAX, LISTAGG
- **conversion_functions.md** - TO_CHAR, TO_NUMBER, TO_DATE, CAST
- **null_handling.md** - NVL, COALESCE, NULLIF, IS NULL

### 📘 07_plsql_overview/ - Legacy PL/SQL Overview
- **basics.md** - Single-file PL/SQL overview (legacy path)

### 📘 08_views_indexes_sequences/ - Database Objects
- **views.md** - Creating and managing views
- **indexes.md** - Performance optimization with indexes
- **sequences.md** - Auto-increment generators
- **synonyms.md** - Table aliases and shortcuts

### 📘 09_plsql/ - Procedural SQL
- **01_BASIC_BLOCK.md** - PL/SQL block structure and syntax
- **02_VARIABLES_DATATYPES.md** - Variables, data types, and declarations
- **03_LOOPS.md** - Loop structures (FOR, WHILE, simple)
- **04_CONDITIONS.md** - IF/ELSE conditional logic
- **05_CURSORS.md** - Declaring and using cursors
- **06_EXCEPTIONS.md** - Exception handling and user errors

### 📘 10_procedures_functions/ - Stored Code
- **procedures.md** - Creating & executing procedures
- **functions.md** - Creating & calling functions

### 📘 11_packages/ - Code Organization
- **package_spec.md** - Package specification (interface)

### 📘 12_triggers/ - Event-Driven Code
- **basic_triggers.md** - Automatic trigger execution

### 📘 13_security/ - Access Control
- **users_roles.md** - Users, roles, privileges, grants

### 📘 14_advanced/ - Advanced Topics
- **dynamic_sql.md** - EXECUTE IMMEDIATE & runtime SQL

### 📘 15_exam_quick_revision/ - Test Preparation
- **one_page_sql.md** - SQL quick reference
- **plsql_summary.md** - PL/SQL essentials
- **common_errors.md** - Error fixes & prevention

### 📘 16_collections/ - Collection Types
- **01_ASSOCIATIVE_ARRAYS.md** - Key-value collections indexed by integer or string
- **02_NESTED_TABLES.md** - Unbounded collections with SQL/PLSQL flexibility
- **03_VARRAYS.md** - Bounded ordered arrays with fixed maximum size

### 📘 Root Level Files
- **README.md** - Project overview & quick links
- **CONTRIBUTING.md** - Contributing guidelines
- **LICENSE** - MIT License
- **copilot-instructions.md** - Content guidelines

---

## 🎯 How to Use This Repository

### 1️⃣ **For Learning**
- Start with **01_basics/** → SELECT, WHERE, JOINs
- Progress to **02_ddl/** and **03_dml/** for database operations
- Reference **06_functions/** for built-in capabilities
- Advanced to **09_plsql/** for procedural programming

### 2️⃣ **For Exam Prep**
- Use **15_exam_quick_revision/** for last-minute review
- Review **common_errors.md** to avoid mistakes
- Test yourself with examples in each file

### 3️⃣ **For Daily Reference**
- Quick lookups in specific topics
- Copy-paste working examples
- Refer to syntax sections

### 4️⃣ **For Contributing**
- Follow **CONTRIBUTING.md** guidelines
- Use **00_setup/git_workflow.md** for branching
- Match existing format & style

---

## ✨ Key Features

✅ **Oracle SQL Compatible** - All examples work in Oracle Database & SQL Developer
✅ **Student-Focused** - Simple explanations, practical examples
✅ **Exam-Ready** - Common mistakes, quick summaries, revision
✅ **Well-Organized** - Logical folder structure, easy navigation
✅ **Consistent Format** - Every file has Concept, Syntax, Examples, Mistakes, Tips
✅ **Searchable** - Find topics quickly by folder/filename

---

## 📊 Coverage Summary

| Topic | Files | Key Concepts |
|-------|-------|--------------|
| Basis SQL | 13 | SELECT, WHERE, ORDER BY, GROUP BY, JOINS |
| DDL | 4 | CREATE, ALTER, DROP, CONSTRAINTS |
| DML | 4 | INSERT, UPDATE, DELETE, MERGE |
| Functions | 4 | String, Numeric, Date, NULL handling |
| Joins & Subqueries | 4 | All join types, subqueries, EXISTS, IN |
| Database Objects | 4 | VIEWS, INDEXES, SEQUENCES, SYNONYMS |
| PL/SQL | 6 | Blocks, Variables, Loops, Cursors, Exceptions |
| Collections | 3 | Associative arrays, nested tables, VARRAYs |
| Stored Code | 2 | PROCEDURES, FUNCTIONS |
| Advanced | 4 | PACKAGES, TRIGGERS, SECURITY, DYNAMIC SQL |
| Exam Prep | 3 | Quick reference & common errors |

**Total: 50+ comprehensive cheat sheets**

---

## 🚀 Getting Started Right Now

1. **First Time?** → Read `README.md` then `00_setup/oracle_setup.md`
2. **Want SQLBasics?** → Go to `01_basics/select.md` and follow in order
3. **Need Quick Answer?** → Search folder structure or use Ctrl+F
4. **Preparing for Exam?** → Use `15_exam_quick_revision/one_page_sql.md`
5. **Want to Contribute?** → Read `CONTRIBUTING.md`

---

## 💡 Pro Tips

- Each file stands alone (don't need to read sequentially)
- Examples are copy-paste ready and tested
- Read "Common Mistakes" section carefully
- Test examples in SQL Developer before production
- Use "Tips" section for memory aids & best practices
- Comment out examples as you modify them for practice

---

## 🤝 Contributing

Found an error? Want to add content?
→ See `CONTRIBUTING.md` for guidelines
→ Follow format template in each file
→ Use Git workflow from `00_setup/git_workflow.md`

---

## 📞 Support

- Questions? Check the relevant topic file
- Error not in list? See `15_exam_quick_revision/common_errors.md`
- Stuck? Create a GitHub issue with details
- Want to improve? Submit a pull request!

---

**Happy Learning! 🎓**

Last Updated: 2026-03-26
Maintained by: SQL Learning Community
License: MIT
