Use VocabDB;
GO

CREATE TABLE dbo.Words_Alt (
    AltID INT IDENTITY(1,1) PRIMARY KEY,
    Word NVARCHAR(128) NOT NULL,
    Category NVARCHAR(32),
    SourceNote NVARCHAR(64) DEFAULT('alt')
);

INSERT INTO dbo.Words_Alt (Word, Category)
VALUES
('better', 'Adjective'),
('running', 'Verb'),
('happily', 'Adverb'),
('green', 'Adjective'),
('stone', 'Noun');
