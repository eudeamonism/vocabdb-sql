USE VocabDB;
GO

SELECT 
    Word,
    LEN(Word) AS WordLength,
    (LEN(Word) - LEN(REPLACE(LOWER(Word), 'a', ''))
     + LEN(Word) - LEN(REPLACE(LOWER(Word), 'e', ''))
     + LEN(Word) - LEN(REPLACE(LOWER(Word), 'i', ''))
     + LEN(Word) - LEN(REPLACE(LOWER(Word), 'o', ''))
     + LEN(Word) - LEN(REPLACE(LOWER(Word), 'u', ''))
    ) AS VowelCount
FROM
    dbo.Words_Nullable
WHERE
    Word IS NOT NULL;


SELECT
    Word,
    LEN(Word) AS OriginalLength,
    LEN(REPLACE(LOWER(Word), 'a', '')) AS WithoutA,
    LEN(Word) - LEN(REPLACE(LOWER(Word), 'a', '')) AS CountA
FROM
    dbo.Words_Nullable
WHERE
    Word IS NOT NULL
    AND LEN(Word) > 5;