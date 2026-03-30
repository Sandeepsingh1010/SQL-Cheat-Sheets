# Contributing Guide

Thank you for helping improve the SQL Cheat Sheets! 🎉

## 📋 Before You Start

Read `copilot-instructions.md` for style guidelines and expectations.

## 🎯 How to Contribute

### 1. Adding New Cheat Sheets

- Choose the correct folder based on content type
- Use the standard format (see template below)
- Test all SQL examples in Oracle SQL Developer
- Ensure Oracle compatibility (no MySQL/PostgreSQL-only syntax)

### 2. File Naming Convention

Use lowercase with hyphens:
```
select.md          ✓ Good
02_SELECT.md       ✗ Wrong (use numbers only in 13_exam folder)
select_statement.md ✓ Also acceptable
```

### 3. Standard Format Template

```markdown
# Topic Name

## 📌 Concept
Clear, 2-3 sentence explanation of what this does and when to use it.

## 🧾 Syntax
Generic syntax template in a code block.

## ✅ Example
Working Oracle-compatible example(s).

## ⚠️ Common Mistakes
- Mistake 1 description
- Mistake 2 description

## 💡 Tips
- Useful tip 1
- Useful tip 2
```

### 4. Code Style Requirements

✓ **DO:**
- Use UPPERCASE for SQL keywords: SELECT, WHERE, FROM, etc.
- Use lowercase for table/column names
- Use meaningful aliases (emp instead of e)
- Keep lines under 100 characters
- Use clear, instructive comments
- Add column aliases for clarity

✗ **DON'T:**
- Use lowercase keywords (select, where)
- Use single-letter confusing aliases (a, b, c)
- Add overly complex examples without explanation
- Include non-Oracle syntax
- Write paragraphs of theory (keep explanations short)

### 5. Example Quality Checklist

When adding examples, ensure they:
- [ ] Run without errors in Oracle SQL Developer
- [ ] Use real-world-like table names (employees, orders, products)
- [ ] Include helpful comments explaining the "why"
- [ ] Demonstrate the concept clearly
- [ ] Show at least one practical use case
- [ ] Handle edge cases (NULL values, empty results, etc.)

### 6. Content Guidelines

**Keep it useful:**
- Focus on practical, exam-relevant content
- Highlight commonly tested concepts
- Include "Common Mistakes" for tricky topics
- Add "Tips" with memory aids

**Keep it organized:**
- One main concept per file
- Use consistent terminology
- Link to related topics if helpful
- Avoid duplicating content from other files

### 7. Testing Your Changes

Before submitting:
1. Run all SQL examples in Oracle SQL Developer
2. Verify syntax is correct (no typos)
3. Check formatting (proper indentation, consistent style)
4. Read through for clarity and accuracy
5. Ensure consistent with other files in the folder

### 8. Git Workflow

```bash
# 1. Create a feature branch
git checkout -b add/new-topic-name

# 2. Make your changes and commit
git add .
git commit -m "Add cheat sheet: [Topic Name]"

# 3. Push and create a PR
git push -u origin add/new-topic-name
```

### 9. Commit Message Format

```
Add cheat sheet: [Topic Name]
- Brief description of content
- What SQL concepts are covered
- Examples included

Example: "Add cheat sheet: MERGE Statement
- Explain when to use MERGE
- Basic syntax with examples
- Common mistakes section
- Performance tips"
```

### 10. Review Process

Your PR will be reviewed for:
- ✓ Oracle SQL compatibility
- ✓ Correct formatting and style
- ✓ Clarity and usefulness
- ✓ Examples that work
- ✓ Placement in correct folder
- ✓ No duplicates with existing content

## 📂 Folder Guide

### 00_setup
- Database installation and configuration
- IDE setup (SQL Developer)
- Development workflow

### 01_basics
- SELECT, WHERE, filtering
- Sorting and grouping
- Basic joins overview

### 02_ddl
- Table creation and modification
- Column and table constraints
- Drop and truncate operations

### 03_dml
- Insert, update, delete
- Bulk operations
- Conditional operations (MERGE)

### 05_joins_subqueries
- All join types
- Subqueries and derived tables
- Advanced filtering

### 06_functions
- Built-in SQL functions
- String, numeric, date operations
- NULL handling

### 07_plsql_overview
- Legacy single-file PL/SQL summary

### 08_views_indexes_sequences
- View creation and management
- Index strategies
- Sequence generators

### 09_plsql
- PL/SQL blocks and structure
- Variables and control flow
- Cursors and loops

### 10_procedures_functions
- Procedural programming
- Function creation and usage
- Parameter passing

### 11_packages
- Package organization
- Public vs private procedures
- Package design patterns

### 12_triggers
- Event-driven programming
- Audit and validation
- Complex trigger logic

### 13_security
- User management
- Permission control
- Data dictionary queries

### 14_advanced
- Performance optimization
- Dynamic SQL
- Advanced cursor techniques

### 15_exam_quick_revision
- Condensed summaries
- Quick reference
- Common errors

### 16_collections
- Associative arrays
- Nested tables
- VARRAYs
- Collection methods and iteration patterns

### examples/
- Mini-projects combining multiple concepts
- Real-world scenarios
- Practice exercises

## ❓ Questions?

- Check existing files for examples
- Review `copilot-instructions.md`
- Open an issue for discussion

## 🙏 Thank You!

Your contributions help make this a valuable resource for SQL learners everywhere.

Happy coding! 🚀
