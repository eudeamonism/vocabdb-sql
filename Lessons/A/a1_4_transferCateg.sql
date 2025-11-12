USE VocabDB;
GO

-- Preview what would be updated
SELECT n.ID, n.Word, n.Category AS NullCat, 
    w.Category AS SrcCat
-- Then end product table, what is being updated
FROM dbo.Words_Nullable AS n
-- Contents to be dumped
JOIN dbo.Words AS w
-- ON is needed here, logic
ON UPPER(LTRIM(RTRIM(n.Word))) = UPPER(LTRIM(RTRIM(w.Word)))
-- nullWord is NOT NULL and n.Cat is
WHERE n.Word IS NOT NULL
    AND n.Category IS NULL
ORDER BY n.ID;
GO

-- Update: fill Category in nullable table from dbo.Words; skip NULL words
UPDATE n
SET n.Category = w.Category
FROM dbo.Words_Nullable AS n
JOIN dbo.Words as w
ON UPPER(LTRIM(RTRIM(n.Word))) = UPPER(LTRIM(RTRIM(w.Word)))
WHERE n.Word IS NOT NULL
    AND n.Category IS NULL;
SELECT @@ROWCOUNT AS RowsUpdated;  -- how many rows were filled
GO

-- Quick verify
SELECT TOP (20) *
FROM dbo.Words_Nullable
WHERE Category IS NOT NULL
ORDER BY ID;