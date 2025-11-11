SELECT 
    w.Word AS MainWord,
    w.Category AS MainCat,
    a.Word AS AltWord,
    f.Word AS FuncWord,
    f.WordLength
FROM dbo.Words AS w
INNER JOIN dbo.Words_Alt AS a
    ON w.Category = a.Category
CROSS APPLY dbo.fn_WordsByLength(3, 5) AS f
ORDER BY w.Category, f.WordLength, f.Word;
