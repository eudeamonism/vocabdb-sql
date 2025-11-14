-- Inner Join

USE VocabDB;
GO
SELECT
-- w = table dbo.Words
    w.WordID,
    w.Word,
-- a = table dbo.Words_Alt
    a.AltID,
    a.Word
FROM dbo.Words as w
INNER JOIN dbo.Words_Alt as a
ON w.Word = a.Word;

-- LEFT JOIN: keep all of FROM table and match from other?
SELECT
-- w = table dbo.Words
    w.WordID,
    w.Word,
-- n = table dbo.Words_Nullable
    n.ID AS NID,
    n.Word AS NORD
FROM dbo.Words as w
LEFT JOIN dbo.Words_Nullable as n
ON w.Word = n.Word
WHERE n.Word IS NOT NULL;