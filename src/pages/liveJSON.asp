<%@language="VBScript"%>
<!--#include file="JSON_2.0.4.asp" -->
<!--#include file="JSON_UTIL_0.1.1.asp" -->
<%
' This page tests connection and query against the ALTAHRN data source
' from an identified database query
' Dimension variables
Dim adoCon         'Holds the Database Connection Object
Dim rsDB		   		 'Holds the recordset for the records in the database
Dim strSQL         'Holds the SQL query to query the database
Dim dataSource	   'Holds the name of the data source from the Application object
Dim dataResults    'Holds results from the JSON query
Dim querylist(60)  'Array of queries
Dim queryref       'Reference to query in querylist (default to 1)
Dim p1, p2, p3     'Parameters (text)
Dim paramknt       'Count of the number of parameters
Dim debugging      'Are we running in debug mode
Dim debug          'Placeholder for if we are to display debug info
Dim origSQL        'Holds a copy of the original SQL from the querylist
Dim testing        'Is the real or test database to be used (Y=test)

p1 = ""
p2 = ""
p3 = ""
paramknt = 0
testing = "N"

'Now retrieve query details from submitting form or querystring
'and initialise the strSQL variable with an SQL statement to query the database
queryref = Request.Form("id")
If queryref = "" Then
	queryref = Request.QueryString("id")
	If queryref = "" Then
		queryref = -1
	End If
End If

' Optionally consider dealing with fill-in fields for the identified query
If queryref > -1 Then

	p1 = Request.Form("p1")
	If p1 = "" Then
		p1 = Request.QueryString("p1")
		If p1 <> "" Then
			paramknt = paramknt + 1
		End If
	End If

	p2 = Request.Form("p2")
	If p2 = "" Then
		p2 = Request.QueryString("p2")
		If p2 <> "" Then
			paramknt = paramknt + 2
		End If
	End If

	p3 = Request.Form("p3")
	If p3 = "" Then
		p3 = Request.QueryString("p3")
		If p3 <> "" Then
			paramknt = paramknt + 4
		End If
	End If

Else

 	'No query Id so use the supplied query
	thequery = Request.Form("thequery")
	If thequery = "" Then
		thequery = Request.QueryString("thequery")
		If thequery = "" Then
			thequery = "SELECT ""There are no results"" FROM coaches"
		End If
	End If

End If

On Error Resume Next
'Retrieve the datSource name from the Application object in Global.asa
dataSource = Application("ALTAHRN")
If Err.Number <> 0 Then
  Response.Write "Error in setting dataSource: " & Err.Description
  Err.Clear
End If

debug = Request.Form("debug")
If debug = "" Then
	debug = Request.QueryString("debug")
	If debug = "Y" Then
		debugging = True
	End If
Else
	If debug = "Y" Then
		debugging = True
	End If
End If

If queryref > -1 Then

	'Initialise querylist with queries
	querylist(0) = "SELECT count(*) AS kount FROM MAC4.HES_PEOPLE"
	querylist(1) = "SELECT * FROM CountryCodes WHERE HESACode = 'ZZ'"

	querylist(2) = "SELECT 'MERGE' as METADATA, 'Worker' as Worker, 'ALTAHRN01' as SourceSystemOwner, [Person Code] as SourceSystemId, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, [Person Code] as PersonNumber, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as StartDate, Format(DOB,'YYYY/MM/DD') as DateOfBirth, 'HIRE' as ActionCode FROM AnonPersonFeed"

	' METADATA|PersonLegislativeData|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|LegislationCode|Sex|MaritalStatus
	' MERGE|PersonLegislativeData|ALTAHRN01|50000500_LEGISLATIVE|2016/07/04|4712/12/31|50000500|GB|M|M

	querylist(3) = "SELECT 'MERGE' as METADATA, 'PersonLegislativeData' as PersonLegislativeData, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]) + '_LEGISLATIVE') AS SourceSystemId, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, [Person Code] AS ZZPersonId, 'GB' as LegislationCode, Gender as Sex, 'M' as MaritalStatus FROM AnonPersonFeed"

