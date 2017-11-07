USE [WorkLink]
GO
/****** Object:  StoredProcedure [dbo].[USP_CREATE_WORKLINKDATA]    Script Date: 25/10/2017 14:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE IF EXISTS [dbo].[USP_CREATE_WORKLINKDATA];
GO
-- =============================================
-- Author:           <Author,,Name>
-- Create date: <Create Date,,>
-- Description:      <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_CREATE_WORKLINKDATA]

AS
BEGIN
       IF OBJECT_ID('dbo.WORKLINKDATA','U') is not null
       drop table dbo.WORKLINKDATA


       select candidateid,firstname,surname,dateofbirth,address1,address2,address3,town,county,
		   replace(upper(postcode),' ','') postcode, telephone, email,
           replace(upper(ninumber),' ','') nino,
                 modificationdate Candidate_ModDate,
(select numericanswer from answers where questionid='60' and candidateid=recordid) as studentid,
(select modificationdate from answers where questionid='60' and candidateid=recordid) as studentidmoddate,
(select dateanswer from answers where questionid='68' and candidateid=recordid) as studentexpirydate,
(select modificationdate from answers where questionid='68' and candidateid=recordid) as studentidexpirymoddate,
(select g.description from dbo.genders g where g.genderid=c.gender) as gender,
(select t.description from dbo.titles t where t.TitleID=c.Title) as title,
(select e.description from dbo.EthnicOrigins e where e.EthnicOriginID=c.EthnicOrigin) as ethnicorigin,
(select n.description from dbo.Countries n where n.CountryID=c.CountryID) as country

into [dbo].[WORKLINKDATA]
from candidates c

END
