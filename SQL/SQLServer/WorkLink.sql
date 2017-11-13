--
--    WorkLink.SQL
--    Version:   1.0
--
--    Master SQL script to run in sequence all WorkLink SQL scripts
--    Pre-requisite:   Worklink data extract has been restored into the Worklink database
--
USE [Worklink]
:setvar path "e:\inetpub\wwwroot\UoB\SQL\SQLServer\"
--    1.    Create the USP_CREATE_WORKLINKDATA procedure
:r $(path)\CreateWORKLINKDATA.sql

--    2.    Use this procedure to create the WORKLINKDATA table
exec USP_CREATE_WORKLINKDATA;

--    3.    Export the data from WORKLINKDATA to external file
--          N.B.  Just creates a result set which then needs saving from result
--                set window
:r $(path)\ExportWorkLinkToText.sql

--    4.    Create the student ID lookup result set and save as external file
--          N.B.  Just creates a result set which then needs saving from result
--                set window
:r $(path)\CreateStudentIDLookup.sql
