USE VocabDB;
GO

IF OBJECT_ID('dbo.fn_CountVowels', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CountVowels;
GO

CREATE FUNCTION dbo.fn_CountVowels
(
    @Word NVARCHAR(4000)
)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    -- Handle NUll safely; if input is NULL, return 0
    IF @Word IS NULL
    BEGIN
        SET @Result = 0;
    END
    ELSE
    BEGIN
        -- Normalize to lower case once
        DECLARE @w NVARCHAR(4000) = LOWER(@Word);

        SET @Result =
      (LEN(@w) - LEN(REPLACE(@w, 'a', '')))
    + (LEN(@w) - LEN(REPLACE(@w, 'e', '')))
    + (LEN(@w) - LEN(REPLACE(@w, 'i', '')))
    + (LEN(@w) - LEN(REPLACE(@w, 'o', '')))
    + (LEN(@w) - LEN(REPLACE(@w, 'u', '')));

    END
    RETURN @Result;
END;
GO

