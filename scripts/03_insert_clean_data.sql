-----------------------------------------------------------------------
-- File: 03_insert_clean_data.sql
-- Purpose:
--   Transform raw text data from dbo.Words_Staging (the import dump)
--   into clean, unique, lowercase word entries in dbo.Words.
--
--   The new table (dbo.Words) automatically handles:
--     - WordID (auto-incrementing primary key)
--     - CreatedAt (timestamp with UTC default)
--
--   This script ensures every word is normalized, deduplicated,
--   and safely transferable, even if run multiple times.
-----------------------------------------------------------------------

-- 1️⃣  Always begin by targeting the correct database.
USE VocabDB;
GO


-----------------------------------------------------------------------
-- 2️⃣  Optional: Add an identity column (stg_id) to the staging table.
--     This helps preserve import order or gives a unique key
--     in case you ever need to debug or trace specific rows.
--
--     The COL_LENGTH() function checks if the column already exists.
--     If it doesn't exist (returns NULL), the ALTER TABLE command runs.
--
--     This means you can safely re-run this script without errors.
-----------------------------------------------------------------------
IF COL_LENGTH('dbo.Words_Staging', 'stg_id') IS NULL
BEGIN
    ALTER TABLE dbo.Words_Staging
    ADD stg_id INT IDENTITY(1,1) NOT NULL;
END
GO


-----------------------------------------------------------------------
-- 3️⃣  The transformation step:
--     We’ll select every raw word, clean it, and normalize it.
--
--     The CTE (Common Table Expression) named "cleaned" temporarily
--     stores cleaned versions of the staging data, like a scratch pad.
--
--     Key functions used:
--       • LTRIM / RTRIM → remove spaces before & after words
--       • LOWER → makes every word lowercase (uniform style)
--       • NULLIF(raw_line, '') → turns empty strings into NULLs
--       • WHERE c.word IS NOT NULL → excludes blanks & NULLs
--
--     DISTINCT removes duplicate words, ensuring your dictionary
--     stays unique and compact.
-----------------------------------------------------------------------

;WITH cleaned AS
(
    SELECT
        -- Trim, lowercase, and ignore blanks.
        word = LTRIM(RTRIM(LOWER(NULLIF(raw_line, '')))),

        -- Preserve the optional identity key from staging
        stg_id
    FROM dbo.Words_Staging
)

-----------------------------------------------------------------------
-- 4️⃣  Insert cleaned results into the final dbo.Words table.
--
--     The dbo.Words table auto-generates:
--       - WordID (identity)
--       - CreatedAt (UTC timestamp)
--
--     So we only need to supply the Word itself.
--
--     DISTINCT ensures duplicates don’t cause multiple inserts.
--     The WHERE clause filters out any remaining NULL words.
-----------------------------------------------------------------------

INSERT INTO dbo.Words (Word)
SELECT DISTINCT c.word
FROM cleaned AS c
WHERE c.word IS NOT NULL;
GO


-----------------------------------------------------------------------
-- 5️⃣  Validation check: compare source (staging) vs target (final)
--
--     Expected outcome:
--       staging_rows → total raw lines in your text file
--       final_rows   → total unique, non-blank words
--
--     These will not always match exactly:
--       - Lower final_rows = duplicates or blanks removed
--       - Equal = perfectly clean input file
-----------------------------------------------------------------------
SELECT
    staging_rows = (SELECT COUNT(*) FROM dbo.Words_Staging),
    final_rows   = (SELECT COUNT(*) FROM dbo.Words);
GO


-----------------------------------------------------------------------
-- ✅ Summary of behavior:
--    • This script is safe to re-run multiple times.
--    • It performs cleanup inline without affecting staging.
--    • It uses SQL Server’s built-in string functions.
--
--    Next steps (optional):
--      1. Add an index for faster search (see 04_indexes.sql)
--      2. Add computed columns (like LEN(Word)) for analytics
--      3. Explore queries using WHERE / LIKE / LEN / ORDER BY
-----------------------------------------------------------------------
