DECLARE @target NVARCHAR(50) = N'recant';

SELECT Word
FROM dbo.Words
WHERE SortedWord = dbo.fn_SortLetters(@target)
  AND Word <> @target
ORDER BY Word;