desc hes_people
select religious_affiliation, count(*) from hes_people group by religious_affiliation;
describe hes_disabilities
select disability_type, count(*) as kount from hes_disabilities group by disability_type order by disability_type;

/*
Contacts
*/
set serveroutput on
desc upay_next_of_kin
select count(*) from upay_next_of_kin where relationship is null
select * from upay_next_of_kin where rownum < 10;
select count(*) from upay_next_of_kin where address_line_1 is not null;
select relationship, count(*) as kount from upay_next_of_kin group by relationship order by 2 desc
select count(*) as kount from upay_next_of_kin where end_date is not null and end_date != to_date('31/12/2199','DD/MM/YYYY');


desc upay_staff_extract;
select count(*) as kount from hes_people;

desc all_objects
select * from all_objects where object_name like '%EMAIL%';

select mac4.chk_email_valid('joncable@talk21.com') from mac4.hes_people;
desc user_source
select * from user_source where name = 'CHK_EMAIL_VALID';

desc hes_addresses
select count(*) from hes_addresses
set serveroutput on
dbms_output.put_line('jgvdfjagvb')
select count(*) from upay_staff_extract
desc upay_staff_extract

select forename, surname, start_date, leaving_date, expected_end_date from upay_staff_extract where surname = 'Tiwana'

select table_name from all_tables where table_name like '%ESA%';

select distinct(owner) from all_objects where object_type = 'TABLE';
desc all_objects

CREATE OR REPLACE DIRECTORY migration_files_dir AS '/u25/migration-files';
GRANT READ, WRITE ON DIRECTORY migration_files_dir TO SIDILECL_RW,CABLEJ_RW,BRADBUDJ_RW;

desc all_directories;
select * from all_directories;

DECLARE
  fileHandler UTL_FILE.FILE_TYPE;
BEGIN
  fileHandler := UTL_FILE.FOPEN('MIGRATION_FILES_DIR', 'test_file.txt', 'W');
  UTL_FILE.PUTF(fileHandler, 'Writing TO a file\n');
  UTL_FILE.FCLOSE(fileHandler);
EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;

SELECT * FROM TABLE(uob_file_api.file_contents('MIGRATION_FILES_DIR', 'test_file.txt'));
desc upay_staff_extract;


Declare
file1 utl_file.file_type;
Begin
file1:= utl_file.fopen('MIGRATION_FILES_DIR','sample.txt','w');
utl_file.put_line(file1,'Welcome' );
utl_file.fclose(file1);
end;
/
SELECT * FROM TABLE(uob_file_api.file_contents('MIGRATION_FILES_DIR', 'sample.txt'));

Select ethnic_origin, count(*) as kount from hes_people group by ethnic_origin;

select title, count(*) as kount from hes_people group by title order by title;

select object_name, object_type from all_objects where object_name like 'HES_DIS%'
desc hes_people
desc HES_DISABILITIES
select per_person_code, count(*) as kount from hes_disabilities group by per_person_code having count(*) > 1 order by 2 desc
select disability_type||','||count(*) as kount from hes_disabilities group by disability_type order by 1 asc
select count(distinct(per_person_code)) from hes_disabilities
select * from MAC4.HESA_NISR_DISABLE1;
desc all_tables
select owner, object_name from all_objects where object_name like '%VALUES%'
desc hes_ref_values
select distinct(rv_domain) from hes_ref_values order by rv_domain;
select low_value, meaning from hes_ref_values where rv_domain = 'RELIGIOUS_AFFILIATION' order by low_value asc;

select ethnic_origin, count(*) as kount from hes_people group by ethnic_origin order by ethnic_origin;

select religious_affiliation, count(*) as kount from hes_people group by religious_affiliation order by religious_affiliation
desc hes_people
set header off
set pagesize 500
select 'INSERT INTO COUNTRYCODES2(HESACODE) VALUES('||''''||altahr_nationality||''''||');' from hes_people group by altahr_nationality order by altahr_nationality;
select low_value, meaning from hes_ref_values where rv_domain like 'HESA_NISR_NATION' and low_value in ('IO','RS','ME');
desc hes_nationality
select person_code, preference, count(*) as kount from upay_next_of_kin group by person_code, preference having count(*) > 1;
select distinct(relationship) from upay_next_of_kin;

