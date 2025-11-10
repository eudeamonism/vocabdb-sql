-- All words sorted alphabetically
SELECT Word FROM dbo.Words ORDER BY Word;

-- Words shorter than 5 letters
SELECT * FROM dbo.Words WHERE LEN(Word) < 5;

-- Words starting with "ab"
SELECT * FROM dbo.Words WHERE Word LIKE 'ab%';

-- Words containing "ing"
SELECT * FROM dbo.Words WHERE Word LIKE '%ing%';

-- Words ending in "ed"
SELECT * FROM dbo.Words WHERE Word LIKE '%ed';

-- Words grouped by length
SELECT LEN(Word) AS WordLength, COUNT(*) AS Count
FROM dbo.Words
GROUP BY LEN(Word)
ORDER BY WordLength;

-- Longest and shortest words
SELECT TOP 10 Word, LEN(Word) AS Length FROM dbo.Words ORDER BY Length DESC;
SELECT TOP 10 Word, LEN(Word) AS Length FROM dbo.Words ORDER BY Length ASC;

-- Distinct letter combos (based on SortedWord)
SELECT DISTINCT SortedWord FROM dbo.Words ORDER BY SortedWord;
