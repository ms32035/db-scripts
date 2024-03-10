DECLARE @table_name NVARCHAR(128) = N'YourTableName'; -- replace with your table name
DECLARE @schema_name NVARCHAR(128) = N'dbo'; -- replace with your schema name
DECLARE @sql NVARCHAR(MAX);

SELECT @sql = ISNULL(@sql + N'; ', N'') +
    N'ALTER TABLE [' + fk.parent_schema_name + N'].[' + fk.parent_table_name + N'] DROP CONSTRAINT [' + fk.name + N']'
FROM (
    SELECT
        fk.name,
        OBJECT_SCHEMA_NAME(fk.parent_object_id) AS parent_schema_name,
        OBJECT_NAME(fk.parent_object_id) AS parent_table_name
    FROM sys.foreign_keys AS fk
    INNER JOIN sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.tables AS t ON fkc.referenced_object_id = t.object_id
    INNER JOIN sys.schemas AS s ON t.schema_id = s.schema_id
    WHERE t.name = @table_name AND s.name = @schema_name
) AS fk;

EXEC sp_executesql @sql;
