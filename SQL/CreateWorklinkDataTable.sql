DROP TABLE WORKLINKDATA;
CREATE TABLE WORKLINKDATA (
    StudentID NUMBER(10),
    StudentIDModDate DATE,
    StudentExpiryDate DATE,
    StudentExpiryModDate DATE,
    StudentTitle VARCHAR2(100),
    StudentForename VARCHAR2(100),
    StudentSurname VARCHAR2(100),
    StudentGender VARCHAR2(50),
    StudentAddress1 VARCHAR2(100),
    StudentAddress2 VARCHAR2(100),
    StudentAddress3 VARCHAR2(100),
    StudentTown VARCHAR2(100),
    StudentCounty VARCHAR2(100),
    StudentCountry VARCHAR2(100),
    StudentPostCode VARCHAR2(50),
    StudentTelephone VARCHAR2(255),
    StudentEmail VARCHAR2(255),
    StudentEthnicOrigin VARCHAR2(100),
    StudentDOB DATE,
    StudentNINO VARCHAR2(50),
    StudentModDate DATE,
    AltaPersonCode NUMBER(10),
    AltaForename VARCHAR2(30),
    AltaSurname VARCHAR2(30),
    AltaDOB DATE,
    AltaNINumber VARCHAR2(10) 
);

desc worklinkdata