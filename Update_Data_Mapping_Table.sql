DECLARE @tableName NVARCHAR(255) = 'YourReportingTable';

DECLARE @sql NVARCHAR(MAX) = '';

-- Create or update rows in Claims_Data_Mapping based on the reporting table
INSERT INTO Claims_Data_Mapping (TableName, ColumnName, DataType, Length)
SELECT
    @tableName AS TableName,
    COLUMN_NAME AS ColumnName,
    DATA_TYPE AS DataType,
    CASE
        WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN CHARACTER_MAXIMUM_LENGTH
        ELSE 0 -- Set your default length here if needed
    END AS Length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName
    AND COLUMN_NAME NOT IN (SELECT ColumnName FROM Claims_Data_Mapping WHERE TableName = @tableName);

-- Generate dynamic SQL to update reporting table based on Claims_Data_Mapping
SELECT @sql += 
    'ALTER TABLE ' + @tableName + ' ALTER COLUMN ' + cdm.ColumnName + ' ' + cdm.DataType + '(' + CAST(cdm.Length AS NVARCHAR) + ');' + CHAR(13) + CHAR(10)
FROM Claims_Data_Mapping cdm
WHERE cdm.TableName = @tableName;

-- PRINT @sql; -- Uncomment this line to see the generated SQL

-- Execute the dynamic SQL
IF @sql <> ''
BEGIN
    EXEC sp_executesql @sql;
    PRINT 'Columns updated in ' + @tableName;
END
ELSE
BEGIN
    PRINT 'No columns to update in ' + @tableName;
END
