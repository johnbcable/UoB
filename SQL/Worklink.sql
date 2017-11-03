-- Create Worklink data table
@e:\inetpub\wwwroot\UoB\SQL\CreateWorklinkDataTable.sql
desc WorklinkData
SELECT COUNT(*) FROM WORKLINKDATA;
@e:\inetpub\wwwroot\UoB\SQL\CreateWorklinkEthnicOrigins.sql
SELECT * FROM WORKLINKETHNICORIGINS



-- Import data from external load file
-- Clear out WORKLINKDATA before insert
DELETE FROM WORKLINKDATA;
-- Import query results from SQL Server
set autocommit on
@e:\inetpub\wwwroot\UoB\SQL\InsertCommand.sql

-- Alta matching process function definition
@e:\inetpub\wwwroot\UoB\SQL\MapWorklinkEthnicity.sql
@e:\inetpub\wwwroot\UoB\SQL\RunMatchWorklink.sql
@e:\inetpub\wwwroot\UoB\SQL\MatchWorklink.sql
@e:\inetpub\wwwroot\UoB\SQL\AnalyseWorklink.sql
commit;

-- Run Alta matching processes
set serveroutput on
exec RunMatchWorklink

--  Quick SQL checks (to validate the above analyses)
select studentethnicorigin, altaethnicorigin from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0;
select distinct studentethnicorigin from worklinkdata order by studentethnicorigin;
SELECT SUBSTR(STUDENTETHNICORIGIN,1,50), SUBSTR(MapWorklinkEthnicity(STUDENTETHNICORIGIN),1,30) FROM WORKLINKDATA;
select count(*) from worklinkdata where altapersoncode is null or altapersoncode < 1;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 AND StudentForename <> AltaForename;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 and StudentSurname <> AltaSurname;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 AND TRUNC(StudentDOB) <> TRUNC(AltaDOB);
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 and StudentNINO <> AltaNINumber;

select substr(studentethnicorigin,1,50), altaethnicorigin from worklinkethnicorigins order by studentethnicorigin;

desc hes_people
select address_type from hes_addresses group by address_type;
select owner_ref, count(*) as kount from hes_addresses where owner_type = 'P' and address_type = 'H' and end_date is null group by owner_ref having count(*) > 1 order by 2 desc;
