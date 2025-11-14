USE VocabDB;
GO

IF OBJECT_ID('dbo.fn_TextMetrics', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_TextMetrics;
GO

CREATE FUNCTION dbo.fn_TextMetrics
(
    @Text NVARCHAR(4000)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        LowerText     = LOWER(@Text),
        TextLength    = LEN(@Text),
        DigitCount    = LEN(@Text) - LEN(TRANSLATE(@Text, '0123456789', '##########')),
        HasSpaces     = CASE WHEN CHARINDEX(' ', @Text) > 0 THEN 1 ELSE 0 END
);
GO
