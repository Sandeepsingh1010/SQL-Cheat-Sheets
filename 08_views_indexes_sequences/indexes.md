# Indexes

## 📌 Concept
Indexes speed up queries by organizing data for faster lookup, similar to a book's index. Without indexes, SQL must scan entire table.

## 🧾 Types of Indexes

| Type | Purpose | Use Case |
|------|---------|----------|
| B-Tree | Default, general purpose | Most queries |
| Unique | Enforces uniqueness | Alternative keys |
| Composite | Multiple columns | WHERE with multiple conditions |
| Full-Text | Text searching | LIKE queries |
| Bitmap | Low-cardinality | Data warehouse |

## ✅ Examples

### Create Single-Column Index
```sql
-- Basic index
CREATE INDEX idx_emp_dept ON employees(department_id);

-- Named index for uniqueness (without constraint)
CREATE UNIQUE INDEX idx_emp_email ON employees(email);

-- Index with descending order
CREATE INDEX idx_emp_salary_desc ON employees(salary DESC);
```

### Composite Index
```sql
-- Multiple columns
CREATE INDEX idx_emp_dept_job ON employees(department_id, job_id);

-- Multiple columns with different sort orders
CREATE INDEX idx_emp_complex ON employees(department_id ASC, salary DESC);
```

### Drop Index
```sql
DROP INDEX idx_emp_dept;
```

### Query Performance Comparison
```sql
-- Without index - slow (full table scan)
SELECT * FROM employees WHERE email = 'john@example.com';

-- With index on email - fast (index lookup)
CREATE INDEX idx_emp_email ON employees(email);
SELECT * FROM employees WHERE email = 'john@example.com';  -- Much faster
```

## When to Index

```sql
-- Good index candidates: Frequently searched columns
CREATE INDEX idx_product_category ON products(category);

-- Columns in JOIN conditions
CREATE INDEX idx_order_customer ON orders(customer_id);

-- WHERE clause columns
CREATE INDEX idx_emp_hire_date ON employees(hire_date);

-- ORDER BY columns
CREATE INDEX idx_sales_date ON sales(sale_date DESC);
```

## ⚠️ Common Mistakes

- Over-indexing (slows INSERT/UPDATE)
- Creating indexes on small tables (no benefit)
- Not indexing columns used in WHERE clauses
- Creating duplicate indexes
- Assuming all indexes speed up queries (some slow them down)

## 💡 Tips

- Primary key automatically indexed
- Foreign keys should be indexed
- Check execution plan to see if index used
- Balance: more indexes = faster SELECT, slower INSERT/UPDATE
- Regular index maintenance improves performance
- Monitor index usage: DBA_INDEX_USAGE_STATISTICS
