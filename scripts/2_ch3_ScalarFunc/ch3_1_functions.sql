USE VocabDB;
GO

-- Clean drop
IF OBJECT_ID('dbo.fn_WordsByLength', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_WordsByLength;
GO

CREATE FUNCTION dbo.fn_WordsByLength
(
    @MinLen int,
    @MaxLen int
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        w.WordID,
        w.Word,
        w.WordLength,     -- your persisted computed column
        w.SortedWord,
        w.CreatedAt,
        w.Category
    FROM dbo.Words AS w
    WHERE w.WordLength BETWEEN @MinLen AND @MaxLen
);
GO
