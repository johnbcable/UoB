-- Create Worklink data table
@e:\inetpub\wwwroot\UoB\SQL\CreateWorklinkDataTable.sql
desc WorklinkData
SELECT COUNT(*) FROM WORKLINKDATA;

-- Alta matching process function definition
@e:\inetpub\wwwroot\UoB\SQL\RunMatchWorklink.sql
@e:\inetpub\wwwroot\UoB\SQL\MatchWorklink.sql
@e:\inetpub\wwwroot\UoB\SQL\AnalyseWorklink.sql
commit;

set serveroutput on
exec RunMatchWorklink

--  Quick SQL checks
select count(*) from worklinkdata where altapersoncode is null or altapersoncode < 1;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 AND StudentForename <> AltaForename;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 and StudentSurname <> AltaSurname;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 AND TRUNC(StudentDOB) <> TRUNC(AltaDOB);
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 and StudentNINO <> AltaNINumber;


select * from WORKLINKDATA;
drop function MatchWorklink;
DESC HES_PEOPLE

select min(person_code) from hes_people;

SELECT * FROM WORKLINKDATA;

