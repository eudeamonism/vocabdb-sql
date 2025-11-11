SELECT
    w.Word,
    w.Category AS MainCat,
    a.Word AS AltWord,
    a.Category AS AltCat,
    dbo.fn_SuffixCategorySimple(a.Word) AS DerivedCat
FROM dbo.Words AS w
INNER JOIN dbo.Words_Alt AS a
    ON w.Category = a.Category
ORDER BY a.Category, w.Word;