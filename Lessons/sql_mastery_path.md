# SQL Mastery Path (Revised Edition with Practice Milestones)

*Focus: Microsoft SQL Server (T-SQL) Practical Mastery, with a Foundation-to-Architecture Roadmap*

---

## 🎯 Overview

This roadmap is designed for **deep, mastery-based SQL learning** without rigid timelines. You move at your own pace — faster when concepts click, slower when reflection or repetition is needed. Advancement is based on comprehension, not schedule.

Each phase ends with a **Checkpoint** — not a promotion, but a mastery evaluation. You progress only when you can explain *why* something works, not just *how* it works.

Your personal project, **VocabDB**, serves as the applied learning environment where theory meets practice.

---

## 🧱 A. FOUNDATIONS — "Thinking in SQL"

**Goal:** Build fluency with querying, scalar functions, and deterministic design.

### A1. Query Logic & Set Thinking
- Understand SQL as a *set-based* language.
- Practice filtering, grouping, and sorting with `SELECT`, `WHERE`, `GROUP BY`, and `ORDER BY`.
- Explore how `NULL` behaves differently than empty or zero.
- Observe logic with `TOP`, `DISTINCT`, and sorting order.

**Milestone Tasks:**
1. Write a query showing all words in `dbo.Words` with fewer than 5 characters.
2. Group words by `Category` and find average word length.
3. Create a “sandbox” query using `DISTINCT`, `LEN()`, and ordering.

---

### A2. Scalar & Inline Functions
- Define scalar functions: `fn_CleanWord`, `fn_ReverseString`, and `fn_CountVowels`.
- Learn determinism and schema binding.
- Understand when functions can be persisted in computed columns.

**Milestone Tasks:**
1. Create `fn_CountVowels` to return the number of vowels in a string.
2. Write `fn_CleanWord` to trim, lowercase, and remove punctuation.
3. Create a scalar `fn_ReverseString` and test it inside a `SELECT` query.

---

### A3. Computed Columns
- Create persisted and non-persisted computed columns.
- Apply `fn_SortLetters` to generate a `SortedWord` column.
- Discuss determinism and persistence rules.

**Milestone Tasks:**
1. Add a computed column `WordLength` = `LEN(Word)` to `dbo.Words`.
2. Make it `PERSISTED` and verify determinism.
3. Create `SortedWord` with a deterministic function and test persistence.

---

### A4. Observation and Diagnostics
- Use `SET STATISTICS IO, TIME ON` for performance analysis.
- Review metadata in `sys.objects` and `sys.sql_modules`.
- Learn how SQL tracks dependencies.

**Milestone Tasks:**
1. Enable statistics and compare runtime for scalar vs inline functions.
2. Query all functions using `SELECT name, type FROM sys.objects WHERE type IN ('FN','IF');`
3. Identify where each function is used through `sys.sql_expression_dependencies`.

**Checkpoint A:** You can create, explain, and debug scalar and inline functions, and understand when they can be persisted.

---

## 🔁 B. FLUENCY — "Composing Logic"

**Goal:** Integrate multiple functions, joins, and APPLY operations into clear, optimized workflows.

### B1. JOIN Logic Mastery
- Understand INNER, LEFT, RIGHT, and FULL joins.
- Visualize how joins combine datasets.
- Diagnose mismatched results and missing rows.

**Milestone Tasks:**
1. Join `dbo.Words` and `dbo.Words_Alt` on `Word`.
2. Create an `INNER JOIN` query that returns only matching rows.
3. Convert it to `LEFT JOIN` and observe how unmatched data appears.

---

### B2. CROSS APPLY & OUTER APPLY
- Use APPLY for row-by-row logic.
- Integrate `fn_SplitWord` to analyze each word’s characters.
- Compare APPLY vs JOIN using examples.

**Milestone Tasks:**
1. Use `CROSS APPLY` with `fn_SplitWord` to display each letter of every short word.
2. Switch to `OUTER APPLY` and compare row counts.
3. Explain when APPLY is required instead of a join.

---

### B3. Subqueries vs APPLY
- Learn the difference between set-level subqueries and per-row APPLY.
- Build simple aggregates and per-row analytics.

**Milestone Tasks:**
1. Write a subquery to count letters per word.
2. Rebuild the same logic using `CROSS APPLY`.
3. Compare performance using `SET STATISTICS IO`.

---

### B4. Layered Query Design
- Create nested queries and CTEs for clarity.
- Combine multiple functions in a single query.
- Practice structured indentation and commenting.

