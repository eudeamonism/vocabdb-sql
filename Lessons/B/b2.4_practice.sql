USE VocabDB;
GO

SELECT TOP 10
    w.ID,
    w.Word,
    LEN(w.Word) AS WordLength
FROM dbo.Words_Nullable AS w
INNER JOIN dbo.Words as w2
    ON w.ID = w2.WordID

    SELECT TOP 10
    w.ID,
    w.Word,
    LEN(w.Word) AS WordLength
FROM dbo.Words_Nullable AS w
INNER JOIN dbo.Words as w2
    ON w.Word = w2.Word

    SELECT TOP 10
    w.ID,
    w.Word,
    LEN(w.Word) AS WordLength
FROM dbo.Words_Nullable AS w
INNER JOIN dbo.Words as w2
    ON w.WordLength = w2.WordLength