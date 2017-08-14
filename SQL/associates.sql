CREATE OR REPLACE VIEW JC_ASSOCIATES AS SELECT
uas.person_code as uaspcode,
  hp.person_code,
uas.department_code,
uas.associate_category,
uas.start_date as assoc_start_date,
uas.end_date as assoc_end_date,
uas.line_mgr_person_code,
uas.ignore,
  TRIM(REGEXP_REPLACE(hp.Forename|| ' ' || hp.middle_names || ' ' || hp.Surname, ' +', ' ')) AS Name ,
  hp.title,
  hp.Forename,
  hp.middle_names,
  hp.Surname,
  hp.date_of_birth,
  hp.ni_number,
  hp.altahr_username AS ADF_USERNAME,
  hp.ALTAHR_EMAIL_ADDRESS AS University_Work_Email_Address,
   hp.altahr_personal_email_address,
   uas.created_date,
   uas.comments,
   hp.PREVIOUS_SURNAME
, hp.SEX
, hp.COUNTRY_OF_BIRTH
, hp.ETHNIC_ORIGIN
, hp.NATIONALITY
, hp.SECOND_NATIONALITY
, hp.KNOWN_AS
, hp.MARITAL_STATUS
, hp.DISABILITY_REG_NO
, hp.PASSPORT_NUMBER
, hp.EXPECTED_RETIREMENT_DATE
, hp.ACTUAL_RETIREMENT_DATE
, hp.NATURE_OF_QUALS
, hp.RELIGIOUS_AFFILIATION
, hp.EXCLUDED_BY
, hp.DATE_EXCLUDED
, hp.EXCLUSION_REASON
, hp.REINSTATED_BY
, hp.DATE_REINSTATED
, hp.INITIALS
, hp.DISABILITY_REG_START
, hp.UCAS_MATCH_INDICATOR
, hp.HO_REF
, hp.DE_REF
, hp.PASSPORT_EXPIRY_DATE
, hp.ISSUING_GOVT
, hp.DATE_UK_VISIT
, hp.PURPOSE_VISIT
, hp.DECORATIONS
, hp.LOCATION
, hp.HESA_STAFF_IDENTIFIER
, hp.HESA_DATE_OF_ENTRY
, hp.HESA_DISABLED_INDICATOR
, hp.ACTIVE_IN_92_RES_ASSESSMENT
, hp.ABLE_TO_TEACH_IN_WELSH
, hp.TEACHING_IN_WELSH
, hp.SNAME16
, hp.HESA_STU_DIS_INDICATOR
, hp.CALENDAR_ENTRY
, hp.D_O_B_VERIFIED
, hp.UOA_IN_LAST_RES_ASSESSMENT
, hp.HESA_SENPH
, hp.IMMIGRATION_STATUS
, hp.ALTAHR_PREVHEI
, hp.ALTAHR_WELSH_NATID1
, hp.ALTAHR_WELSH_NATID2
, hp.ALTAHR_NISR_DISABLED
, hp.ALTAHR_REGBODY
, hp.ALTAHR_RESACT_08
, hp.ALTAHR_UOA_08
, hp.ALTAHR_UOA_SUFFIX_08 as p_ALTAHR_UOA_SUFFIX_08
, hp.ALTAHR_NATIONALITY
, hp.ALTAHR_NATIONALITY2
, hp.WCN_CANDIDATE_ID
, hp.DATE_NEXT_ANN_CHECK
, hp.MOBILE_TEL_NO
, hp.ALTAHR_COUNTRY_OF_BIRTH
, hp.ALTAHR_HESA_GENDERID
, hp.ALTAHR_HESA_SEXORT
, hp.USS_RECIPIENT

FROM
MAC4.HES_UPAY_ASSOCIATE_STAFF@hr_link uas,  mac4.hes_people@hr_link hp
WHERE
uas.person_code = hp.person_code
and
nvl(uas.end_date, '31-Dec-2199') >= sysdate
and
nvl(uas.IGNORE, 'N') <> 'Y'
order by hp.person_code;

--
--  Describe the JC_ASSOCIATES view
--
DESCRIBE JC_ASSOCIATES;

--
--  Now get count of Associates
--
SELECT COUNT(*) FROM JC_ASSOCIATES;
