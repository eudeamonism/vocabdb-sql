SELECT * FROM dbo.fn_WordsByLength(3,5)
WHERE Word LIKE 'BE%'
ORDER BY WordLength, SortedWord;