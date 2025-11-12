USE VocabDB;
GO

-- Empty Table, deleting all Rows
TRUNCATE Table dbo.Words_Nullable;

INSERT INTO dbo.Words_Nullable (Word)
SELECT TOP (50)
       CAST(LTRIM(RTRIM(raw_line)) AS NVARCHAR(100))
FROM dbo.Words_Staging
WHERE raw_line IS NOT NULL
  AND LEN(LTRIM(RTRIM(raw_line))) BETWEEN 4 AND 8
  AND LEFT(UPPER(LTRIM(RTRIM(raw_line))), 1) BETWEEN 'F' AND 'K'
ORDER BY NEWID();