create or replace view jc_whole_cohort as 
select person_code, 'ASSOCIATES' as viewtitle from jc_associates group by person_code
union
select person_code, 'CASUALS' as viewtitle from jc_casuals group by person_code
union
select person_code, 'CONTRACTORS' as viewtitle from jc_contractors group by person_code
union
select person_code, 'HONORARIES' as viewtitle  from jc_honoraries group by person_code
union
select person_code, 'PENSIONERS' as viewtitle  from jc_pensioners group by person_code
union
select person_code, 'SENIOR APPOINTMENTS' as viewtitle from jc_seniorappointments group by person_code
union
select person_code, 'STAFF' as viewtitle from jc_staff group by person_code
union
select person_code, 'UEB MEMBERS' as viewtitle  from jc_ueb_members group by person_code;

select count(*) from jc_st;
select viewtitle, count(*) from jc_whole_cohort group by viewtitle;
