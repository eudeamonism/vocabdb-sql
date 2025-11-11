USE VocabDB;
GO
SELECT TOP (1000) [WordID]
      ,[Word]
      ,[CreatedAt]
      ,[SortedWord]
      ,[WordLength]
      ,[Category]
  FROM [VocabDB].[dbo].[Words]
  WHERE Category = 'Noun-Action'
  ORDER BY Category;
