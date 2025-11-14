USE VocabDB;
GO

SELECT 
    name,
    type_desc,
    FORMAT(create_date, 'MM/dd/yyyy hh:mm tt') AS create_date_local,
    FORMAT(modify_date, 'MM/dd/yyyy hh:mm tt')  AS modify_date_local
FROM sys.objects
WHERE type IN ('FN','IF','TF')
ORDER BY modify_date DESC;

--TO find available metadata columns for sys.objects
SELECT * 
FROM sys.objects
WHERE 1 = 0;

-- or

EXEC sp_help 'sys.objects';

-- See function source code

SELECT 
    o.name,
    m.definition
FROM sys.objects AS o
JOIN sys.sql_modules AS m ON o.object_id = m.object_id
WHERE o.name = 'fn_CleanWord';

-- This is cool
SELECT *
FROM sys.objects
WHERE name = 'fn_CleanWord';

--TO find available metadata columns for sys.sql_modules
SELECT *
FROM sys.sql_modules;

-- all code for functions in the database
SELECT 
    o.name,
    o.type_desc,
    m.definition
FROM sys.objects AS o
JOIN sys.sql_modules AS m
    ON o.object_id = m.object_id
WHERE o.type IN ('FN','IF','TF')
ORDER BY o.name;

-- Find any function that references a specific table

SELECT o.name
FROM sys.objects o
JOIN sys.sql_modules m ON o.object_id = m.object_id
WHERE m.definition LIKE '%Words_Nullable%';


-- Find functions referencing a specific column
SELECT o.name
FROM sys.objects o
JOIN sys.sql_modules m ON o.object_id = m.object_id
WHERE m.definition LIKE '%WordLength%';

-- Query Function Meta
USE VocabDB;
GO

SELECT
    o.name                               AS FunctionName,
    o.type_desc                          AS FunctionType,      -- scalar / inline TVF / etc
    FORMAT(o.create_date, 'MM/dd/yyyy hh:mm tt') AS CreatedLocal,
    FORMAT(o.modify_date, 'MM/dd/yyyy hh:mm tt') AS ModifiedLocal,

    COUNT(p.parameter_id)                AS ParameterCount,    -- NEW insight #1
    LEN(m.definition)                    AS DefinitionLength,  -- NEW insight #2 (size / complexity)

    LEFT(
        REPLACE(REPLACE(m.definition, CHAR(13), ' '), CHAR(10), ' '),
        120
    ) AS DefinitionPreview               -- short one-line preview
FROM sys.objects AS o
JOIN sys.sql_modules AS m
    ON m.object_id = o.object_id
LEFT JOIN sys.parameters AS p
    ON p.object_id = o.object_id
WHERE o.type IN ('FN','IF','TF')         -- only functions
GROUP BY
    o.name,
    o.type_desc,
    o.create_date,
    o.modify_date,
    m.definition
ORDER BY o.modify_date DESC;
