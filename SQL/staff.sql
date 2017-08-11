CREATE OR REPLACE VIEW jc_staff AS SELECT hp.person_code,
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
   FROM hes_periods_of_service@hr_link pos,
        hes_people@hr_link hp,
        hes_appointments@hr_link ha,
        hes_app_grade_histories@hr_link agh,
       hes_grades@hr_link hg ,
        --MAC4.HES_ORG_UNITS_LEV_STRUCT levstruct ,
        /*hes_organisation_units sch,
        hes_organisation_units col,*/
        hes_organisation_units@hr_link dep,
        HES_CONTROL_CONTEXTS@hr_link cc
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
        from hes_appointments@hr_link app1
        where app1.start_date <= sysdate
                and   nvl(app1.primary_appointment, 'N') = 'Y'
        and   app1.pes_period_of_ser_code = HA.pes_period_of_ser_code)
    AND

     NVL (pos.end_date, TO_DATE ('31-DEC-2199')) >= TO_DATE('01-aug-2016')
    AND nvl(ha.primary_appointment,'Y') = 'Y'
    AND ha.appointee_type in ('STAFF','STAFF_MEMBER')
    AND agh.app_appointment_code(+)  = ha.appointment_code
    AND agh.effective_start_date = (SELECT max(agh3.effective_start_date)
                                      FROM hes_app_grade_histories@hr_link agh3
                                     WHERE agh3.app_appointment_code = ha.appointment_code
                                       AND agh3.effective_start_date <=  sysdate)
    AND agh.implementation_start_date =(SELECT max(agh2.implementation_start_date)
                                         FROM hes_app_grade_histories@hr_link agh2
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

--
-- Describe the jc_staff view
--
DESCRIBE jc_staff;

--
-- How many people in this
--
SELECT COUNT(*) FROM jc_staff;
select appointee_type, control_context_id, count(*) as kount from jc_staff group by appointee_type, control_context_id order by 1;

-- APPOINTEE_TYPE                                KOUNT
---------------------------------------- ----------
-- CASUAL                                       296684
-- STAFF_MEMBER                                  51189
-- HONORARY                                      14210
-- PENSIONER                                      1448
-- STAFF                                           129
-- SENIOR_APPOINTMENT                               34
-- UEB_MEMBER                                       30
-- CONTRACTOR                                        3