' METADATA|PersonName|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|NameType|LegislationCode|Title|LastName|FirstName|MiddleNames
' MERGE|PersonName|ALTAHRN01|50000500_GLOBAL|2016/07/04|4712/12/31|50000500|GLOBAL|GB|MR.|Cable|John|

	querylist(4) = "SELECT 'MERGE' as METADATA, 'PersonName' as PersonName, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]) + '_GLOBAL_NAME') AS SourceSystemId, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, [Person Code] AS ZZPersonId, 'GLOBAL' as NameType, 'GB' as LegislationCode, [FusionTitle] as Title, [AnonymisedSurname] as LastName, [AnonymisedForename] as FirstName, [MiddleName] as MiddleNames FROM AnonPersonFeed"

'	METADATA|WorkRelationship|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|LegalEmployerName|DateStart|WorkerType|PrimaryFlag
'	MERGE|WorkRelationship|ALTAHRN01|50000500_POS|50000500|The University of Birmingham|2016/07/04|E|Y

	querylist(5) = "SELECT 'MERGE' as METADATA, 'WorkRelationship' as WorkRelationship, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]) + '_WORK_REL') AS SourceSystemId, [Person Code] AS ZZPersonId,'The University of Birmingham' as LegalEmployerName, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as DateStart, 'E' as WorkerType, 'Y' as PrimaryFlag FROM AnonPersonFeed"

'	METADATA|WorkTerms|SourceSystemOwner|SourceSystemId|PeriodOfServiceId(SourceSystemId)|ActionCode|EffectiveStartDate|EffectiveEndDate|EffectiveSequence|EffectiveLatestChange|AssignmentName|AssignmentNumber|PrimaryWorkTermsFlag
'	MERGE|WorkTerms|ALTAHRN01|50000500_EMP_TERM|50000500_POS|HIRE|2016/07/04|4712/12/31|1|Y|ET50000500|50000500_WT|Y

querylist(6) = "SELECT 'MERGE' as METADATA, 'WorkTerms' as WorkTerms, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]) + '_EMP_TERM') AS SourceSystemId, (CStr([Person Code]) + '_POS') AS ZZPeriodOfServiceId, 'HIRE' as ActionCode, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, '1' as EffectiveSequence, 'Y' as EffectiveLatestChange, ('ET' + CStr([Person Code])) AS AssignmentName, (CStr([Person Code]) + '_WT') AS AssignmentNumber, 'Y' as PrimaryWorkTermsFlag FROM AnonPersonFeed"

' METADATA|PersonPhone|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|DateFrom|DateTo|PhoneType|PhoneNumber|AreaCode|PrimaryFlag
' MERGE|PersonPhone|ALTAHRN01|50000500_PER_PHONE|50000500|2016/07/04|4712/12/31|W1|414 6951|0121|Y

querylist(7) = "SELECT 'MERGE' as METADATA, 'PersonPhone' as PersonPhone, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]) + '_PER_PHONE') AS SourceSystemId, [Person Code] AS ZZPersonId, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as DateFrom, '4712/12/31' as DateTo, 'W1' as PhoneType, [HomeTelephone] as PhoneNumber, 'Y' as PrimaryFlag FROM AnonPersonFeed"

' METADATA|PersonEmail|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|EmailType|EmailAddress|DateFrom|PrimaryFlag
' MERGE|PersonEmail|ALTAHRN01|50000500_PER_EMAIL|50000500|W1|J.Cable@yopmail.com|2016/07/04|Y

querylist(8) = "SELECT 'MERGE' as METADATA, 'PersonEmail' as PersonEmail, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]) + '_PER_EMAIL') AS SourceSystemId, [Person Code] AS ZZPersonId, 'W1' as EmailType, LCase([AnonymisedWorkEmail]) as EmailAddress, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as DateFrom, 'Y' as PrimaryFlag FROM AnonPersonFeed"

