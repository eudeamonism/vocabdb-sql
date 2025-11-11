WITH AnagramGroups AS (
    SELECT 
        SortedWord,
        COUNT(*) AS WordCount
    FROM VocabDB.dbo.Words
    GROUP BY SortedWord
    HAVING COUNT(*) > 1
)
SELECT *
FROM AnagramGroups
ORDER BY WordCount DESC;
