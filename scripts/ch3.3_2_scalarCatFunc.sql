USE VocabDB;
GO

IF OBJECT_ID('dbo.fn_SuffixCategorySimple', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_SuffixCategorySimple;
GO

CREATE FUNCTION dbo.fn_SuffixCategorySimple
(
    @Word NVARCHAR(128)
)
RETURNS NVARCHAR(32)
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @w NVARCHAR(128);
    DECLARE @cat NVARCHAR(32);

    -- Normalize
    SET @w = LTRIM(RTRIM(LOWER(@Word)));

    -- Light trailing punctuation strip (extend if you like)
    -- Note: TRANSLATE requires SQL Server 2017+. If older, skip or use REPLACE chains.
    SET @w = REPLACE(@w, '.', '');
    SET @w = REPLACE(@w, ',', '');
    SET @w = REPLACE(@w, '!', '');
    SET @w = REPLACE(@w, '?', '');
    SET @w = REPLACE(@w, ';', '');
    SET @w = REPLACE(@w, ':', '');
    SET @w = REPLACE(@w, '''', '');

    -- Match longest/most-specific first
    IF (@w LIKE '%ically')         SET @cat = N'Adverb';
    ELSE IF (@w LIKE '%ality')     SET @cat = N'Noun-Abstract';
    ELSE IF (@w LIKE '%ation' OR @w LIKE '%tion' OR @w LIKE '%sion')
                                   SET @cat = N'Noun-Action';
    ELSE IF (@w LIKE '%ative')     SET @cat = N'Adjective';
    ELSE IF (@w LIKE '%ness')      SET @cat = N'Noun-State';
    ELSE IF (@w LIKE '%ment')      SET @cat = N'Noun-Result';
    ELSE IF (@w LIKE '%able' OR @w LIKE '%ible')
                                   SET @cat = N'Adjective';
    ELSE IF (@w LIKE '%ous')       SET @cat = N'Adjective';
    ELSE IF (@w LIKE '%less')      SET @cat = N'Adjective';
    ELSE IF (@w LIKE '%ful')       SET @cat = N'Adjective';
    ELSE IF (@w LIKE '%ize' OR @w LIKE '%ise' OR @w LIKE '%ify')
                                   SET @cat = N'Verb-Causative';
    ELSE IF (@w LIKE '%ing')       SET @cat = N'Verb-ING';
    ELSE IF (@w LIKE '%ied')       SET @cat = N'Verb-Past';
    ELSE IF (@w LIKE '%ed')        SET @cat = N'Verb-Past';
    ELSE IF (@w LIKE '%ly')        SET @cat = N'Adverb';
    ELSE IF (@w LIKE '%er')        SET @cat = N'Comparative/Agent';
    ELSE IF (@w LIKE '%est')       SET @cat = N'Superlative';
    ELSE                           SET @cat = N'Other';

    RETURN @cat;
END;
GO
