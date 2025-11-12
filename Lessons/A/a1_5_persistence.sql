USE VocabDB;

SELECT COUNT(*) AS NullCategories
FROM dbo.Words_Nullable
WHERE Category IS NULL;

SELECT TOP (10) ID, Word, Category
FROM dbo.Words_Nullable
WHERE Category = 'Test'
ORDER BY ID;

UPDATE dbo.Words_Nullable
SET Category = 'ERROR,J/K'
OUTPUT inserted.ID,
       inserted.Word,
       deleted.Category AS OldCat,   -- expected NULL
       inserted.Category AS NewCat   -- 'Test'
WHERE Category = 'Test';
