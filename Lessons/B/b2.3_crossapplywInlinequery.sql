USE VocabDB;
GO
-- I am going to use inline queries with CROSS APPLY to achieve similar results as the previous lesson.

SELECT TOP 25
    s.raw_line,
    x.TextLength
FROM dbo.Words_Staging AS s
CROSS APPLY (
    SELECT
        LEN(s.raw_line) AS TextLength
) AS x
ORDER BY s.raw_line;

-- NOTE: OUTER APPLY just keeps the NULLs if there are no results from the right side.