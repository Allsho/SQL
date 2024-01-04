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


/*
(DT_WSTR, 4)YEAR(DT_DATE) + RIGHT("0" + (DT_WSTR, 2)MONTH(DT_DATE), 2) +
(
    FINDSTRING(UPPER(SUBSTRING(@[User::FileName], FINDSTRING(@[User::FileName], "_", 1) + 1, LEN(@[User::FileName]) - FINDSTRING(@[User::FileName], "_", 1) - 5)),
    "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC", 1) + 2) % 12
)
*/