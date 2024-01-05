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



/*

import pandas as pd

def clean_header(header):
    # Your cleaning logic goes here
    cleaned_header = header.replace('\n', '').replace('\r', '').replace('#', '').strip()
    return cleaned_header

def clean_and_convert_excel_to_csv(input_excel_path, output_csv_path):
    # Read the Excel file
    df = pd.read_excel(input_excel_path)

    # Clean the header row
    cleaned_headers = [clean_header(header) for header in df.columns]
    df.columns = cleaned_headers

    # Save to CSV
    df.to_csv(output_csv_path, index=False)

# Specify your input and output file paths
input_excel_path = 'path/to/your/input_excel_file.xlsx'
output_csv_path = 'path/to/your/output_csv_file.csv'

# Call the function to clean and convert
clean_and_convert_excel_to_csv(input_excel_path, output_csv_path)


*/