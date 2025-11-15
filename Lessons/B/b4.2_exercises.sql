SELECT
    Word,
    COUNT(*) AS DupCount,
    LEN(Word) AS WordLength
FROM dbo.Words_Nullable
-- WHERE: row-level filter *before* GROUP BY.
-- 1) LEN(Word) must equal the global maximum length (scalar subquery).
-- 2) Word must end with 's'.
WHERE LEN(Word) = (
          -- scalar subquery with aggregate: returns a single max length
          SELECT MAX(LEN(Word))
          FROM dbo.Words_Nullable
      )
  AND Word LIKE '%s'
-- GROUP BY: aggregation step; collapses duplicate (Word, WordLength) pairs into groups.
GROUP BY Word, LEN(Word)
-- HAVING: group-level filter *after* aggregation; keep only words containing 'a'.
HAVING Word LIKE '%a%';





SELECT
    Word,
    COUNT(*) AS Occurrences
FROM dbo.Words_Nullable
GROUP BY Word
HAVING COUNT(*) > 1
ORDER BY Occurrences DESC;


USE VocabDB;
GO

SELECT
    Word,
    LEN(Word) AS WordLength,
    COUNT(*) AS DupCount
FROM dbo.Words_Nullable
WHERE Word IS NOT NULL           -- optional: drop NULLs
  AND Word LIKE '%s'             -- only words that end with 's'
GROUP BY
    Word,
    LEN(Word)
HAVING
    LEN(Word) = (
        -- scalar subquery: maximum length among words ending in 's'
        SELECT MAX(LEN(Word))
        FROM dbo.Words_Nullable
        WHERE Word IS NOT NULL
          AND Word LIKE '%s'
    )
ORDER BY
    Word;

SELECT
    Word,
    LEN(Word) AS WordLength,
    COUNT(*) AS DupCount
FROM dbo.Words_Nullable
WHERE LEN(Word) = (
        -- scalar subquery: returns the max word length
        SELECT MAX(LEN(Word))
        FROM dbo.Words_Nullable
    )
GROUP BY Word
HAVING COUNT(*) > 1          -- this filters only duplicates
ORDER BY DupCount DESC;
