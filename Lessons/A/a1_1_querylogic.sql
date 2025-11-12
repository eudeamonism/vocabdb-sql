USE VocabDB;
GO

SELECT TOP 50 w.WordID, a.AltID, w.Word AS MatchedWord, w.Category, a.Category AS AltCategory
FROM dbo.Words AS w
JOIN dbo.Words_Alt AS a ON w.Word = a.Word
GROUP BY w.WordID, w.Word, w.Category, a.AltID, a.Word, a.Category

;SELECT 
    w.Category AS WordCategory,
    a.Category AS AltCategory,
    COUNT(*) AS MatchCount
FROM dbo.Words AS w
JOIN dbo.Words_Alt AS a ON w.Word = a.Word
GROUP BY w.Category, a.Category
ORDER BY MatchCount DESC;

;SELECT 
    w.WordID,
    w.Word AS MatchedWord,
    w.Category,
    a.Category AS AltCategory,
    CASE 
        WHEN w.Category = a.Category THEN 'Same'
        ELSE 'Different'
    END AS CategoryComparison
FROM dbo.Words AS w
JOIN dbo.Words_Alt AS a ON w.Word = a.Word
ORDER BY MatchedWord;
