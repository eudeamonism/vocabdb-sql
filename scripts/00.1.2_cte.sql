SELECT * FROM VocabDB.dbo.Words;

WITH ShortWords AS (
    SELECT
        WordID,
        Word,
        LEN(word) AS WordLength,
        CreatedAt,
        SortedWord
    FROM VocabDB.dbo.Words
    WHERE LEN(word) <= 5
)

SELECT * FROM ShortWords
ORDER BY WordLength, Word;