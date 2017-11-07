CREATE OR REPLACE FUNCTION MatchStudentID
  RETURN NUMBER
IS
  -- Declare cursor to fetch each Worklink studntid in sequence
   CURSOR c1 is
      SELECT CANDIDATEID
      FROM WORKLINKFILES
      ORDER BY CANDIDATEID ASC
      FOR UPDATE OF STUDENTID;

  -- Declare local variables
   matchedcount NUMBER(10);
   totalcount NUMBER(10);
   --
   my_studentid NUMBER(10);
   my_candidateid NUMBER(10);
   my_update_flag BOOLEAN;

BEGIN
  -- Initialisation prior to cursor loop
  my_studentid := 0;
  my_candidateid := 0;
  matchedcount := 0;
  totalcount := 0;
  my_update_flag := FALSE;

  -- Loop through worklinkdata records
    -- ** This needs to change to loop through the cursor
   BEGIN
    OPEN c1;

    LOOP
      FETCH c1 INTO my_candidateid;
      EXIT WHEN c1%NOTFOUND;

      totalcount := totalcount + 1;

      -- debugmode
      -- DBMS_OUTPUT.PUT_LINE('NOW LOOKING AT STUDENT '||TO_CHAR(MY_STUDENTID,'9999999999'));

      -- Check if a studentid exists on Alta relating to this candiate id
      my_update_flag := TRUE;    --  Default to a positive result
      BEGIN
        SELECT studentid
        INTO my_studentid
        FROM studentidlookup
        WHERE candidateid = my_candidateid;
      EXCEPTION
          WHEN NO_DATA_FOUND THEN
          -- set flag
          my_update_flag := FALSE;
      END;

      -- Update WORKLINKDATA if match found

      IF my_update_flag THEN

        BEGIN
          UPDATE WORKLINKFILES
          SET StudentID = my_studentid
          WHERE CURRENT OF c1;
        END;

        matchedcount := matchedcount + 1;

      END IF;

      -- Re-initialise local variables
      my_studentid := 0;
      my_candidateid := 0;

   END LOOP;
   COMMIT;

   CLOSE c1;

  END;

  -- Textual report on process using DBMS_OUTPUT

  dbms_output.put_line('=====================================================');
  dbms_output.put_line('Summary report from MATCHSTUDENTID');
  dbms_output.put_line(' ');
  dbms_output.put_line('Total WorkLink candidates                '||to_char(totalcount,'999999'));
  dbms_output.put_line('Total matched to students                '||to_char(matchedcount,'999999'));
  dbms_output.put_line(' ');
  dbms_output.put_line('=====================================================');

  RETURN matchedcount;
END;
/
