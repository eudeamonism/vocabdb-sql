USE VocabDB;
GO

ALTER TABLE dbo.Words
ADD Category AS dbo.fn_SuffixCategorySimple(Word) PERSISTED;
GO
