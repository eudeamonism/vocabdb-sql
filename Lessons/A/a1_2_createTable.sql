-- Create new Table where NULL values are allowed.
-- Except top 50 of dbo.Words_Staging
-- Columns: raw_line and stg_id


-- Step 1: Ensure you are using the correct database
USE VocabDB;
GO

DROP TABLE IF EXISTS dbo.Words_Nullable;
GO

CREATE TABLE dbo.Words_Nullable (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Word NVARCHAR(100) NULL,
    Category NVARCHAR(50) NULL
)