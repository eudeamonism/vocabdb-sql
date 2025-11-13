USE VocabDB;
GO

-- Just to be sure the function exists and works
SELECT dbo.fn_SortLetters_v2(N'Cat')       AS Sorted_Cat,
       dbo.fn_SortLetters_v2(N'   Seat  ') AS Sorted_Seat,
       dbo.fn_SortLetters_v2(NULL)         AS Sorted_Null;
GO

-- THe version handles NULLs properly

-- ADDING COMPUTED COLUMN w/o persisting

ALTER TABLE dbo.Words_Nullable
ADD SortedWord_v2 AS dbo.fn_SortLetters_v2(Word);
GO

-- DROP COLUMN and re-ADD with PERSISTED

ALTER TABLE dbo.Words_Nullable
DROP COLUMN SortedWord_v2;
GO

ALTER TABLE dbo.Words_Nullable
ADD SortedWord_v2 AS dbo.fn_SortLetters_v2(Word);
GO