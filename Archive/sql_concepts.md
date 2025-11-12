# SQL Functions Deep Dive — Learning Syllabus  

*Focus: Microsoft SQL Server (T-SQL) Functions, Persistence, and Practical Design*

---

## 🧭 Overview

This syllabus is designed to build complete understanding of **functions in T-SQL** — how they are created, categorized, executed, and optimized.  
By the end, you’ll understand how to **design deterministic functions**, **use them in computed columns**, and **apply them safely for production use cases** such as text normalization, analytics, and automated data cleaning.

---

## 📘 SECTION 1 — Function Fundamentals

### 1.1 What Is a Function in SQL?

- Definition: reusable routines that return a value or table.
- Comparison: Functions vs Stored Procedures.
- The role of `RETURN` and `OUTPUT` parameters.
- either returns a single value ```scalar```
- or, a table result set.

**Functions transform input into output without altering underlying data.**

#### Table Example

| Feature               | Function                                                                    | Stored Procedure                                      |
| --------------------- | --------------------------------------------------------------------------- | ----------------------------------------------------- |
| **Purpose**           | Compute and return a value or table                                         | Perform operations that may change data               |
| **Return type**       | Must return a value (using `RETURN` or `RETURNS TABLE`)                     | May return none or many (`OUTPUT`, `SELECT`, `PRINT`) |
| **Side effects**      | Cannot `INSERT`, `UPDATE`, `DELETE`, or modify schema                       | Can modify data and call functions                    |
| **Usage in queries**  | Can be used anywhere an expression is valid (`SELECT`, `WHERE`, `ORDER BY`) | Cannot appear inside a query expression               |
| **Performance scope** | Usually lightweight and deterministic                                       | Often used for batch logic or multi-step processes    |

**Functions = formulas vs Stored procedures = scripts.**

### 1.2 Types of Functions

- **System functions** — built-in (`LEN`, `GETDATE`, `UPPER`, `ABS`).
- **User-defined functions (UDFs)** — written by developers.
  - Scalar-valued
  - Inline table-valued
  - Multi-statement table-valued
- Comparison table of all three types.

### 1.3 Creating a Simple Scalar Function

- Syntax: `CREATE FUNCTION fn_Name (@param TYPE) RETURNS TYPE AS BEGIN ... END`
- Example: `fn_ReverseString`, `fn_CleanWord`
- Using functions inside `SELECT` and `WHERE`.

---

## 🧩 SECTION 2 — Determinism, Persistence, and Schema Binding

### 2.1 Deterministic vs Non-Deterministic

- Definitions and examples:
  - Deterministic → always same input = same output (e.g., `ABS(-5)`).
  - Non-deterministic → output varies (`GETDATE()`, `NEWID()`).
- Why determinism matters for **persisted computed columns** and **indexes**.

### 2.2 Computed Columns and Persistence

- Syntax for computed columns:  
  `ALTER TABLE dbo.Table ADD Column AS fn_Function(Field) [PERSISTED];`
- Difference between virtual (non-persisted) and physical (persisted) columns.
- How SQL Server checks determinism internally.
- The *“cannot be persisted because the column is non-deterministic”* error — meaning and fixes.

### 2.3 Schema Binding

- `WITH SCHEMABINDING` explained.
- How schema binding prevents breaking dependencies.
- When to apply it in production functions.

---

## ⚙️ SECTION 3 — Advanced Function Design

### 3.1 Inline vs Multi-Statement Table-Valued Functions

- Inline TVF: like a parameterized view.
- Multi-statement TVF: procedural logic returning a table variable.
- Pros, cons, and performance implications.

### 3.2 Function Performance & Execution Plans

- How SQL Server treats UDFs internally.
- Scalar UDF inlining (SQL 2019+ optimization).
- When to avoid UDFs inside heavy queries.
- Profiling function calls with `SET STATISTICS IO, TIME ON`.

### 3.3 Practical Optimizations

- Use deterministic string logic (`UPPER`, `SUBSTRING`, etc.).
- Avoid loops and cursors — leverage sets.
- Inline function alternatives using `CROSS APPLY`.

---

## 🧱 SECTION 4 — Practical Applications

