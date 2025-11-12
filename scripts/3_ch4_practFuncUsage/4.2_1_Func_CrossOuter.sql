USE VocabDB;
GO

-- Clean drop if exists
IF OBJECT_ID('dbo.fn_SplitWord', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_SplitWord;
GO

CREATE FUNCTION dbo.fn_SplitWord(@Word NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        n AS Position,
        SUBSTRING(@Word, n, 1) AS Letter
    FROM (SELECT TOP (LEN(@Word))
                 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
          FROM sys.objects) AS Numbers
);
GO
