DECLARE 
    @DatabaseName NVARCHAR(255) = 'YourStagingDatabaseName',
    @SchemaName NVARCHAR(255) = 'YourReportingDatabaseName',
	@TableName NVARCHAR(255) = 'YourReportingSchemaName';

-- Insert data into ClaimsDatabaseMapping
INSERT INTO Claims_Database_Mapping (Databasename)
VALUES (@DatabaseName);

-- Insert data into Claim_Schema_Mapping
INSERT INTO Claim_Schema_Mapping (SchemaName)
VALUES (@SchemaName);

-- Insert data into Claim_Table_Mapping
INSERT INTO Claim_Table_Mapping (Tablename)
VALUES (@TableName);
