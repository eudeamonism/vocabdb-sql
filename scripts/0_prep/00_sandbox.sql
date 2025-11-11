USE VocabDB;
GO

-- Check how many rows are in staging
SELECT 
    COUNT(*) AS staging_rows
FROM dbo.Words_Staging;
GO

-- Create Table
IF OBJECT_ID('dbo.Words', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Words
    (
        WordID INT IDENTITY(1,1) PRIMARY KEY,
        Word NVARCHAR(100) NOT NULL,
        CreatedAt DATETIME2(0) NOT NULL
            CONSTRAINT DF_Words_CreatedAt DEFAULT SYSUTCDATETIME()
    );
END
GO