desc hes_disabilities

SELECT distinct(hp.person_code)

hp.title,
hp.forename||' '||hp.middle_names||' '|| hp.surname AS Person_Name,
hp.forename,
hp.surname,
hp.altahr_username,
hp.altahr_email_address AS UoB_Work_Email,
hp.date_of_birth,
CASE
WHEN hp.date_of_birth IS NOT NULL THEN 1
ELSE
0 
  END AS DOB_CHECK,
  pos.period_of_ser_code,
pos.start_date AS POS_Start_Date,
case when pos.end_date = to_date ('31-Dec-2199') then NULL
else pos.end_date end AS POS_End_Date,
pos.leaving_date as pos_leaving_date,
pos.DATE_NOTIFIED AS  pos_DATE_NOTIFIED ,
pos.LAST_WORKING_DAY AS pos_LAST_WORKING_DAY,
pos.DESTINATION AS pos_DESTINATION,
pos.POTENTIAL_LEAVER AS pos_POTENTIAL_LEAVER,
pos.PAL_FLAG AS pos_PAL_FLAG,
pos.HESA_LEDEST AS pos_HESA_LEDEST,
pos.HESA_LOCLEAVE AS pos_HESA_LOCLEAVE,
pos.HESA_ACTLEAVE AS pos_HESA_ACTLEAVE,
ha.appointment_code,
ha.pos_post_number  AS Post_Number,
  ha.job_title,
  ha.primary_appointment,
  ha.start_Date AS Appointment_Start_Date,
  case when ha.end_date = to_date ('31-Dec-2199') then  NULL
  ELSE ha.end_date end AS Appointment_End_Date,
    ha.FIXED_TERM AS Appointment_FixedTerm,
ha.EXPECTED_END_DATE,
ha.END_DATE_IMPLEMENTATION_DATE,
ha.AUTHORISER,
ha.AUTHORISATION_DATE,
ha.PROBATIONARY,
ha.PROBATION_LENGTH,
ha.PROBATION_LENGTH_UNITS,
ha.FIRST_PROB_REVIEW_DATE,
ha.HESA_EMPLOYMENT_IN_PREV_YEAR,
ha.HESA_DEST_ON_LEAVING,
ha.HESA_NHS_JOINT_APP,
ha.COMMENTS AS Appointment_Comments,
  ha.TOTAL_CONTRACTED_HOURS,
ha.DEFAULT_LEDGER_ACCOUNT,
ha.CONTRACTED_HOURS_PAID,
ha.SUPERNUMERARY,
ha.CONTRACT_REFERENCE,
ha.FUND_ORG,
ha.TYPE_OF_WORK,
ha.CONTRACT_ACCEPTED,
ha.JOB_SHARE,
ha.HEALTH_CHECK As Appointment_HEALTH_CHECK,
ha.POLICE_CHECK As Appointment_POLICE_CHECK ,
ha.POLICE_CHECK_DATE As Appointment_POLICE_CHECK_DATE,
ha.HESA_TCHWLH,
ha.HESA_NHSCON,
ha.HESA_NHSCONGR,
ha.HESA_HSPEC,
ha.HESA_HEIJOINT,
ha.HESA_CAMPUS,
ha.PASSED_PROBATION_DATE,
ha.HESA_CLINICAL,
ha.HESA_PROF,
  agh.hesa_acempfun,
ha.FUNDING_EXPECTED_END_DATE,
ha.VTE_FLAG,
ha.WCN_VACANCY_ID AS Appointment_WCN_VACANCY_ID ,
ha.HESA_RESCON,
ha.HESA_STARTCON,
   hg.psp_category ||' '||
                hg.psp_group ||' '||
                hg.grade_name AS Category_Group_Grade,
         /*col.full_name AS College,
        sch.full_name AS School,*/
        dep.full_name as Department,
       ha.appointee_type,
       pos.control_context_id,
       cc.CONTROL_CONTEXT_ID as cc_ctxt_id,
       Cc.Control_Context,