**Milestone Tasks:**
1. Create a CTE that filters words > 5 characters, then apply `fn_CountVowels`.
2. Use `fn_SortLetters` and group by sorted pattern to find anagrams.
3. Refactor an existing query into a CTE chain and comment each step.

**Checkpoint B:** You can confidently explain the difference between joins, subqueries, and APPLY, and compose logic across multiple steps.

---

## 🧩 C. APPLICATION — "Building Systems"

**Goal:** Apply SQL in realistic data quality, automation, and analytics workflows.

### C1. Text Analytics with Functions
- Use SQL as an analytical tool.
- Combine scalar and table functions for insights.
- Explore aggregate metrics on text data.

**Milestone Tasks:**
1. Create a query showing top 10 longest words per category.
2. Build a function to count consonants.
3. Develop a report summarizing average word length and vowel ratio.

---

### C2. Data Quality Pipelines
- Create pipelines that standardize text before insert.
- Automate cleanup through computed columns.
- Design persistent normalization layers.

**Milestone Tasks:**
1. Add a column `CleanWord` using `fn_CleanWord`.
2. Build a view `vw_CleanWords` for validated imports.
3. Index key columns and measure query improvements.

---

### C3. Versioning and Diagnostics
- Implement function version control.
- Track dependencies and performance changes.

**Milestone Tasks:**
1. Rename `fn_SortLetters` to `_v2` and document the difference.
2. Use system views to identify functions used in each table.
3. Benchmark runtime between `_v1` and `_v2`.

**Checkpoint C:** You can build and maintain a self-documenting SQL library with reliable data transformations.

---

## 🏗️ D. ARCHITECTURE — "Design & Optimization"

**Goal:** Think like a SQL architect — focusing on optimization, scalability, and maintainability.

### D1. Execution Plans & Cost Analysis
- Read and interpret execution plans.
- Identify heavy operations (scans, lookups, sorts).
- Compare inline vs multi-statement TVFs.

**Milestone Tasks:**
1. Capture an execution plan for `fn_SplitWord` queries.
2. Identify the costliest step in your plan.
3. Suggest an optimization (index or rewrite) and measure improvement.

---

### D2. Indexing and Performance Design
- Optimize computed and deterministic columns.
- Build indexed views to speed up frequent aggregations.

**Milestone Tasks:**
1. Add an index on `WordLength` and check performance.
2. Create a deterministic computed index on `SortedWord`.
3. Compare seek vs scan in the execution plan.

---

### D3. Integration & Automation (Local → Cloud-ready)
- Integrate SQL with external systems.
- Use scripts to automate function deployment.

**Milestone Tasks:**
1. Export SQL query results into CSV using SSMS.
2. Connect SQL data to a Python script.
3. Automate schema backups before function changes.

---

## ☁️ E. POWER BI & AZURE INTEGRATIONS (Self-Paced)

**Goal:** Evolve VocabDB from a local learning lab into a small analytics platform using **Power BI** and **Azure** primitives. Keep scope pragmatic and aligned with mastery checkpoints.

### E1. Power BI: Modeling & Visuals
- Choose **DirectQuery** (live) vs **Import** (cached) based on dataset size.
- Build a tidy star model: **FactWords** (observations) + **DimCategory** (lookup) + optional **DimSource**.
- Create core **DAX measures** for counts, averages, and ratios.

**Milestone Tasks:**
1. Publish a **Power BI report** that shows: Average Word Length by Category, Top Anagram Families, and Vowel% by Category.
2. Add slicers for Category and SourceNote; test interactions.
3. Create three measures:
   - `Avg Word Length = AVERAGEX(VALUES(DimWord[Word]), [WordLength])`
   - `Vowel % = DIVIDE([Total Vowels], [Total Letters])`
   - `Anagram Families = DISTINCTCOUNT(FactWords[SortedWord])`

**Notes:**
- If using **Import**, schedule refresh (8x/day limit on Pro).
- If using **DirectQuery** to Azure SQL, optimize with indexes on filters and relationships.

---

### E2. Power BI: Governance & Sharing
- Define a workspace; set role-based access.
- Implement **Row-Level Security (RLS)** if multiple audiences.

**Milestone Tasks:**
1. Add RLS role `Editors` (all rows) and `Readers` (Category IN ('Noun','Verb')).
2. Validate RLS using the "View as" feature.
3. Document dataset lineage and refresh behavior.

---

### E3. Azure SQL Database (Managed Destination)
- Migrate VocabDB to **Azure SQL Database** for managed availability and integration with Power BI/ADF.
- Use **BACPAC** export/import or **DMA** for schema migration.

