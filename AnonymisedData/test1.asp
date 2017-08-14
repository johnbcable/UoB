<<<<<<< HEAD
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

' strSQL = "SELECT count(*) AS kount FROM MAC4.HES_PEOPLE"
If queryref > -1 Then

	'Initialise querylist with queries
	querylist(0) = "SELECT count(*) FROM MAC4.HES_PEOPLE"


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
=======
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

' strSQL = "SELECT count(*) AS kount FROM MAC4.HES_PEOPLE"
If queryref > -1 Then

	'Initialise querylist with queries
	querylist(0) = "SELECT count(*) FROM MAC4.HES_PEOPLE"


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
>>>>>>> 0104ec4e7ab52d8fdbcea8b9efc1d52c7c9d89f8
