use VocabDB;
GO

-- get some words
SELECT TOP(20) ID, Word, Category, Vowels, WordLength
FROM dbo.Words_Nullable;

-- change something

UPDATE dbo.Words_Nullable
SET Category =  'NOUN'
WHERE Category = 'Other';