**Milestone Tasks:**
1. Create an Azure SQL logical server + database (Basic/DTU or Serverless/vCore).
2. Migrate schema + seed data; verify persisted computed columns & functions.
3. Repoint Power BI to Azure SQL; compare DirectQuery vs Import performance.

**Notes:**
- Ensure functions used by computed columns are deterministic and schema-bound as needed.

---

### E4. Azure Data Factory (Pipelines)
- Orchestrate periodic data loads (e.g., new word lists) into Azure SQL.

**Milestone Tasks:**
1. Build an **ADF pipeline** that copies from Azure Blob Storage → Azure SQL `Staging.WordsRaw`.
2. Add a **Stored Procedure** activity to normalize data into `dbo.Words` using your functions.
3. Parameterize the pipeline for file path and run a scheduled trigger.

---

### E5. Azure Functions (Serverless ETL Helpers)
- Use **Azure Functions** (C#/Python) to perform lightweight text cleanup or file prep.

**Milestone Tasks:**
1. Create a function that cleans a CSV (trim, lowercase, strip punctuation) and uploads to Blob.
2. Emit a queue message consumed by ADF to start the pipeline.
3. Log metrics (rows processed, errors) to Azure Application Insights.

---

### E6. Azure Storage, Key Vault, and Security
- Store raw files in **Blob Storage**.
- Keep secrets (SQL connection strings) in **Key Vault**; access via managed identity.

**Milestone Tasks:**
1. Provision a Storage Account and a private container `vocab-landing`.
2. Create a Key Vault secret `SqlConnString`; configure ADF/Functions to read it.
3. Verify end-to-end without embedding secrets in code.

---

### E7. Azure DevOps / GitHub Actions (CI/CD)
- Automate deployments for SQL and Azure resources.

**Milestone Tasks:**
1. Create an `infra` folder with ARM/Bicep/Terraform (pick one) for Azure SQL + Storage.
2. Add a pipeline that runs SQL migrations (e.g., `sqlpackage` or `SqlCmd` scripts).
3. Gate deployments with a manual approval step.

---

### E8. End-to-End Demo Runbook
- Document a small, repeatable scenario:
  1. Drop a CSV into Blob → ADF loads to staging → Stored Proc transforms → Azure SQL serves the model → Power BI refreshes and displays.
  2. Capture timings and a simple SLA (e.g., <10 minutes pipeline to publish).

**Milestone Tasks:**
1. Author a **RUNBOOK.md** with screenshots of each step.
2. Include a troubleshooting section (timeouts, schema drift, credential issues).
3. Record a short Loom/Teams video walkthrough for personal review.

---

**Checkpoint E:** You can integrate SQL outputs into Power BI visuals and orchestrate simple, secure Azure data flows that you can explain end-to-end.

---

## 🔁 F. CONTINUOUS PRACTICE & REFLECTION

- Weekly micro-projects (3–4 SQL scripts or a small pipeline tweak).
- Monthly reflections: *“What pattern did I finally understand?”*
- Evaluate comprehension — not speed.

---

## 🌱 G. OPTIONAL LONG-TERM EXTENSIONS

- **Analytics:** Window functions (`ROW_NUMBER`, `RANK`, `SUM() OVER`).
- **Data Warehousing:** materialized vs computed views; star vs snowflake.
- **Automation:** dynamic stored procedures; event-driven Functions + Logic Apps.
- **Visualization:** Power BI theming, bookmarks, and drill-through.

---

### ✍️ Implementation Note

Use code comments matching section numbers (e.g., `-- E3 Azure SQL`) for clear traceability.

**Teaching Philosophy:**
> Never promote comprehension before it’s ready.  
> Mastery isn’t speed — it’s confidence, depth, and the ability to teach others what you’ve learned.

## 

- Weekly micro-projects (3–4 SQL scripts).
- Monthly reflections: *“What pattern did I finally understand?”*
- Evaluate comprehension — not speed.

---

## 🌱 F. OPTIONAL LONG-TERM EXTENSIONS

- **Analytics:** Window functions (`ROW_NUMBER`, `RANK`, `SUM() OVER`).
- **Data Warehousing:** materialized vs computed views.
- **Automation:** dynamic stored procedures.
- **Integration:** Python or Power BI visualizations.

---

### ✍️ Implementation Note

Use code comments matching section numbers (e.g., `-- B2 CROSS APPLY`) for clear traceability.

**Teaching Philosophy:**
> Never promote comprehension before it’s ready.  
> Mastery isn’t speed — it’s confidence, depth, and the ability to teach others what you’ve learned.

