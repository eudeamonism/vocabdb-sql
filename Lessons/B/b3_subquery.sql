USE VocabDB;
GO

SELECT
    w.ID,
    w.Word,
    (
        SELECT LEN(w2.Word)
        FROM dbo.Words_Nullable AS w2
        WHERE w2.ID = w.ID
    ) AS LetterCount
FROM dbo.Words_Nullable AS w;

-- JOIN is just INNER JOIN

SELECT
    w.ID,
    w.Word,
    lc.LetterCount
FROM dbo.Words_Nullable AS w
JOIN (
    SELECT
        ID, 
        LEN(Word) AS LetterCount
        FROM dbo.Words_Nullable
) as lc
ON w.ID = lc.ID;

SELECT w.Word, a.Word
FROM dbo.Words_Nullable AS w
INNER JOIN Words_Alt AS a
    ON w.Category = a.Category;
