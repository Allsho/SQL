-- Populate Files table
INSERT INTO Files (FileName) VALUES
('file1.csv'),
('file2.txt'),
-- Add more files as needed
('fileN.csv');

-- Populate Delimiters table
INSERT INTO Delimiters (DelimiterValue) VALUES
(','),
('\t'),
-- Add more delimiters as needed
(';');

-- Populate StagingTables table
INSERT INTO StagingTables (TableName) VALUES
('StagingTable1'),
('StagingTable2'),
-- Add more staging tables as needed
('StagingTableN');

-- Populate FileMappings table
INSERT INTO FileMappings (FileID, DelimiterID, StagingTableID, IncomingColumnHeaders, StagingColumnHeaders, IsRequired) VALUES
(1, 1, 1, 'col1, col2, col3', 'stg_col1, stg_col2, stg_col3', 1),
(2, 2, 2, 'colA, colB, colC', 'stg_colA, stg_colB, stg_colC', 0),
-- Add more mappings as needed
(N, N, N, 'colX, colY, colZ', 'stg_colX, stg_colY, stg_colZ', 1);
