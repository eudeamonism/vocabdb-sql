USE VocabDB;
GO

-- DISTINCT gets things more than one
SELECT DISTINCT Category
FROM dbo.Words_Nullable;

-- Length is modifier that makes filtering easier
SELECT DISTINCT Category
FROM dbo.Words_Nullable
WHERE Category IS NOT NULL AND LEN(Category) < 6;

-- Using Length as allias
SELECT DISTINCT Category, LEN(Category) AS CatLength, COUNT(Category) AS CatCount
FROM dbo.Words_Nullable
WHERE Category IS NOT NULL
GROUP BY Category, LEN(Category)
HAVING COUNT(Category) > 1;