### 4.1 Text Manipulation Functions

- `fn_SortLetters` (Anagram logic refresher)
- `fn_CleanWord` (remove punctuation, normalize casing)
- `fn_CountVowels`, `fn_ReverseString`

### 4.2 Data Quality & Analytics

- Using functions in validation workflows.
- Creating computed columns for text normalization.
- Aggregating results via views or stored procs.

### 4.3 Function Chaining and Reuse

- Nesting UDFs (`fn_CleanWord` → `fn_SortLetters`)
- Using scalar functions inside views or table functions.
- Ensuring safe execution order.

---

## 📊 SECTION 5 — Integration and Maintenance

### 5.1 Functions in Computed Columns

- Revisiting `SortedWord` pattern.
- Updating function logic safely:
  - Drop dependent columns.
  - Alter function.
  - Re-add column.

### 5.2 Indexing Computed Columns and UDF Outputs

- How to index deterministic expressions.
- Creating indexed views that use functions.

### 5.3 Testing and Version Control

- Versioning functions (`fn_Name_v1`, `_v2`, `_archived`).
- Using scripts for migration and rollback.
- Verifying results with unit-style tests.

---

## 🧠 SECTION 6 — Admin and Diagnostic Use

### 6.1 Exploring Metadata

- System catalog views:
  - `sys.objects`
  - `sys.sql_modules`
  - `sys.parameters`
- Query to list all functions and definitions.

### 6.2 Tracking Function Dependencies

- `sys.sql_expression_dependencies`
- How to find which tables or views depend on a function.

### 6.3 Security and Permissions

- Granting execution permissions to specific roles:

  ```sql
  GRANT EXECUTE ON dbo.fn_SortLetters TO [readonly_user];
  ```

- Revoking and auditing function usage.

## 🧮 SECTION 7 — Case Study: Anagram Puzzle Expansion

### 7.1 Recap: `fn_SortLetters` and Computed Column

- **Logic flow:** word → split → sort → join  
- **Topics covered:** Determinism analysis and computed column behavior.

---

### 7.2 Building `fn_CleanWord`

- Create a **pipeline** to sanitize text before sorting.  
- Strip punctuation, trim whitespace, and normalize casing.  
- Ensure deterministic logic for persisted computed columns.

---

### 7.3 Creating `vw_AnagramFamilies`

- Build a **view** that aggregates all words by `SortedWord`.  
- Add analytical metrics:
  - Total count of words per family  
  - Comma-separated word list  
  - Average word length per family  

---

### 7.4 Admin Queries

- Count **orphans** (words with no anagrams).  
- Identify **top families** (largest anagram groups).  
- Prepare **export-ready analytics** for reporting or dashboards.

---

## 🧾 SECTION 8 — Appendix

### 8.1 Function Naming Conventions

- Prefix scalar functions with `fn_`.  
- Always use **schema-qualified names**, e.g. `dbo.fn_SortLetters`.

---

### 8.2 Useful Built-in Functions (Quick Reference)

**String:**  
`LEN`, `UPPER`, `SUBSTRING`, `REPLACE`, `CHARINDEX`  

**Numeric:**  
`ROUND`, `ABS`, `FLOOR`, `CEILING`  

**Date:**  
`GETDATE`, `DATEADD`, `DATEDIFF`  

**Metadata:**  
`OBJECT_ID`, `DB_NAME`

---

### 8.3 Suggested Practice Exercises

1. Write `fn_ReverseString`.  
2. Write `fn_GetInitials('John Doe') → 'JD'`.  
3. Write `fn_RemoveVowels('Vocab') → 'Vcb'`.  
4. Write a **table-valued function** returning all anagram pairs.

---

## 🏁 Suggested Learning Flow

1. Start with **Section 1** for foundations.  
2. Move to **Section 2** when ready for persistence & determinism.  
3. Work through **Section 4** in parallel with your **VocabDB project**.  
4. Save **Sections 5–6** for admin/devops learning.  
5. Use **Section 7** as your **capstone project** for real-world integration.

---

### ✍️ Author’s Note

Use `-- SECTION X.Y` comments inside `.sql` files to mirror this syllabus.  
That way, each concept has a real script counterpart you can expand on later.

