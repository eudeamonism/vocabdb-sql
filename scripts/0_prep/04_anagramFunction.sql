USE VocabDB;
GO

SELECT TOP (5) Word FROM dbo.Words ORDER BY Word;

-- Create a function to sort the letters of a word

USE VocabDB;
GO

CREATE OR ALTER FUNCTION dbo.fn_SortLetters
(
    @word NVARCHAR(128)
)
RETURNS NVARCHAR(128)
AS
BEGIN
    DECLARE @sorted NVARCHAR(128);

    ;WITH Numbers AS (
        SELECT TOP (LEN(@word))
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.all_objects
    ),
    Letters AS (
        SELECT SUBSTRING(@word, n, 1) AS ch
        FROM Numbers
        WHERE SUBSTRING(@word, n, 1) LIKE '[A-Za-z]'
    )
    SELECT @sorted = (
        SELECT ch
        FROM Letters
        ORDER BY ch
        FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(128)');

    RETURN UPPER(@sorted);
END;
GO


ALTER TABLE dbo.Words
ADD SortedWord AS dbo.fn_SortLetters(Word);


