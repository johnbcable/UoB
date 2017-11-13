--
--    WorkLink.SQL
--    Version:   1.0
--
--    Master SQL script to run in sequence all WorkLink SQL scripts in Oracle SQL Developer
--    Pre-requisite:   Connection to ALTAHRN database
--
--    N.B.  This version assumes all scripts are located in the E:\INETPUB\WWWROOT\UOB\SQL directory
--

-- 1. Create Worklink data table
--    N.B.  Script will DROP the WORKLINKDATA table
@e:\inetpub\wwwroot\UoB\SQL\CreateWorklinkDataTable.sql
-- Check table has been created OK
desc WorklinkData

-- Import data into WORKLINKDATA from external load file
-- Clear out WORKLINKDATA before insert
DELETE FROM WORKLINKDATA;
-- Import query results from SQL Server into WORKLINKDATA
set autocommit on
@e:\inetpub\wwwroot\UoB\SQL\InsertCommand.sql

-- Create WorkLink ethnic origins table and populate it
@e:\inetpub\wwwroot\UoB\SQL\CreateWorklinkEthnicOrigins.sql
SELECT * FROM WORKLINKETHNICORIGINS

-- Create all the necessary functions on the Oracle database
-- Create the function to map WorklInk Ethnicity
@e:\inetpub\wwwroot\UoB\SQL\MapWorklinkEthnicity.sql
-- Create the function to match worklink against alta
@e:\inetpub\wwwroot\UoB\SQL\MatchWorklink.sql
-- Create the function to analyse matched worklink data
@e:\inetpub\wwwroot\UoB\SQL\AnalyseWorklink.sql

-- Now run the Alta matching process and summary reporting
-- Run Alta matching processes
set serveroutput on
exec RunMatchWorklink

--
-- **************  END OF DATA MATCHING AND ANALYSIS   ****************
--

-- OPTIONAL  - only if attempting to process WorkLink file metdata

-- Create Worklink files table
--    N.B.  Script will DROP the WORKLINKFILES table
@e:\inetpub\wwwroot\UoB\SQL\CreateWorklinkFilesTable.sql
desc WORKLINKFILES;

-- Import files data from external load file
DELETE FROM WORKLINKFILES;
@e:\inetpub\wwwroot\UoB\SQL\WLdocs.sql
commit;
select count(*) from worklinkfiles;

-- Create Worklink STUDENTid LOOKUP table
--    N.B.  Script will DROP the STUDENTIDLOOKUP table
@e:\inetpub\wwwroot\UoB\SQL\CreateStudentIDLookup.sql
-- Check that table was crewated OK
DESC STUDENTIDLOOKUP;
-- Check that data was also loaded OK into table
-- N.B.  This will only be the case if the script had
--       been augmented by including the StudentIDLookupInsert.sql
--       result set from SQL Server
SELECT COUNT(*) FROM STUDENTIDLOOKUP;
-- Create the function to match student ID to candidate ID
@e:\inetpub\wwwroot\UoB\SQL\MatchStudentID.sql
-- Now run the Alta matching process
set serveroutput on
@e:\inetpub\wwwroot\UoB\SQL\RunMatchStudentID.sql
exec RunMatchStudentID;
