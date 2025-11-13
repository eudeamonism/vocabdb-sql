USE VocabDB;
GO

ALTER TABLE dbo.Words_Nullable
ADD WordLength AS LEN(Word) PERSISTED;
GO

SELECT TOP (20) Word, WordLength
FROM dbo.Words_Nullable;