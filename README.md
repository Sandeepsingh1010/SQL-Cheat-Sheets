# SQL Cheat Sheets

A comprehensive guide to Oracle SQL and PL/SQL with practical examples and best practices.

## 📚 Table of Contents

### 🚀 Getting Started
- **[00_setup/](00_setup/)** - Environment setup and configuration
  - Oracle installation
  - SQL Developer IDE
  - Git workflow

### 🎓 Learning Path

#### Level 1: Fundamentals
- **[01_basics/](01_basics/)** - SQL basics (SELECT, WHERE, ORDER BY, GROUP BY)
- **[02_ddl/](02_ddl/)** - Data Definition Language (CREATE, ALTER, DROP)
- **[03_dml/](03_dml/)** - Data Manipulation Language (INSERT, UPDATE, DELETE)

#### Level 2: Intermediate
- **[04_joins/](04_joins/)** - Table joins (INNER, LEFT, RIGHT, FULL, CROSS)
- **[05_joins_subqueries/](05_joins_subqueries/)** - Subqueries and advanced joins
- **[06_functions/](06_functions/)** - SQL functions (string, numeric, date, aggregate)

#### Level 3: Advanced
- **[07_plsql_overview/](07_plsql_overview/)** - Legacy single-file PL/SQL overview
- **[08_views_indexes_sequences/](08_views_indexes_sequences/)** - Database objects
- **[09_plsql/](09_plsql/)** - PL/SQL programming basics
- **[10_procedures_functions/](10_procedures_functions/)** - Stored procedures & functions
- **[11_packages/](11_packages/)** - Package specifications and modular PL/SQL

#### Level 4: Specialized
- **[12_triggers/](12_triggers/)** - Database triggers
- **[13_security/](13_security/)** - Users, roles, and privileges
- **[14_advanced/](14_advanced/)** - Dynamic SQL and advanced topics
- **[15_exam_quick_revision/](15_exam_quick_revision/)** - Exam-focused quick revision
- **[16_collections/](16_collections/)** - PL/SQL collection types (associative arrays, nested tables, VARRAYs)
- **[17_records/](17_records/)** - PL/SQL records (`RECORD`, `%ROWTYPE`, cursor record patterns)

## 🎯 Quick Navigation

| Level | Topic | Files | Description |
|-------|-------|-------|-------------|
| 🌱 Beginner | Basics | 8 files | SELECT, WHERE, GROUP BY, HAVING |
| 🌱 Beginner | DDL | 5 files | CREATE, ALTER, DROP tables |
| 🌱 Beginner | DML | 3 files | INSERT, UPDATE, DELETE data |
| 🌿 Intermediate | Joins | 5 files | INNER, LEFT, RIGHT, FULL, CROSS |
| 🌿 Intermediate | Subqueries | 4 files | IN, EXISTS, ANY, ALL, correlated |
| 🌿 Intermediate | Functions | 8 files | String, Numeric, Date, Aggregate |
| 🌳 Advanced | PL/SQL Overview | 1 file | Legacy single-file summary |
| 🌳 Advanced | Objects | 4 files | Views, Indexes, Sequences |
| 🌳 Advanced | PL/SQL | 6 files | Blocks, Variables, Loops, Cursors, Exceptions |
| 🌳 Advanced | Procedures | 2 files | Stored Procedures & Functions |
| 🌳 Specialized | Packages | 1 file | Package specification |
| 🌳 Specialized | Triggers | 1 file | Basic trigger patterns |
| 🌳 Specialized | Security | 1 file | Users, roles, privileges |
| 🌳 Specialized | Advanced SQL | 1 file | Dynamic SQL |
| 🌳 Specialized | Exam Revision | 3 files | One-page SQL and common errors |
| 🌳 Specialized | Collections | 3 files | Associative arrays, nested tables, VARRAYs |
| 🌳 Specialized | Records | 3 files | RECORD type, %ROWTYPE, cursor fetch patterns |

## 🔍 Featured Topics

### Most Commonly Used
- [01_basics/01_SELECT.md](01_basics/01_SELECT.md) - Basic data retrieval
- [01_basics/02_WHERE.md](01_basics/02_WHERE.md) - Filtering results
- [04_joins/01_INNER_JOIN.md](04_joins/01_INNER_JOIN.md) - Joining tables
- [06_functions/01_STRING_FUNCTIONS.md](06_functions/01_STRING_FUNCTIONS.md) - Text manipulation
- [06_functions/03_DATE_FUNCTIONS.md](06_functions/03_DATE_FUNCTIONS.md) - Date operations

