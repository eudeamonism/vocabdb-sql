# Interventions

## Adding Alt Table Data

### Create a table

```sql
USE VocabDB;
GO

IF OBJECT_ID('dbo.Words_Alt', 'U') IS NOT NULL
    DROP TABLE dbo.Words_Alt;
GO

CREATE TABLE dbo.Words_Alt (
    AltID INT IDENTITY(1,1) PRIMARY KEY,
    Word NVARCHAR(128) NOT NULL,
    Category NVARCHAR(32),
    SourceNote NVARCHAR(64) DEFAULT('alt')
);

INSERT INTO dbo.Words_Alt (Word, Category)
VALUES 
('better', 'Adjective'),
('running', 'Verb'),
('happily', 'Adverb'),
('green', 'Adjective'),
('stone', 'Noun');

```
## INNER JOIN EX

```sql
SELECT
    w.Word,
    w.Category AS MainCat,
    a.Word AS AltWord,
    a.Category AS AltCat,
    dbo.fn_SuffixCategorySimple(a.Word) AS DerivedCat
FROM dbo.Words AS w
INNER JOIN dbo.Words_Alt AS a
    ON w.Category = a.Category
ORDER BY a.Category, w.Word;
```

🧩 1. The Reason for Choosing dbo.Words_Alt as the “Joined” Table

In SQL, whichever table you start with in the FROM clause is called your base or anchor table.
The table after INNER JOIN is the secondary (or “lookup”) table.

So, when we write:

FROM dbo.Words AS w
INNER JOIN dbo.Words_Alt AS a
    ON w.Category = a.Category


We’re saying:

“Start with every row in Words, then look for matching rows in Words_Alt where the categories are the same.”

That means:

dbo.Words is our main dictionary — all words you originally imported.

dbo.Words_Alt is a smaller, supplementary list — alternate spellings, synonyms, or test entries.

We “joined” Words_Alt to Words because it’s the smaller and more specific dataset. This is common design logic: you usually anchor with the larger or master dataset, and join the smaller one that provides extra details.

If we reversed it (starting from Words_Alt), we’d still get valid data — but we’d only see results for rows in Words_Alt that found a match in Words. The join direction doesn’t change the output for INNER JOIN, but conceptually it’s clearer to treat the main one (Words) as the anchor.