' METADATA|PersonAddress|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|AddressType|PersonId(SourceSystemId)|AddressLine1|AddressLine2|TownOrCity|Region1|Country|PostalCode|LongPostalCode|TimezoneCode|PrimaryFlag
' MERGE|PersonAddress|ALTAHRN01|50000500_PER_ADDRESS|2016/07/04|4712/12/31|HOME|50000500|124 Old Station Road|Hampton-in-Arden|Solihull|West Midlands|GB|B92 0HF|B92 0HF|GMT|Y

querylist(9) = "SELECT 'MERGE' as METADATA, 'PersonAddress' as PersonAddress, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]) + '_PER_ADDRESS') AS SourceSystemId, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, 'HOME' as AddressType,  [Person Code] AS ZZPersonId, [AddressLine1], [AddressLine2], [Town] as TownOrCity, [Region] as Region1,  'GB' as Country, [Postcode] as PostalCode, [Postcode] as LongPostalCode, 'Y' as PrimaryFlag FROM AnonPersonFeed"

' METADATA|Assignment|SourceSystemOwner|SourceSystemId|ActionCode|EffectiveStartDate|EffectiveEndDate|EffectiveSequence|EffectiveLatestChange|WorkTermsAssignmentId(SourceSystemId)|AssignmentName|AssignmentNumber|AssignmentStatusTypeCode|PersonTypeCode|BusinessUnitShortCode|LocationCode|JobCode|PrimaryAssignmentFlag
' MERGE|Assignment|ALTAHRN01|50000500_EMP_ASG|HIRE|2016/07/04|4712/12/31|1|Y|50000500_EMP_TERM|50000500|50000500|ACTIVE_PROCESS|Employee|UOB Business Unit|University of Birmingham|SUB_MAT_EXP_SP|Y

querylist(10) = "SELECT 'MERGE' as METADATA, 'Assignment' as Assignment, 'ALTAHRN01' as SourceSystemOwner,  CStr([Person Code]) + '_EMP_ASG' AS SourceSystemId, 'HIRE' as ActionCode, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, '1' as EffectiveSequence, 'Y' as EffectiveLatestChange, (CStr([Person Code]) + '_EMP_TERM') as ZZWorkTermsAssignmentId, [Person Code] as AssignmentName, [Person Code] as AssignmentNumber, 'ACTIVE_PROCESS' as AssignmentStatusTypeCode, 'Employee' as PersonTypeCode, 'UOB Business Unit' as BusinessUnitShortCode, 'University of Birmingham' as LocationCode, 'SUB_MAT_EXP_SP' as JobCode, 'Y' as PrimaryAssignmentFlag FROM AnonPersonFeed"

' METADATA|Position|SourceSystemOwner|SourceSystemId|EffectiveStartDate|PositionCode|BusinessUnitName|Name|ActiveStatus|DepartmentId|JobId|LocationId|FullPartTime|RegularTemporary|HiringStatus|PositionType|FTE|HeadCount|WorkingHours|Frequency
' MERGE|Position|ALTAHRN01|131910|1951/01/01|131910|UOB Business Unit|Personal Assistant|A|300000009529910|300000009529240|300000004663603|FULL_TIME|R|APPROVED|SINGLE|1|1|36|W

querylist(11) = "SELECT 'MERGE' as METADATA, 'Position' as Position, 'ALTAHRN01' as SourceSystemOwner,  [PositionCode] AS SourceSystemId,  Format([EffectiveStartDate], 'YYYY/MM/DD') as ZZEffectiveStartDate, [PositionCode], [BusinessUnitName], [Name], 'A' as ActiveStatus, [DepartmentId], [JobId] , [LocationId], 'FULL_TIME' as FullPartTime, 'R' as RegularTemporary, 'APPROVED' as HiringStatus, 'SINGLE' as PositionType, '1' as FTE, '1' as HeadCount, [WorkingHours], 'W' as Frequency FROM SamplePositions"

