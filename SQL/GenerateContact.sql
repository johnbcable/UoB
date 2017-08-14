CREATE OR REPLACE FUNCTION GenerateContact
  RETURN NUMBER
IS

   CURSOR c1 is
      SELECT 'ALTAHRN01' as SourceSystemOwner, to_char(person_code,'9999999999') as personcode, to_char(preference,'09') as preference, start_date, nvl(end_date,to_date('4712/12/31','YYYY/MM/DD')) as end_date
        FROM upay_next_of_kin@hr_link
        WHERE person_code is NOT NULL and surname IS NOT NULL
         ORDER BY person_code ASC;
  -- Declare local variables
   outputkount  NUMBER(10);
   --
   my_person_code NUMBER(10);
   my_source_system_owner VARCHAR2(30);
   my_personcode VARCHAR2(12);
   my_preference VARCHAR2(3);
   my_source_system_id VARCHAR2(100);
   my_start_date DATE;
   my_end_date DATE;
   my_start VARCHAR2(10);
   my_end VARCHAR2(10);

   metadataline VARCHAR2(255);
   -- File handler stuff
   fileHandler UTL_FILE.FILE_TYPE;

BEGIN
  -- Metadata definition
  metadataline := 'METADATA|Contact|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|StartDate';

  fileHandler := UTL_FILE.FOPEN('MIGRATION_SHARED_DIR', 'Contact.dat', 'W');
  UTL_FILE.PUT_LINE(fileHandler, metadataline);

  outputkount := 0;
  -- Loop through data records
  OPEN c1;
    -- Set up limited loop
   FOR i IN 1..40000 LOOP
      FETCH c1 INTO    my_source_system_owner, my_personcode, my_preference, my_start_date, my_end_date;

      EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                              /* is more than the total       */
                              /* number of employees          */

      my_source_system_id := Trim(my_personcode)||'-CONT-'||Trim(my_preference);

      -- We now have this info in these local variables and can do stuff with them
      -- e.g.
      my_start := to_char(my_start_date,'YYYY/MM/DD');
      my_end := to_char(my_end_date,'YYYY/MM/DD');

      IF my_end = '2199/12/31'
      THEN
        my_end := '4712/12/31';
      END IF;

      UTL_FILE.PUT_LINE(filehandler,'MERGE|Contact|'||my_source_system_owner||'|'||my_source_system_id||'|'||my_start||'|'||my_end||'|'||my_start); outputkount := outputkount + 1;
   END LOOP;
   CLOSE c1;
   UTL_FILE.FCLOSE(fileHandler);
   RETURN outputkount;
EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;

/
