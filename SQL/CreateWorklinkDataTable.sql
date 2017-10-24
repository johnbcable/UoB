DROP TABLE WORKLINKDATA;
CREATE TABLE WORKLINKDATA (
    StudentID NUMBER(10),
    StudentIDModDate DATE,
    StudentExpiryDate DATE,
    StudentIDExpiryModDate DATE,
    StudentForename VARCHAR2(255),
    StudentSurname VARCHAR2(255),
    StudentDOB DATE,
    StudentNINO VARCHAR2(255),
    Mod_Date DATE,
    AltaPersonCode NUMBER(10),
    AltaForename VARCHAR2(30),
    AltaSurname VARCHAR2(30),
    AltaDOB DATE,
    AltaNINUmber VARCHAR2(10)
);

ALTER TABLE WORKLINKDATA ADD (AltaNINumber VARCHAR2(10));
