# PL/SQL Collections

Dedicated coverage for Oracle PL/SQL collection types.

## 📚 Topics Covered

| File | Description |
|------|-------------|
| [01_ASSOCIATIVE_ARRAYS.md](01_ASSOCIATIVE_ARRAYS.md) | Key-value collections indexed by integer or string |
| [02_NESTED_TABLES.md](02_NESTED_TABLES.md) | Unbounded collections that can be used in SQL and PL/SQL |
| [03_VARRAYS.md](03_VARRAYS.md) | Bounded ordered arrays with fixed maximum size |

## 🎯 Learning Path

1. Start with [01_ASSOCIATIVE_ARRAYS.md](01_ASSOCIATIVE_ARRAYS.md)
2. Continue with [02_NESTED_TABLES.md](02_NESTED_TABLES.md)
3. Finish with [03_VARRAYS.md](03_VARRAYS.md)

## 📝 What You'll Learn

- Differences between all Oracle collection types
- Declaration and initialization patterns
- Common methods: COUNT, FIRST, LAST, EXISTS, EXTEND, TRIM, DELETE
- Iteration patterns for dense and sparse collections
- Practical usage examples for each type
- Bulk processing patterns with `BULK COLLECT INTO` and `FORALL`

## 🔢 COUNT Across Collection Types

| Type | What `COUNT` means | Safe loop pattern |
|------|---------------------|-------------------|
| Associative Array | Number of keys currently stored | `FIRST/NEXT` |
| Nested Table | Number of existing elements (can be sparse) | `FIRST..LAST` + `EXISTS(i)` |
| VARRAY | Current number of elements (dense) | `1..COUNT` |
