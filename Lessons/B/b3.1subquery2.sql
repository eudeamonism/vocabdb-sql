USE VocabDB;
GO
SELECT ID, Word, LEN(Word) AS LetterCount
FROM dbo.Words_Nullable;


-- Correlated Subqueries always need dot notation to reference the outer query

-- yeah lets go. I think i get it. IN correlated subqueries we are referencing an outer table as a condition to filter the main table
SELECT w.Word
FROM dbo.Words_Nullable AS w
WHERE LEN(w.Word) = 
    (SELECT MAX(LEN(Word)) 
     FROM dbo.Words_Nullable AS w2
     WHERE w2.Word IS NOT NULL);

     SELECT DISTINCT w1.ID, w1.Word
FROM dbo.Words_Nullable AS w1
JOIN dbo.Words_Nullable AS w2
    ON w1.Category = w2.Category;


SELECT w1.ID, w1.Word
FROM dbo.Words_Nullable AS w1
WHERE EXISTS (
    SELECT 1
    FROM dbo.Words_Nullable AS w2
    WHERE w2.Category = w1.Category
      AND w2.ID <> w1.ID
);
