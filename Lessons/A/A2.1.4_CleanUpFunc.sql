USE VocabDB;
GO

IF OBJECT_ID('dbo.fn_CleanWord', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CleanWord;
GO

CREATE FUNCTION dbo.fn_CleanWord
(
    @Word NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN
    -- If input is NULL, return NULL
    IF @Word IS NULL
        RETURN NULL;

    DECLARE @clean NVARCHAR(4000);

    -- 1) Normalize whitespace and case
    SET @clean = LOWER(LTRIM(RTRIM(@Word)));

    -- 2) Strip punctuation
    SET @clean = REPLACE(@clean, '"', '');
    SET @clean = REPLACE(@clean, '''', '');
    SET @clean = REPLACE(@clean, ',', '');
    SET @clean = REPLACE(@clean, '.', '');
    SET @clean = REPLACE(@clean, '!', '');
    SET @clean = REPLACE(@clean, '?', '');
    SET @clean = REPLACE(@clean, ':', '');
    SET @clean = REPLACE(@clean, ';', '');
    SET @clean = REPLACE(@clean, '(', '');
    SET @clean = REPLACE(@clean, ')', '');
    SET @clean = REPLACE(@clean, '[', '');
    SET @clean = REPLACE(@clean, ']', '');
    SET @clean = REPLACE(@clean, '{', '');
    SET @clean = REPLACE(@clean, '}', '');
    SET @clean = REPLACE(@clean, '-', '');
    SET @clean = REPLACE(@clean, '/', '');

    RETURN @clean;
END;
GO
