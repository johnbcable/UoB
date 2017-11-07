USE [Worklink]
select 
'insert into studentidlookup(candidateid, studentid) values('+CONVERT(varchar(20), candidateid)+','+CONVERT(varchar(20), studentid)+');' 
from
dbo.WORKLINKDATA;