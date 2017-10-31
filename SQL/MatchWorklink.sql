CREATE OR REPLACE FUNCTION MatchWorklink
  RETURN NUMBER
IS
  -- Declare cursor to fetch each Worklink studntid in sequence
   CURSOR c1 is
      SELECT STUDENTID
      FROM WORKLINKDATA
      ORDER BY STUDENTID ASC
      FOR UPDATE OF ALTASURNAME, ALTAFORENAME, ALTAPERSONCODE, ALTADOB, ALTAETHNICORIGIN;

  -- Declare local variables
   matchedcount NUMBER(10);
   totalcount NUMBER(10);
   --
   my_studentid NUMBER(10);
   my_alta_forename VARCHAR2(30);
   my_alta_surname VARCHAR2(30);
   my_alta_dob DATE;
   my_ni_number VARCHAR2(10);
   my_ethnic_origin VARCHAR2(40);
   my_alta_flag BOOLEAN;

BEGIN
  -- Initialisation prior to cursor loop
  my_studentid := 0;
  my_alta_forename := '';
  my_alta_surname := '';
  my_alta_dob := to_date('01/01/0001','DD/MM/YYYY');
  my_ni_number := '';
  my_ethnic_origin := '';
  matchedcount := 0;
  totalcount := 0;
  my_alta_flag := FALSE;

  -- Loop through worklinkdata records
    -- ** This needs to change to loop through the cursor
   BEGIN
    OPEN c1;

    LOOP
      FETCH c1 INTO my_studentid;
      EXIT WHEN c1%NOTFOUND;

      totalcount := totalcount + 1;

      -- debugmode
      -- DBMS_OUTPUT.PUT_LINE('NOW LOOKING AT STUDENT '||TO_CHAR(MY_STUDENTID,'9999999999'));

      -- Check if a PERSON_CODE of my_studentid exists on Alta
      my_alta_flag := TRUE;    --  Default to a positive result
      BEGIN
        SELECT forename, surname, date_of_birth, ni_number, ethnic_origin
        INTO my_alta_forename, my_alta_surname, my_alta_dob, my_ni_number, my_ethnic_origin
        FROM HES_PEOPLE
        WHERE person_code = my_studentid;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
          -- set flag
          my_alta_flag := FALSE;
      END;

      -- Update WORKLINKDATA if match found

      IF my_alta_flag THEN

        BEGIN
          UPDATE WORKLINKDATA
          SET AltaSurname = my_alta_surname,
              AltaForename = my_alta_forename,
              AltaPersonCode = my_studentid,
              AltaDOB = my_alta_dob,
              AltaNINumber = my_ni_number,
              AltaEthnicOrigin = my_ethnic_origin
          WHERE CURRENT OF c1;
        END;

        matchedcount := matchedcount + 1;

      END IF;

      -- Re-initialise local variables
      my_studentid := 0;
      my_alta_forename := '';
      my_alta_surname := '';
      my_alta_dob := to_date('01/01/0001','DD/MM/YYYY');
      my_ni_number := '';
      my_ethnic_origin := '';

   END LOOP;
   COMMIT;

   CLOSE c1;

  END;

  -- Textual report on process using DBMS_OUTPUT

  dbms_output.put_line('=====================================================');
  dbms_output.put_line('Summary report from MATCHWORKLINK');
  dbms_output.put_line(' ');
  dbms_output.put_line('Total WorkLink students                '||to_char(totalcount,'999999'));
  dbms_output.put_line('Total matched to Alta                  '||to_char(matchedcount,'999999'));
  dbms_output.put_line(' ');
  dbms_output.put_line('=====================================================');

  RETURN matchedcount;
END;
/