### Advanced Topics
- [05_joins_subqueries/exists_in_any_all.md](05_joins_subqueries/exists_in_any_all.md) - EXISTS, IN, ANY, ALL
- [05_joins_subqueries/correlated_subqueries.md](05_joins_subqueries/correlated_subqueries.md) - Correlated queries
- [08_views_indexes_sequences/views.md](08_views_indexes_sequences/views.md) - Virtual tables
- [09_plsql/05_CURSORS.md](09_plsql/05_CURSORS.md) - Working with cursors
- [16_collections/01_ASSOCIATIVE_ARRAYS.md](16_collections/01_ASSOCIATIVE_ARRAYS.md) - Key-value collection lookups
- [16_collections/02_NESTED_TABLES.md](16_collections/02_NESTED_TABLES.md) - SQL-friendly unbounded collections
- [16_collections/03_VARRAYS.md](16_collections/03_VARRAYS.md) - Ordered collections with fixed size
- [17_records/01_RECORD_BASICS.md](17_records/01_RECORD_BASICS.md) - User-defined RECORD structures
- [17_records/02_ROWTYPE_VS_RECORD.md](17_records/02_ROWTYPE_VS_RECORD.md) - Choosing between %ROWTYPE and RECORD

## 📖 How to Use This Repository

1. **New to SQL?** Start with [00_setup/](00_setup/) for environment setup
2. **Learn Basics?** Follow the [01_basics/](01_basics/) learning path
3. **Need a Reference?** Use the table above to jump to your topic
4. **Looking for Examples?** Each file contains practical SQL examples
5. **Want to Contribute?** See [CONTRIBUTING.md](CONTRIBUTING.md)

## 💡 Key Features

✅ **Real-world examples** - Practical SQL queries you can copy and run
✅ **Best practices** - Performance tips and common mistakes
✅ **Clear explanations** - Concept descriptions with visual aids
✅ **Complete coverage** - From basics to advanced PL/SQL
✅ **Repository structure** - Well-organized folders with README files
✅ **Easy navigation** - GitHub-friendly markdown formatting

## 🎓 Learning Recommendations

**Beginner (Week 1-2)**
- Complete all files in `01_basics/`
- Learn `02_ddl/` basics
- Practice writing basic SELECT queries

**Intermediate (Week 3-4)**
- Master `04_joins/` and `05_joins_subqueries/`
- Learn `03_dml/` for data manipulation
- Practice complex queries

**Advanced (Week 5-6)**
- Dive into `06_functions/`
- Learn `08_views_indexes_sequences/`
- Start with `09_plsql/`

**Expert (Week 7-8)**
- Complete `09_plsql/`
- Build `10_procedures_functions/`
- Master collection types in `16_collections/`
- Master record patterns in `17_records/`
- Explore advanced optimization techniques

## 📋 File Structure

```
SQL-Cheat-Sheets/
├── 00_setup/                    # Environment setup
├── 01_basics/                   # Beginner SQL
├── 02_ddl/                      # Create/Alter/Drop
├── 03_dml/                      # Insert/Update/Delete
├── 04_joins/                    # Table joins
├── 05_joins_subqueries/         # Subqueries
├── 06_functions/                # SQL functions
├── 07_plsql_overview/           # Legacy PL/SQL overview (single-file)
├── 08_views_indexes_sequences/  # Database objects
├── 09_plsql/                    # PL/SQL basics
├── 10_procedures_functions/     # Stored procedures
├── 11_packages/                 # Package specifications
├── 12_triggers/                 # Triggers
├── 13_security/                 # Security
├── 14_advanced/                 # Advanced topics
├── 15_exam_quick_revision/      # Quick revision
├── 16_collections/              # PL/SQL collection types
├── 17_records/                  # PL/SQL record types
├── examples/                    # Practical examples
├── INDEX.md                     # Complete index
├── README.md                    # This file
├── CONTRIBUTING.md              # Contribution guidelines
├── copilot-instructions.md      # Copilot behavior guidance
└── LICENSE                      # MIT License
```

## 🤝 Contributing

Found an error or want to add content? See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 🔗 Additional Resources

- [Oracle Official Documentation](https://docs.oracle.com/en/database/)
- [Oracle SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/)
- [PL/SQL Developer Guide](https://docs.oracle.com/en/database/oracle/oracle-database/)

## 📞 Questions?

- Check the relevant README.md in each folder
- Review the CONTRIBUTING.md file for contribution guidelines
- See existing examples for syntax references

---

**Happy Learning! 🚀**