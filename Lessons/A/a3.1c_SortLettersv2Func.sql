USE VocabDB;
GO

ALTER TABLE dbo.Words_Nullable
-- DROP COLUMN SortedWord;
ADD WordLength AS LEN(Word);
GO

USE VocabDB;
GO

CREATE FUNCTION dbo.fn_SortLetters_v2
(
    @Word NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN
    DECLARE @w      NVARCHAR(4000);
    DECLARE @result NVARCHAR(4000);

    -------------------------------------------------------------------
    -- 1) Handle NULL safely (prevents TOP(NULL) errors)
    -------------------------------------------------------------------
    IF @Word IS NULL
        RETURN NULL;

    -------------------------------------------------------------------
    -- 2) Normalize (trim + lowercase)
    -------------------------------------------------------------------
    SET @w = LTRIM(RTRIM(LOWER(@Word)));

    -------------------------------------------------------------------
    -- 3) Handle empty/whitespace-only strings
    -------------------------------------------------------------------
    IF @w = N''
        RETURN N'';

    -------------------------------------------------------------------
    -- 4) Generate one row per character: 1..LEN(@w)
    -------------------------------------------------------------------
    ;WITH N AS
    (
        SELECT TOP (LEN(@w))
               ROW_NUMBER() OVER (ORDER BY (SELECT 0)) AS n
        FROM sys.all_objects
    ),
    Letters AS
    (
        SELECT SUBSTRING(@w, n, 1) AS ch
        FROM N
    )
    -------------------------------------------------------------------
    -- 5) Alphabetically sort the characters and glue them back together
    -------------------------------------------------------------------
    SELECT @result = STRING_AGG(ch, '') WITHIN GROUP (ORDER BY ch)
    FROM Letters;

    RETURN @result;
END;
GO
