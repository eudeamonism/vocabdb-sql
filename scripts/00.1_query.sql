SELECT * FROM [VocabDB].[dbo].[Words]
	WHERE LEN(Word) > 8
	ORDER BY LEN(Word), Word;