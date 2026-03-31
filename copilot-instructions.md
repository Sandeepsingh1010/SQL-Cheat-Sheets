# 🤖 GitHub Copilot Instructions – SQL Cheat Sheets Repo

## 📌 Purpose of This Repository
This repository is designed to build a structured collection of **SQL and PL/SQL cheat sheets** for quick reference, learning, and exam preparation.

The focus is on:
- Simple explanations
- Clean syntax examples
- Oracle SQL compatibility
- Easy-to-scan formatting

---

## 🎯 Copilot Expectations

When generating or suggesting code/content, follow these rules:

### 1. Keep It Simple
- Prefer **short, clear examples**
- Avoid overly complex queries unless explicitly required
- Use beginner-friendly syntax

---

### 2. Oracle SQL Focus
- Ensure compatibility with **Oracle SQL / PL/SQL**
- Use:
  - DBMS_OUTPUT.PUT_LINE
  - NUMBER, VARCHAR2
  - Oracle-style joins when needed

---

### 3. Structured Output Format

All cheat sheets should follow this structure:

# Topic Name

## 📌 Concept
Short explanation of the concept

## 🧾 Syntax
```sql
-- generic syntax
```

## ✅ Example
```sql
-- working example (Oracle-compatible)
```

## ⚠️ Common Mistakes
- mistake 1
- mistake 2

## 💡 Tips
- quick useful notes

---

### 4. Code Style Guidelines

- Use **UPPERCASE for SQL keywords**
- Use meaningful aliases
- Keep indentation clean

Example:
```sql
SELECT first_name, last_name
FROM employees
WHERE department_id = 10;
```

---

### 5. File Organization Awareness

Copilot should respect the repo structure:

- 01_basics/ → SELECT, WHERE, GROUP BY
- 02_ddl/ → CREATE, ALTER
- 03_dml/ → INSERT, UPDATE, DELETE
- 04_joins/ → join patterns
- 05_joins_subqueries/ → subqueries and advanced joins
- 06_functions/ → built-in SQL functions
- 07_plsql_overview/ → legacy PL/SQL summary
- 08_views_indexes_sequences/ → views, indexes, sequences, synonyms
- 09_plsql/ → blocks, variables, loops, cursors, exceptions
- 10_procedures_functions/
- 11_packages/
- 12_triggers/
- 13_security/
- 14_advanced/
- 15_exam_quick_revision/
- 16_collections/
- 17_records/
- examples/

Suggestions should match the correct folder topic.

---

### 6. Commenting Style

- Use **learning-focused comments**
- Explain *why*, not just *what*

Example:
```sql
-- Get total salary per department
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;
```

---

### 7. Avoid

❌ No unnecessary complexity  
❌ No non-Oracle syntax (unless specified)  
❌ No long theory paragraphs  
❌ No unformatted outputs  

---

### 8. Encourage Reusability

- Prefer reusable snippets
- Use generic table names like:
  - employees
  - orders
  - bb_basket

---

### 9. Advanced Topics Handling

For advanced topics (Triggers, Packages, Cursors):
- Start with a **basic version**
- Then optionally show a **slightly advanced example**

---

### 10. Exam-Oriented Focus

- Highlight commonly tested concepts
- Prefer practical examples over theory
- Include common mistakes where relevant

---

## 🧠 Goal

Help generate:
- Quick revision material
- Clean SQL examples
- Easy-to-understand PL/SQL blocks

---

## 🚀 Final Note

Copilot should act like a **teaching assistant**, not just a code generator.
Focus on clarity, correctness, and usefulness for students.
