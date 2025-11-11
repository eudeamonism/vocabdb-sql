SELECT TOP (20)
    WordID, Word, WordLength,
    dbo.fn_SuffixCategorySimple(Word) AS Category
FROM dbo.Words
WHERE dbo.fn_SuffixCategorySimple(Word) LIKE N'Noun%'
ORDER BY Category, Word;