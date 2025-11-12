USE VocabDB;
GO

-- Add new column Vowels
ALTER TABLE dbo.Words_Nullable
ADD Vowels INT;
GO

-- Update Vowels column with the count of vowels in each Word
UPDATE dbo.Words_Nullable
SET Vowels = dbo.fn_CountVowels(Word);
GO  
