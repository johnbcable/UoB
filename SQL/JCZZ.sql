CREATE OR REPLACE FUNCTION JCZZ
  RETURN NUMBER
IS

   CURSOR c1 is
      SELECT person_code, forename, middle_names, surname, known_as, previous_surname, title
        FROM hes_people@hr_link
        WHERE person_code is NOT NULL and surname IS NOT NULL
         ORDER BY person_code ASC;
  -- Declare local variables
   outputkount  NUMBER(10);
   my_person_code NUMBER(10);
   my_forename VARCHAR2(30);
   my_middle_names VARCHAR2(240);
   my_surname VARCHAR2(30);
   my_knownas VARCHAR2(30);
   my_previous_surname VARCHAR2(30);
   my_title VARCHAR2(8);
   -- File handler stuff
   fileHandler UTL_FILE.FILE_TYPE;

BEGIN
  outputkount := 0;
  fileHandler := UTL_FILE.FOPEN('MIGRATION_SHARED_DIR', 'PersonName.dat', 'W');
  UTL_FILE.PUT_LINE(fileHandler, 'METADATA|Personname|PersonNumber|LegislationCode|NameType|FirtsName|MiddleNames|LastName|KnownAs|PreviousLastName|Title');
  OPEN c1;
    -- Set up limited loop
   FOR i IN 1..100 LOOP
      FETCH c1 INTO    my_person_code, my_forename, my_middle_names, my_surname, my_knownas, my_previous_surname, my_title;

      EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                              /* is more than the total       */
                              /* number of employees          */

      -- We now have this info in these local variables and can do stuff with them
      -- e.g.
      my_title := upper(my_title);     -- convert to upper case
      my_forename := trim(my_forename);
      my_middle_names := trim(my_middle_names);
      my_surname := trim(my_surname);
      my_knownas := trim(my_knownas);
      my_previous_surname := trim(my_previous_surname);
      my_title := trim(my_title);
      UTL_FILE.PUT_LINE(filehandler,'MERGE|PersonName|'||my_person_code||'|GB||'||my_forename||'|'||my_middle_names||'|'||my_surname||'|'||my_knownas||'|'||my_previous_surname||'|'||my_title);
      outputkount := outputkount + 1;
   END LOOP;
   CLOSE c1;
   UTL_FILE.FCLOSE(fileHandler);
   RETURN outputkount;
EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;

/
