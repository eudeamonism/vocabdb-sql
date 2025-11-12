SELECT
    w.AltID,
    w.Word,
    w.Category,
    s.Position,
    s.Letter
FROM dbo.Words_Alt AS w
CROSS APPLY dbo.fn_SplitWord(w.Word) AS s
WHERE w.Word IS NOT NULL
ORDER BY w.AltID, s.Position;

SELECT
    w.AltID, w.Word, w.Category, s.Position, s.Letter
FROM dbo.Words_Alt AS w
OUTER APPLY dbo.fn_SplitWord(w.Word) AS s
ORDER BY w.AltID, s.Position;
