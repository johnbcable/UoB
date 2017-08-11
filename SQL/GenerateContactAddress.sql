CREATE OR REPLACE FUNCTION GenerateContactAddress
  RETURN NUMBER
IS

  -- Cursor definition needs to include cohort selection?
   CURSOR c1 is
      SELECT 'ALTAHRN01' as SourceSystemOwner, to_char(person_code,'9999999999') as personcode, to_char(preference,'09') as preference, start_date, nvl(end_date,to_date('4712/12/31','YYYY/MM/DD')) as end_date, address_line_1, address_line_2, address_line_3, address_line_4, town, region, country, Trim(uk_post_code_pt1)||' '||Trim(uk_Post_code_pt2) as postcode
        FROM upay_next_of_kin@hr_link
        WHERE person_code is NOT NULL AND address_line_1 IS NOT NULL and Trim(uk_post_code_pt1)||' '||Trim(uk_Post_code_pt2) not like ' '
         ORDER BY person_code ASC;

/*
EMAIL_ADDRESS           VARCHAR2(255)
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
   my_address1 VARCHAR2(33);
   my_address2 VARCHAR2(33);
   my_address3 VARCHAR2(33);
   my_address4 VARCHAR2(33);
   my_town VARCHAR2(31);
   my_region VARCHAR2(33);
   my_country VARCHAR2(33);
   my_postcode VARCHAR2(65);

   my_source_system_id VARCHAR2(100);
   my_person_id VARCHAR2(100);

   metadataline VARCHAR2(255);
   -- File handler stuff
   fileHandler UTL_FILE.FILE_TYPE;

BEGIN
  -- Metadata definition
  metadataline := 'METADATA|ContactAddress|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|AddressType|AddressLine1|AddressLine2|AddressLine3|AddressLine4|TownOrCity|Region1|Country|PostalCode|PrimaryFlag';

  fileHandler := UTL_FILE.FOPEN('MIGRATION_SHARED_DIR', 'ContactAddress.dat', 'W');
  UTL_FILE.PUT_LINE(fileHandler, metadataline);

  outputkount := 0;
  -- Loop through data records
  OPEN c1;
    -- Set up limited loop
   FOR i IN 1..40000 LOOP
      FETCH c1 INTO    my_source_system_owner, my_personcode, my_preference, my_start_date, my_end_date, my_address1,  my_address2,  my_address3,  my_address4, my_town, my_region, my_country, my_postcode;

      EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                              /* is more than the total       */
                              /* number of employees          */

      my_source_system_id := Trim(my_personcode)||'-CONTADD-'||Trim(my_preference);
      my_person_id :=  Trim(my_personcode)||'-CONT-'||Trim(my_preference);

      -- We now have this info in these local variables and can do stuff with them
      -- e.g.
      my_start := to_char(my_start_date,'YYYY/MM/DD');
      my_end := to_char(my_end_date,'YYYY/MM/DD');

      IF my_end = '2199/12/31'
      THEN
        my_end := '4712/12/31';
      END IF;

      --  Need to make sure the country is changed to a Fusiuon-compatible one.
      --  All postal addresses are assumed to be HOME ones
      --  As there is only one address per contact, it will be the primary one.

      UTL_FILE.PUT_LINE(filehandler,'MERGE|ContactAddress|'||my_source_system_owner||'|'||my_source_system_id||'|'||my_person_id||'|'||my_start||'|'||my_end||'|HOME|'||Trim(my_address1)||'|'||Trim(my_address2)||'|'||Trim(my_address3)||'|'||Trim(my_address4)||'|'||my_town||'|'||my_region||'|'||my_country||'|'||my_postcode||'|'||'Y');

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
