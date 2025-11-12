USE VocabDB;

SELECT
    ID,
    Word,
    Category
FROM dbo.Words_Nullable
WHERE
    -- 1. true NULLs
    Word IS NULL
    OR
    -- 2. empty or whitespace-only
    LTRIM(RTRIM(Word)) = ''
    OR
    -- 3. numeric-only strings (all digits, no letters)
    Word NOT LIKE '%[^0-9]%'
ORDER BY ID;
