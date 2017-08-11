CREATE OR REPLACE FUNCTION GenerateContactName
  RETURN NUMBER
IS

  -- Cursor definition needs to include chort selection?
   CURSOR c1 is
      SELECT 'ALTAHRN01' as SourceSystemOwner, to_char(person_code,'9999999999') as personcode, to_char(preference,'09') as preference, start_date, nvl(end_date,to_date('4712/12/31','YYYY/MM/DD')) as end_date, forename, surname, NVL(TRIM(title),'NONE') as title
        FROM upay_next_of_kin@hr_link
        WHERE person_code is NOT NULL and surname IS NOT NULL and (end_date is null OR end_date = to_date('31/12/2199','DD/MM/YYYY'))
         ORDER BY person_code ASC;

/*
TITLE                            VARCHAR2(8)
FORENAME                NOT NULL VARCHAR2(30)
SURNAME                 NOT NULL VARCHAR2(30)
*/

  -- Declare local variables
   outputkount  NUMBER(10);
   --
   my_source_system_owner VARCHAR2(30);
   my_personcode VARCHAR2(12);
   my_preference VARCHAR2(3);
   my_start_date DATE;
   my_end_date DATE;
   my_start VARCHAR2(10);
   my_end VARCHAR2(10);
   my_forename VARCHAR2(32);
   my_surname VARCHAR2(32);
   my_title VARCHAR2(10);

   my_source_system_id VARCHAR2(100);
   my_person_id VARCHAR2(100);

   metadataline VARCHAR2(255);
   -- File handler stuff
   fileHandler UTL_FILE.FILE_TYPE;

BEGIN
  -- Metadata definition
  metadataline := 'METADATA|ContactName|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|EffectiveStartDate|EffectiveEndDate|LegislationCode|NameType|FirstName|LastName|Title';

  fileHandler := UTL_FILE.FOPEN('MIGRATION_SHARED_DIR', 'ContactName.dat', 'W');
  UTL_FILE.PUT_LINE(fileHandler, metadataline);

  outputkount := 0;
  -- Loop through data records
  OPEN c1;
    -- Set up limited loop
   FOR i IN 1..40000 LOOP
      FETCH c1 INTO    my_source_system_owner, my_personcode, my_preference, my_start_date, my_end_date, my_forename, my_surname, my_title;

      EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                              /* is more than the total       */
                              /* number of employees          */

      my_source_system_id := Trim(my_personcode)||'-CONTNAME-'||Trim(my_preference);
      my_person_id :=  Trim(my_personcode)||'-CONT-'||Trim(my_preference);

      -- We now have this info in these local variables and can do stuff with them
      -- e.g.
      my_start := to_char(my_start_date,'YYYY/MM/DD');
      my_end := to_char(my_end_date,'YYYY/MM/DD');

      IF my_end = '2199/12/31'
      THEN
        my_end := '4712/12/31';
      END IF;

      -- Need to build in translation of TITLE on AltaHR to Title in loader files
      my_title := getFusionTitle(my_title);
      IF my_title = 'NONE'
      THEN
        my_title := '';
      END IF;

      UTL_FILE.PUT_LINE(filehandler,'MERGE|ContactName|'||my_source_system_owner||'|'||my_source_system_id||'|'||my_person_id||'|'||my_start||'|'||my_end||'GB|GLOBAL|'||my_forename||'|'||my_surname||'|'||my_title);

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
