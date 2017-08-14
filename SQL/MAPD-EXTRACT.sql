@e:\inetpub\wwwroot\UoB\honoraries.sql
@e:\inetpub\wwwroot\UoB\casuals.sql
@e:\inetpub\wwwroot\UoB\contractors.sql
@e:\inetpub\wwwroot\UoB\honoraries.sql
@e:\inetpub\wwwroot\UoB\pensioners.sql
@e:\inetpub\wwwroot\UoB\seniorappointments.sql
@e:\inetpub\wwwroot\UoB\staff.sql
@e:\inetpub\wwwroot\UoB\uebmembers.sql
--  Associates uses a different base SQL to the above
@e:\inetpub\wwwroot\UoB\associates.sql

desc jc_staff
describe hes_disabilities@hr_link




select count(*) from upay_next_of_kin@hr_link upnok
where
upnok.person_code in
(select distinct(person_code) from jc_uebmembers);


select count(*) from upay_next_of_kin@hr_link where (end_date is not null AND end_date > to_date('24/07/2017','DD/MM/YYYY')) OR end_date is null;

@GenerateContact.sql
@GenerateContactName.sql
@GenerateContactPhone.sql
@GenerateContactRelationship.sql
@GenerateContactEmail.sql
@GenerateContactAddress.sql
@GenerateAllContacts.sql

select generatecontact() from dual;
select GenerateContactName() from dual;
select generatecontactphone() from dual;
select GenerateContactRelationship() from dual;
select count(*) as kount from upay_next_of_kin@hr_link where end_date is not null and end_date != to_date('31/12/2199','DD/MM/YYYY');

set serveroutput on

desc upay_next_of_kin@hr_link

@LoadTitleCodes.sql
select * from TitleCodes
@FusionTitle.sql

set pagesize 5000
select '<'||nvl(trim(title),'NONE')||'> - <'||getFusionTitle(nvl(trim(title),'NONE'))||'>' from upay_next_of_kin@hr_link;
