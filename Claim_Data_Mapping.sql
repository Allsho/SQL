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

using System;
using System.IO;
using OfficeOpenXml;

class Program
{
    static void Main()
    {
        try
        {
            // Replace "your_excel_file.xlsx" with the actual path to your Excel file
            string excelFilePath = "your_excel_file.xlsx";

            // Load Excel package
            using (var package = new ExcelPackage(new FileInfo(excelFilePath)))
            {
                // Access the worksheet
                var worksheet = package.Workbook.Worksheets[0];

                // Access headers and fix formatting issues
                FixHeaderFormatting(worksheet);

                // Save the modified Excel file
                package.Save();

                Console.WriteLine("Header formatting fixed. You can now proceed with SSIS CSV conversion.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred: {ex.Message}");
        }
    }

    static void FixHeaderFormatting(ExcelWorksheet worksheet)
    {
        // Specify the column index where you want to fix header formatting
        int columnIndex = 1; // Replace with the actual column index

        // Access the header cell
        var headerCell = worksheet.Cells[1, columnIndex];

        // Modify the header as needed (remove line breaks, special characters, etc.)
        string fixedHeaderText = headerCell.Text.Replace("\n", "").Replace("\r", "");

        // Update the header cell
        headerCell.Value = fixedHeaderText;
    }
}
*/