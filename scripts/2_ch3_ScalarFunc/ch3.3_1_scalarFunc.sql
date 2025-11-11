USE VocabDB;
GO

-- Drop existing version if necessary
IF OBJECT_ID('dbo.fn_Suffix', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_Suffix;
GO

CREATE FUNCTION dbo.fn_Suffix
(
    @Word NVARCHAR(50),
    @Length INT
)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @Suffix NVARCHAR(50);

    -- Check if length is valid
    IF @Length > LEN(@Word)
        SET @Suffix = @Word;
    ELSE
        SET @Suffix = RIGHT(@Word, @Length);

    RETURN @Suffix;
END;
GO
