-- USING CROSS APPLY and OUTER APPLY in SQL Server

-- APPLY is an operator that performs a function on the left table for each row.

-- Good for per-row computation, table-valued functions that return multiple columns, dynamic filtering, and replacing procedural loops in pure SQL.

USE VocabDB;
GO

SELECT TOP 10
    s.raw_line,
    t.LowerText,
    t.TextLength,
    t.DigitCount,
    t.HasSpaces
FROM dbo.Words_Staging AS s
CROSS APPLY dbo.fn_TextMetrics(s.raw_line) AS t
ORDER BY t.TextLength DESC;

