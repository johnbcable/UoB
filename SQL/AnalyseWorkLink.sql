CREATE OR REPLACE FUNCTION AnalyseWorkLink
  RETURN NUMBER
IS
  -- Declare cursor to fetch each matched Worklink record in sequence
   CURSOR c1 is
      SELECT STUDENTID, STUDENTFORENAME, STUDENTSURNAME, STUDENTNINO, TRUNC(STUDENTDOB),
            ALTAFORENAME, ALTASURNAME, ALTANINUMBER, TRUNC(ALTADOB)
      FROM WORKLINKDATA
      WHERE ALTAPERSONCODE IS NOT NULL and ALTAPERSONCODE > 0 
      ORDER BY STUDENTID ASC;

  -- Declare local variables
   totalcount NUMBER(10);
   forenamediffers NUMBER(10);
   surnamediffers NUMBER(10);
   dobdiffers NUMBER(10);
   nidiffers NUMBER(10);
   --
   my_studentid WORKLINKDATA.StudentID%TYPE;
   my_alta_forename VARCHAR2(30);
   my_alta_surname VARCHAR2(30);
   my_alta_dob DATE;
   my_alta_ni_number VARCHAR2(10);
   my_forename WORKLINKDATA.StudentForename%TYPE;
   my_surname WORKLINKDATA.StudentSurname%TYPE;
   my_dob WORKLINKDATA.StudentDOB%TYPE;
   my_ni_number WORKLINKDATA.StudentNINO%TYPE;

BEGIN
  -- Initialisation prior to cursor loop
  my_studentid := 0;
  my_alta_forename := '';
  my_alta_surname := '';
  my_alta_dob := to_date('01/01/0001','DD/MM/YYYY');
  my_alta_ni_number := '';
  my_forename := '';
  my_surname := '';
  my_dob := to_date('01/01/0001','DD/MM/YYYY');
  my_ni_number := '';
  forenamediffers := 0;
  surnamediffers := 0;
  dobdiffers := 0;
  nidiffers := 0;
  totalcount := 0;

  -- Loop through matched worklinkdata records
   BEGIN
    OPEN c1;

    LOOP
      FETCH c1 INTO my_studentid, my_forename, my_surname, my_ni_number, my_dob, my_alta_forename, my_alta_surname, my_alta_ni_number, my_alta_dob;
      EXIT WHEN c1%NOTFOUND;

      totalcount := totalcount + 1;

      -- debugmode
      -- DBMS_OUTPUT.PUT_LINE('NOW LOOKING AT STUDENT '||TO_CHAR(MY_STUDENTID,'9999999999'));

      -- Start checks
      -- 1. Surname
      IF my_alta_surname != my_surname THEN
        surnamediffers := surnamediffers + 1;
      END IF;

      -- 2.  Forename
      IF my_alta_forename != my_forename THEN
        forenamediffers := forenamediffers + 1;
      END IF;

      -- 3. Date of birth
      IF my_alta_dob != my_dob THEN
        dobdiffers := dobdiffers + 1;
      END IF;

      -- 4. Date of birth
      IF my_alta_ni_number != my_ni_number THEN
        nidiffers := nidiffers + 1;
      END IF;

      -- Re-initialise local variables
      my_studentid := 0;
      my_alta_forename := '';
      my_alta_surname := '';
      my_alta_dob := to_date('01/01/0001','DD/MM/YYYY');
      my_alta_ni_number := '';
      my_forename := '';
      my_surname := '';
      my_dob := to_date('01/01/0001','DD/MM/YYYY');
      my_ni_number := '';

   END LOOP;
   COMMIT;

   CLOSE c1;

  END;

  -- Textual report on process using DBMS_OUTPUT

  dbms_output.put_line('=====================================================');
  dbms_output.put_line('Summary report from ANALYSEWORKLINK');
  dbms_output.put_line(' ');
  dbms_output.put_line('Total Matched WorkLink students        '||to_char(totalcount,'999999'));
  dbms_output.put_line('Total Surnames That Differ             '||to_char(surnamediffers,'999999'));
  dbms_output.put_line('Total Forenames That Differ            '||to_char(forenamediffers,'999999'));
  dbms_output.put_line('Total Dates of Birth That Differ       '||to_char(dobdiffers,'999999'));
  dbms_output.put_line('Total NI Numbers That Differ           '||to_char(nidiffers,'999999'));
  dbms_output.put_line(' ');
  dbms_output.put_line('=====================================================');

  RETURN totalcount;
END;
/
