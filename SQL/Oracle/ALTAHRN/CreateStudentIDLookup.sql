DROP TABLE STUDENTIDLOOKUP;
CREATE TABLE STUDENTIDLOOKUP (
    StudentID NUMBER(10),
    CandidateID NUMBER(10)
  );
desc STUDENTIDLOOKUP;
--
--  Now include output from running CreateStudentIDLookup within
--  SQL Server below
--
--  e.g many lines of the form:
--  insert into studentidlookup(candidateid, studentid) values(17066,1545911);
--  This will normally have been saved as StudentIDLookupInsert.sql 
--





--
-- Now COMMIT this load
--
COMMIT;
