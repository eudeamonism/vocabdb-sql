USE VocabDB;
GO

SELECT TOP (20)
    WordId,
    Word,
    dbo.fn_SuffixCategorySimple(Word) AS CategoryLive, -- computed live
    Category,
    WordLength

FROM dbo.Words
WHERE WordLength BETWEEN 4 AND 8
ORDER BY Word;