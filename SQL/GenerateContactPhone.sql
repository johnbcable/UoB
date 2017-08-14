CREATE OR REPLACE FUNCTION GenerateContactPhone
  RETURN NUMBER
IS

   CURSOR c1 is
      SELECT 'ALTAHRN01' as SourceSystemOwner, to_char(person_code,'9999999999') as personcode, to_char(preference,'09') as preference, start_date, nvl(end_date,to_date('4712/12/31','YYYY/MM/DD')) as end_date, Trim(REGEXP_REPLACE(telephone,'[[:space:]]','')) as telephone
        FROM upay_next_of_kin@hr_link
        WHERE person_code is NOT NULL and surname IS NOT NULL AND telephone IS NOT NULL
         ORDER BY person_code ASC;

   CURSOR c2 is
      SELECT 'ALTAHRN01' as SourceSystemOwner, to_char(person_code,'9999999999') as personcode, to_char(preference,'09') as preference, start_date, nvl(end_date,to_date('4712/12/31','YYYY/MM/DD')) as end_date, Trim(REGEXP_REPLACE(mobile,'[[:space:]]','')) as mobile
      FROM upay_next_of_kin@hr_link
      WHERE person_code is NOT NULL and surname IS NOT NULL AND mobile IS NOT NULL
      ORDER BY person_code ASC;

/*
TELEPHONE                        VARCHAR2(22)
MOBILE                           VARCHAR2(22)
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
   my_phonetype VARCHAR2(32);
   my_phone VARCHAR2(24);
   my_mobile VARCHAR(24);

   my_source_system_id VARCHAR2(100);
   my_person_id VARCHAR2(100);

   metadataline VARCHAR2(255);
   -- File handler stuff
   fileHandler UTL_FILE.FILE_TYPE;

BEGIN
  -- Metadata definition
  metadataline := 'METADATA|ContactPhone|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|PhoneType|PhoneNumber|DateFrom|DateTo|LegislationCode|PrimaryFlag';

  fileHandler := UTL_FILE.FOPEN('MIGRATION_SHARED_DIR', 'ContactPhone.dat', 'W');
  UTL_FILE.PUT_LINE(fileHandler, metadataline);
  UTL_FILE.PUT_LINE(fileHandler, 'COMMENT  ######');
  UTL_FILE.PUT_LINE(fileHandler, 'COMMENT  #  Home phone numbers first');
  UTL_FILE.PUT_LINE(fileHandler, 'COMMENT  ######');

  outputkount := 0;

    -- Loop through home phone data records
  OPEN c1;
    -- Set up limited loop
   FOR i IN 1..40000 LOOP
      FETCH c1 INTO    my_source_system_owner, my_personcode, my_preference, my_start_date, my_end_date, my_phone;

      EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                              /* is more than the total       */
                              /* number of employees          */

      my_source_system_id := Trim(my_personcode)||'-CONTHOMEPHON-'||Trim(my_preference);
      my_person_id :=  Trim(my_personcode)||'-CONT-'||Trim(my_preference);

      -- We now have this info in these local variables and can do stuff with them
      -- e.g.
      my_start := to_char(my_start_date,'YYYY/MM/DD');
      my_end := to_char(my_end_date,'YYYY/MM/DD');

      IF my_end = '2199/12/31'
      THEN
        my_end := '4712/12/31';
      END IF;

/*
METADATA|ContactPhone|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|PhoneType|PhoneNumber|DateFrom|DateTo|LegislationCode|PrimaryFlag
MERGE|ContactPhone|ALTAHRN01|50000500-CONTPHON-01|50000500-CONT-01|H1|01675 443085|2016/07/04|4712/12/31|GB|Y
*/

        UTL_FILE.PUT_LINE(filehandler,'MERGE|ContactPhone|'||my_source_system_owner||'|'||my_source_system_id||'|'||my_person_id||'|H1|'||my_phone||'|'||my_start||'|'||my_end||'GB|Y');
        outputkount := outputkount + 1;

   END LOOP;
   CLOSE c1;

   UTL_FILE.PUT_LINE(fileHandler, 'COMMENT  ######');
   UTL_FILE.PUT_LINE(fileHandler, 'COMMENT  #  Mobile phone numbers second');
   UTL_FILE.PUT_LINE(fileHandler, 'COMMENT  ######');

   -- Loop through mobile phone data records

   OPEN c2;
     -- Set up limited loop
    FOR i IN 1..40000 LOOP
       FETCH c2 INTO  my_source_system_owner, my_personcode, my_preference, my_start_date, my_end_date, my_mobile;

       EXIT WHEN c2%NOTFOUND;  /* in case the number requested */
                               /* is more than the total       */
                               /* number of employees          */

       my_source_system_id := Trim(my_personcode)||'-CONTMOBPHON-'||Trim(my_preference);
       my_person_id :=  Trim(my_personcode)||'-CONT-'||Trim(my_preference);

       -- We now have this info in these local variables and can do stuff with them
       -- e.g.
       my_start := to_char(my_start_date,'YYYY/MM/DD');
       my_end := to_char(my_end_date,'YYYY/MM/DD');

       IF my_end = '2199/12/31'
       THEN
         my_end := '4712/12/31';
       END IF;

       UTL_FILE.PUT_LINE(filehandler,'MERGE|ContactPhone|'||my_source_system_owner||'|'||my_source_system_id||'|'||my_person_id||'|M1|'||my_mobile||'|'||my_start||'|'||my_end||'GB|N');
       outputkount := outputkount + 1;

   END LOOP;
   CLOSE c2;

   UTL_FILE.FCLOSE(fileHandler);
   RETURN outputkount;
EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;

/
