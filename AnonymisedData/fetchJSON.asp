<<<<<<< HEAD
<%@language="VBScript"%>
<%
Response.AddHeader "Access-Control-Allow-Origin", "*"
%>
<!--#include file="JSON_2.0.4.asp" -->
<!--#include file="JSON_UTIL_0.1.1.asp" -->
<%
' This page sends back JSON data to a requesting agent
' From and identified DB query
' Dimension variables
Dim adoCon         'Holds the Database Connection Object
Dim rsDB		   'Holds the recordset for the records in the database
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

debugging = False  'Default production provision

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

'Retrieve the datSource name from the Application object
dataSource = Application("testdata")

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

'Create an ADO connection object
Set adoCon = Server.CreateObject("ADODB.Connection")
'Set an active connection to the Connection object using DSN connection
adoCon.Open dataSource
'Create an ADO recordset object
Set rsDB = Server.CreateObject("ADODB.Recordset")

If queryref > -1 Then

	'Initialise querylist with queries
	querylist(0) = "SELECT count(*) FROM AnonPersonFeed"
	querylist(1) = "SELECT * FROM AnonPersonFeed"

' METADATA|Worker|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonNumber|StartDate|DateOfBirth|ActionCode

	querylist(2) = "SELECT 'MERGE' as METADATA, 'Worker' as Worker, 'ALTAHRN01' as SourceSystemOwner, ([Person Code]+5500000) as SourceSystemId, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, ([Person Code]+5500000) as PersonNumber, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as StartDate, Format(DOB,'YYYY/MM/DD') as DateOfBirth, 'HIRE' as ActionCode FROM AnonPersonFeed"

' METADATA|PersonLegislativeData|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|LegislationCode|Sex|MaritalStatus
' MERGE|PersonLegislativeData|ALTAHRN01|50000500_LEGISLATIVE|2016/07/04|4712/12/31|50000500|GB|M|M

'	querylist(3) = "SELECT 'MERGE' as METADATA, 'PersonLegislativeData' as PersonLegislativeData, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]+5500000) + '_LEGISLATIVE') AS SourceSystemId, 'GB' as LegislationCode, Gender as Sex, 'M' as MaritalStatus FROM AnonPersonFeed"
querylist(3) = "SELECT 'MERGE' as METADATA FROM AnonPersonFeed"

Else

	strSQL = thequery
	origSQL = strSQL

End If

If debugging Then
	Response.Write("p1 = [" & p1 & "]<br />")
	Response.Write("p2 = [" & p2 & "]<br />")
	Response.Write("p3 = [" & p3 & "]<br />")
	Response.Write("testing = [" & testing & "]<br />")
	Response.Write("origSQL = [" & origSQL & "]<br />")
	Response.Write("strSQL = [" & strSQL & "]<br />")
	Response.End
End If

dataResults = QueryToJSON(adoCon, strSQL).Flush

Response.ContentType = "application/json"

Response.Write(dataResults)
Response.End
%>
=======
<%@language="VBScript"%>
<%
Response.AddHeader "Access-Control-Allow-Origin", "*"
%>
<!--#include file="JSON_2.0.4.asp" -->
<!--#include file="JSON_UTIL_0.1.1.asp" -->
<%
' This page sends back JSON data to a requesting agent
' From and identified DB query
' Dimension variables
Dim adoCon         'Holds the Database Connection Object
Dim rsDB		   'Holds the recordset for the records in the database
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

debugging = False  'Default production provision

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

'Retrieve the datSource name from the Application object
dataSource = Application("testdata")

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

'Create an ADO connection object
Set adoCon = Server.CreateObject("ADODB.Connection")
'Set an active connection to the Connection object using DSN connection
adoCon.Open dataSource
'Create an ADO recordset object
Set rsDB = Server.CreateObject("ADODB.Recordset")

If queryref > -1 Then

	'Initialise querylist with queries
	querylist(0) = "SELECT count(*) FROM AnonPersonFeed"
	querylist(1) = "SELECT * FROM AnonPersonFeed"

' METADATA|Worker|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonNumber|StartDate|DateOfBirth|ActionCode

	querylist(2) = "SELECT 'MERGE' as METADATA, 'Worker' as Worker, 'ALTAHRN01' as SourceSystemOwner, ([Person Code]+5500000) as SourceSystemId, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as EffectiveStartDate, '4712/12/31' as EffectiveEndDate, ([Person Code]+5500000) as PersonNumber, Format([PeriodofServiceStartDate], 'YYYY/MM/DD') as StartDate, Format(DOB,'YYYY/MM/DD') as DateOfBirth, 'HIRE' as ActionCode FROM AnonPersonFeed"

' METADATA|PersonLegislativeData|SourceSystemOwner|SourceSystemId|EffectiveStartDate|EffectiveEndDate|PersonId(SourceSystemId)|LegislationCode|Sex|MaritalStatus
' MERGE|PersonLegislativeData|ALTAHRN01|50000500_LEGISLATIVE|2016/07/04|4712/12/31|50000500|GB|M|M

'	querylist(3) = "SELECT 'MERGE' as METADATA, 'PersonLegislativeData' as PersonLegislativeData, 'ALTAHRN01' as SourceSystemOwner,  (CStr([Person Code]+5500000) + '_LEGISLATIVE') AS SourceSystemId, 'GB' as LegislationCode, Gender as Sex, 'M' as MaritalStatus FROM AnonPersonFeed"
querylist(3) = "SELECT 'MERGE' as METADATA FROM AnonPersonFeed"

Else

	strSQL = thequery
	origSQL = strSQL

End If

If debugging Then
	Response.Write("p1 = [" & p1 & "]<br />")
	Response.Write("p2 = [" & p2 & "]<br />")
	Response.Write("p3 = [" & p3 & "]<br />")
	Response.Write("testing = [" & testing & "]<br />")
	Response.Write("origSQL = [" & origSQL & "]<br />")
	Response.Write("strSQL = [" & strSQL & "]<br />")
	Response.End
End If

dataResults = QueryToJSON(adoCon, strSQL).Flush

Response.ContentType = "application/json"

Response.Write(dataResults)
Response.End
%>
>>>>>>> 0104ec4e7ab52d8fdbcea8b9efc1d52c7c9d89f8