hp.PREVIOUS_SURNAME
, hp.SEX
, hp.COUNTRY_OF_BIRTH  
, hp.ETHNIC_ORIGIN
, hp.NATIONALITY
, hp.SECOND_NATIONALITY
, hp.KNOWN_AS
, hp.MARITAL_STATUS  
, hp.NI_NUMBER
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
, hp.USERNAME 
, hp.EMAIL_ADDRESS 
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
, hp.ALTAHR_PERSONAL_EMAIL_ADDRESS
, hp.ALTAHR_COUNTRY_OF_BIRTH  
, hp.ALTAHR_HESA_GENDERID 
, hp.ALTAHR_HESA_SEXORT 
, hp.USS_RECIPIENT 
   FROM hes_periods_of_service pos,
        hes_people hp,
        hes_appointments ha,
        hes_app_grade_histories agh,
       hes_grades hg ,
        --MAC4.HES_ORG_UNITS_LEV_STRUCT levstruct ,
        /*hes_organisation_units sch,
        hes_organisation_units col,*/
        hes_organisation_units dep,
        HES_CONTROL_CONTEXTS cc    
  WHERE pos.per_person_code = hp.person_code
    AND pos.start_date <= SYSDATE
    AND 
    
    NVL (pos.end_date, TO_DATE ('31-DEC-2199'))  >= TO_DATE('01-aug-2016')

    AND NVL (pos.pal_flag, 'N') = 'N'
   AND pos.control_context_id = cc.CONTROL_CONTEXT_ID
    AND pos.control_context_id IN (3,4,9, 18,19,20, 23)
    AND ha.pes_period_of_ser_code = pos.period_of_ser_code
    AND ha.start_date <= SYSDATE
      AND  HA.start_date =
        (select max(app1.start_date)
        from hes_appointments app1
        where app1.start_date <= sysdate
                and   nvl(app1.primary_appointment, 'N') = 'Y'
        and   app1.pes_period_of_ser_code = HA.pes_period_of_ser_code)
    AND

     NVL (pos.end_date, TO_DATE ('31-DEC-2199')) >= TO_DATE('01-aug-2016')
    AND nvl(ha.primary_appointment,'Y') = 'Y' 
    --AND ha.appointee_type not in ('CASUAL','HONORARY','PENSIONER')
    AND agh.app_appointment_code(+)  = ha.appointment_code 
    AND agh.effective_start_date = (SELECT max(agh3.effective_start_date)
                                      FROM hes_app_grade_histories agh3
                                     WHERE agh3.app_appointment_code = ha.appointment_code
                                       AND agh3.effective_start_date <=  sysdate)
    AND agh.implementation_start_date =(SELECT max(agh2.implementation_start_date)
                                         FROM hes_app_grade_histories agh2
                                        WHERE agh2.app_appointment_code = ha.appointment_code
                                          AND agh2.effective_start_date = agh.effective_start_date)
    AND hg.grade_code = agh.gra_grade_code
    AND hg.start_date <= sysdate
    AND hg.end_date >= sysdate/*
    --AND hg.psp_category IN ('A','S')
    AND levstruct.organisation_code = ha.org_organisation_code
    AND levstruct.college = col.organisation_code
    AND levstruct.school = sch.organisation_code
    AND levstruct.department = dep.organisation_code*/
    and  ha.org_organisation_code = dep.organisation_code;


SELECT 'MERGE' as METADATA, 'PersonDisability' as PersonDisability, 'ALTAHRN01' as SourceSystemOwner,  per_person_code||'_DIS_'||disability_type AS SourceSystemId, to_char(start_date,'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, per_person_code AS ZZPersonId, disability_type as Category, 'GB' as LegislationCode, 'A' as Status FROM hes_disabilities
desc hes_disabilities

desc hes_periods_of_service;

/*
Appointments
*/
desc hes_appointments
select appointee_type, count(*) as kount from hes_appointments group by appointee_type order by 2 asc;
select appointee_type, org_organisation_code, count(*) as kount from hes_appointments group by appointee_type, org_organisation_code order by 1 asc, 2 asc;


desc all_directories
select owner, directory_name from all_directories;

desc hes_control_contexts
select control_context, control_context_id, heading, organisation_code from hes_control_contexts order by heading asc;

desc PAYROLL.UPAY_NEXT_OF_KIN