'  METADATA|PersonEthnicity|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|LegislationCode|Ethnicity|PrimaryFlag
'  MERGE|PersonEthnicity|ALTAHRN01|50000500_ETHNICITY|50000500|GB|1|Y

querylist(12) = "SELECT 'MERGE' as METADATA, 'PersonEthnicity' as PersonEthnicity, 'ALTAHRN01' as SourceSystemOwner, CStr([Person Code])+'_ETHNICITY' as SourceSystemId, [Person Code] as ZZPersonId, 'GB' as LegislationCode, [FusionEthnicityCode] as Ethnicity, 'Y' as PrimaryFlag FROM AnonPersonFeed"

' METADATA|Assignment|SourceSystemOwner|SourceSystemId|ActionCode|EffectiveStartDate|EffectiveEndDate|EffectiveSequence|EffectiveLatestChange|WorkTermsAssignmentId(SourceSystemId)|AssignmentName|AssignmentNumber|AssignmentStatusTypeCode|PersonTypeCode|PositionId|BusinessUnitShortCode|LocationCode|JobCode|PrimaryAssignmentFlag
' MERGE|Assignment|ALTAHRN01|50000500_EMP_ASG|HIRE|2016/07/04|4712/12/31|1|Y|50000500_EMP_TERM|50000500|50000500|ACTIVE_PROCESS|Employee|131910|UOB Business Unit|University of Birmingham|SUB_MAT_EXP_SP|Y

querylist(13) = "SELECT 'MERGE' as METADATA, 'Assignment' as Assignment, 'ALTAHRN01' as SourceSystemOwner,  CStr([Person Code]) + '_EMP_ASG' AS SourceSystemId, 'HIRE' as ActionCode, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, '1' as EffectiveSequence, 'Y' as EffectiveLatestChange, (CStr([Person Code]) + '_EMP_TERM') as ZZWorkTermsAssignmentId, [Person Code] as AssignmentName, [Person Code] as AssignmentNumber, 'ACTIVE_PROCESS' as AssignmentStatusTypeCode, 'Employee' as PersonTypeCode, [FusionPositionId] as PositionId, 'UOB Business Unit' as BusinessUnitShortCode, 'University of Birmingham' as LocationCode, 'SUB_MAT_EXP_SP' as JobCode, 'Y' as PrimaryAssignmentFlag FROM AnonPersonFeed WHERE [FusionPositionId] is not null"

' METADATA|PersonDisability|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|Category|Description|DisabilityCode|LegislationCode|Status
' N.B.  Try with out specing a DisabilityCode (below)
' MERGE|PersonDisability|ALTAHRN01|50000500_DIS_97|2016/07/04|4712/12/31|50000500|97|Information Refused|97|GB|TEMPORARY

querylist(14) = "SELECT 'MERGE' as METADATA, 'PersonDisability' as PersonDisability, 'ALTAHRN01' as SourceSystemOwner,  per_person_code||'_DIS_'||disability_type AS SourceSystemId, to_char(start_date,'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, per_person_code AS ZZPersonId, disability_type as Category, 'GB' as LegislationCode, 'A' as Status FROM hes_disabilities"

' COMMENT METADATA|PersonReligion|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|LegislationCode|Religion|PrimaryFlag
' COMMENT MERGE|PersonReligion|ALTAHRN01|50000500_RELIGION|50000500|GB|01|Y

querylist(15) = "SELECT 'MERGE' as METADATA, 'PersonReligion' as PersonReligion, 'ALTAHRN01' as SourceSystemOwner,  CStr([Person Code]) + '_RELBLF' AS SourceSystemId, [Person Code] AS ZZPersonId, 'GB' as LegislationCode, [FusionReligiousBelief] as Religion, 'Y' as PrimaryFlag  FROM AnonPersonFeed"

' COMMENT METADATA|PersonNationalIdentifier|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|LegislationCode|NationalIdentifierType|NationalIdentifierNumber|PrimaryFlag
' COMMENT MERGE|PersonNationalIdentifier|ALTAHRN01|50000500_NI|50000500|GB|NINO|YZ232849A|Y

