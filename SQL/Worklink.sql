-- Create Worklink data table
@e:\inetpub\wwwroot\UoB\SQL\CreateWorklinkDataTable.sql
desc WorklinkData
SELECT COUNT(*) FROM WORKLINKDATA;

-- Import data from external load file
@e:\inetpub\wwwroot\UoB\SQL\InsertCommand.sql

-- Alta matching process function definition
@e:\inetpub\wwwroot\UoB\SQL\RunMatchWorklink.sql
@e:\inetpub\wwwroot\UoB\SQL\MatchWorklink.sql
@e:\inetpub\wwwroot\UoB\SQL\AnalyseWorklink.sql
commit;

-- Run Alta matching processes
set serveroutput on
exec RunMatchWorklink

--  Quick SQL checks (to validate the above analyses)
select count(*) from worklinkdata where altapersoncode is null or altapersoncode < 1;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 AND StudentForename <> AltaForename;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 and StudentSurname <> AltaSurname;
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 AND TRUNC(StudentDOB) <> TRUNC(AltaDOB);
select count(*) from worklinkdata where altaPersonCode is not null and ALTAPERSONCODE > 0 and StudentNINO <> AltaNINumber;

set serveroutput on
delete from worklinkdata;
commit;
INSERT INTO WORKLINKDATA (studentid,studentidmoddate, studentexpirydate,studentidexpirymoddate,StudentTitle,StudentForename,
StudentSurname,StudentGender, StudentAddress1, StudentAddress2, StudentAddress3, StudentTown, StudentCounty, StudentCountry,  
StudentPostCode, StudentTelephone, StudentEmail, StudentEthnicOrigin,  StudentDOB,StudentNINO,Mod_Date,
AltaPersonCode,AltaForename,AltaSurname,AltaDOb)                                                          
VALUES ( 1508911 , to_date( '2016-03-31','YYYY-MM-DD'), to_date( '2016-03-23','YYYY-MM-DD'), to_date( '2016-03-31','YYYY-MM-DD'), 'Mr' , 'Zhirong' , 
'Liang' , 'Male' , 'Room G47G, Future Engines and Fuels Lab, Mech Eng' , 'University of Brimingham' , '' , 'Edgbaston' , 'Birmingham' ,  , 
'B152TT' , '' , 'ZXL411@bham.ac.uk' , 'Chinese' , to_date( '1988-12-09','YYYY-MM-DD'), 'TN091288M' , to_date( '2016-07-31','YYYY-MM-DD'), 
0,' ',' ',to_date( '1900-01-01','YYYY-MM-DD'));
commit;
select * from worklinkdata;

