-- Pure CROSS APPLY Example
USE VocabDB;
GO

SELECT
    w.Word AS MainWord,
    w.Category AS MainCat,
    f.Word AS FuncWord,
    f.Category AS FuncCat
FROM dbo.Words AS w
CROSS APPLY dbo.fn_WordsByLength(3,5) AS f
WHERE f.Category = w.Category
ORDER BY w.Category, f.WordLength, f.Word;