querylist(16) = "SELECT 'MERGE' as METADATA, 'PersonNationalIdentifier' as PersonNationalIdentifier, 'ALTAHRN01' as SourceSystemOwner,  CStr([Person Code]) + '_NI' AS SourceSystemId, [Person Code] AS ZZPersonId, 'GB' as LegislationCode, 'NINO' as NationalIdentifierType, [NINumber] as NationalIdentifierNumber,'Y' as PrimaryFlag  FROM AnonPersonFeed"

' COMMENT METADATA|PersonCitizenship|SourceSystemOwner|SourceSystemId|PersonId(SourceSystemId)|DateFrom|DateTo|LegislationCode|CitizenshipStatus
' COMMENT MERGE|PersonCitizenship|ALTAHRN01|50000500_CITIZEN|50000500|1956/04/29|4712/12/31|GB|A

querylist(17) = "SELECT 'MERGE' as METADATA, 'PersonCitizenship' as PersonCitizenship, 'ALTAHRN01' as SourceSystemOwner,  CStr([Person Code]) + '_CITIZEN' AS SourceSystemId, [Person Code] AS ZZPersonId, Format(DOB,'YYYY/MM/DD') as DateFrom, '4712/12/31' as DateTo, 'GB' as LegislationCode, 'A' as CitizenshipStatus  FROM AnonPersonFeed"





' METADATA|PersonDisability|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|Category|DisabilityCode|LegislationCode|Status
' N.B.  Try with out specing a DisabilityCode (below)
' MERGE|PersonDisability|ALTAHRN01|50000500_DIS_97|2016/07/04|4712/12/31|50000500|97|Information Refused|97|GB|TEMPORARY

querylist(50) = "SELECT 'MERGE' as METADATA, 'PersonDisability' as PersonDisability, 'ALTAHRN01' as SourceSystemOwner,  h.person_code||'_DIS_00' AS SourceSystemId, '1951/01/01' as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, h.person_code AS ZZPersonId, '00' as Category, 'GB' as LegislationCode, 'A' as Status FROM hes_people h WHERE h.person_code NOT IN (SELECT Distinct(per_person_code) FROM hes_disabilities)"


	strSQL = querylist(queryref)
	origSQL = strSQL

	'Now, replace any fill-in fields with their params

	If (paramknt > 0)  Then
		strSQL = replace(strSQL, "{{p1}}", p1)
	End If

	If (paramknt > 1)  Then
		strSQL = replace(strSQL, "{{p2}}", p2)
	End If

	If (paramknt > 2)  Then
		strSQL = replace(strSQL, "{{p3}}", p3)
	End If

	'Now for any predecided substitutions

Else

	strSQL = thequery
	origSQL = strSQL

End If

If debugging Then
	Response.Write "dataSource = " & dataSource & "<br />"
	Response.Write "strSQL = [" & strSQL & "]<br />"
End If

'Create an ADO connection object
Set adoCon = Server.CreateObject("ADODB.Connection")
If Err.Number <> 0 Then
  Response.Write "Error in setting up adoCon: " & Err.Description
  Err.Clear
End If

'Set an active connection to the Connection object using DSN connection

adoCon.Open dataSource
If Err.Number <> 0 Then
  Response.Write "Error in opening dataSource via adoCon: " & Err.Description
  Err.Clear
End If

'Create an ADO recordset object
Set rsDB = Server.CreateObject("ADODB.Recordset")
If Err.Number <> 0 Then
  Response.Write "Error in seting up Recordset: " & Err.Description
  Err.Clear
End If

dataResults = QueryToJSON(adoCon, strSQL).Flush
If Err.Number <> 0 Then
  Response.Write "Error in running QueryToJSON: " & Err.Description
  Err.Clear
End If

If debugging Then
	Response.Write "Just after where the call to QueryToJSON would have happened<br />"
Else
  Response.ContentType = "application/json"

  Response.Write(dataResults)
End If

Response.End
%>
