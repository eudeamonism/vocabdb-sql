USE VocabDB;
GO

IF OBJECT_ID('dbo.fn_FilterWords', 'TF') IS NOT NULL
    DROP FUNCTION dbo.fn_FilterWords;
GO

CREATE FUNCTION dbo.fn_FilterWords
(
    @MinLength INT,
    @StartsWith CHAR(1) 
)
RETURNS @Filtered TABLE
(
    Word NVARCHAR(50),
    WordLength INT,
    SortedWord NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @Filtered
    SELECT Word, WordLength, SortedWord
    FROM dbo.Words
    WHERE WordLength >= @MinLength
      AND Word LIKE @StartsWith + '%';

DELETE FROM @Filtered WHERE WordLength < 3;

    RETURN;
END;