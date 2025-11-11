SELECT * FROM VocabDB.dbo.Words
ORDER BY WordLength DESC;

ALTER TABLE dbo.Words
ADD WordLength AS (LEN(Word)) PERSISTED;

CREATE INDEX IX_Words_WordLength ON dbo.Words (WordLength);