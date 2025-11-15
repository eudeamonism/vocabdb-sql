USE VocabDB;
GO
-- FOR EACH WORD, COMPUTE LENGTH AND VOWEL COUNT
-- DONE three different ways

-- 1. Using a Subquery (Scalar Correlated Subquery)
-- MOTTO: COMPUTE A VALUE
SELECT
    ID,
    Word,
    LEN(Word) AS WordLength,
    dbo.fn_CountVowels(Word) AS VowelCount
FROM dbo.Words_Nullable
Order By Word DESC;

--2. APPLY Method - CROSS APPLY
-- MOTTO: Essentially TWO sets with their own aliases
SELECT
    W.ID,
    W.Word,
    X.WordLength,
    X.VowelCount
FROM dbo.Words_Nullable AS W
CROSS APPLY 
(
    SELECT
        LEN(W.Word) AS WordLength,
        dbo.fn_CountVowels(W.Word) AS VowelCount
) AS X
Order By W.Word DESC;

--3. JOIN METHOD - 
-- MOTTO: TWO COMPLETE SETS with ON specificty

SELECT
    W.ID,
    W.Word,
    X.WordLength,
    X.VowelCount
FROM dbo.Words_Nullable AS W
JOIN
(
    SELECT
        ID,
        LEN(Word) AS WordLength,
        dbo.fn_CountVowels(Word) AS VowelCount
    FROM dbo.Words_Nullable
) AS X
-- DON"T FORGET SPECIFICTY
ON W.ID = X.ID
Order By W.Word DESC;
