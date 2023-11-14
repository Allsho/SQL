DECLARE @StagingTableName NVARCHAR(255) = 'YourStagingTableName';
DECLARE @ReportingTableName NVARCHAR(255) = 'YourReportingTableName';

DECLARE @SchemaId INT = 1; -- Replace with the actual SchemaId
DECLARE @StagingDatabaseId INT = 1; -- Replace with the actual StagingDatabaseId
DECLARE @ReportingDatabaseId INT = 1; -- Replace with the actual ReportingDatabaseId
DECLARE @StagingTableId INT = 1; -- Replace with the actual StagingTableId
DECLARE @ReportingTableId INT = 1; -- Replace with the actual ReportingTableId

DECLARE @DynamicSQL NVARCHAR(MAX);

-- Generate dynamic SQL to retrieve column information and insert into Claim_Column_Mapping
SET @DynamicSQL = '
    INSERT INTO Claim_Column_Mapping (
        SchemaId,
        StagingDatabaseId, StagingTableid, StagingColumnName, StagingDataType, StagingLength,
        ReportingDatabaseid, ReportingTableid, ReportingColumnName, ReportingDataType, ReportingLength,
        TransformationRules, IsNullable, IsRequired
    )
    SELECT
        ' + CAST(@SchemaId AS NVARCHAR) + ',
        ' + CAST(@StagingDatabaseId AS NVARCHAR) + ', ' + CAST(@StagingTableId AS NVARCHAR) + ',
        sc.COLUMN_NAME AS StagingColumnName,
        sc.DATA_TYPE AS StagingDataType,
        sc.CHARACTER_MAXIMUM_LENGTH AS StagingLength,
        ' + CAST(@ReportingDatabaseId AS NVARCHAR) + ', ' + CAST(@ReportingTableId AS NVARCHAR) + ',
        rc.COLUMN_NAME AS ReportingColumnName,
        rc.DATA_TYPE AS ReportingDataType,
        rc.CHARACTER_MAXIMUM_LENGTH AS ReportingLength,
        NULL, NULL, NULL, NULL
    FROM
        INFORMATION_SCHEMA.COLUMNS sc
        JOIN INFORMATION_SCHEMA.COLUMNS rc ON sc.COLUMN_NAME = rc.COLUMN_NAME
    WHERE
        sc.TABLE_NAME = ''' + @StagingTableName + '''
        AND rc.TABLE_NAME = ''' + @ReportingTableName + ''';';

-- Execute the dynamic SQL
EXEC sp_executesql @DynamicSQL;
