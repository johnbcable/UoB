<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Access-Control-Allow-Origin", "*");

// Declare any local functions

// Now for any variables local to this page
var dbconnect=Application("testdata");
var RS, RS2, Conn, SQL1, SQL2;
var resultObj = new Object();
var personid = 0;
var surnametoremove = new String("");
var firstnametoremove = new String("");
var debugging = false;
var mydebug = new String("N").toString();
var surnamesdeleted = 0;
var firstnamesdeleted = 0;

// Are we running in debug mode

/*
mydebug = Request.QueryString("debug");
if (mydebug == "" || mydebug == "null" || mydebug == "undefined")
{
	mydebug = new String("N").toString();
}

if (mydebug == "Y") {
	debugging = true;
*/

Conn = Server.CreateObject("ADODB.Connection");
RS = Server.CreateObject("ADODB.RecordSet");
RS2 = Server.CreateObject("ADODB.RecordSet");
Conn.Open(dbconnect);

SQL1 = new String("SELECT Distinct([Surname]) FROM AnonPersonFeed ORDER BY [Surname]");

try {
	RS = Conn.Execute(SQL1);
}
catch(e) {
	resultObj.result = false;
	resultObj.errno = (e.number & 0xFFFF);
	resultObj.description += e.description;
	resultObj.sql = new String(SQL1).toString();
}

while (! RS.EOF) {
	surnametoremove = new String(RS("Surname")).toString();

	SQLstart = new String("DELETE FROM AvailableLastNames ")
	SQLend = new String(" WHERE [LastName] = ").toString();

	SQLend += "'"+surnametoremove+"'";

	SQL2 = new String(SQLstart+SQLend).toString();

	if (debugging) {
		Response.Write("SQL DELETE: ["+SQL2+"]<br />");
	} else {
		try {
			RS2 = Conn.Execute(SQL2);
			surnamesdeleted += 1;
		}
		catch(e) {
			resultObj.result = false;
			resultObj.errno = (e.number & 0xFFFF);
			resultObj.description += e.description;
			resultObj.sql = new String(SQL2).toString();
			Response.Write("Failed to delete "+surnametoremove+"<br />")
			surnamesdeleted -= 1;
		}

	}


	RS.MoveNext();

}

//  Now for First Names

SQL1 = new String("SELECT Distinct([Forename]) FROM AnonPersonFeed ORDER BY [Forename]");

try {
	RS = Conn.Execute(SQL1);
}
catch(e) {
	resultObj.result = false;
	resultObj.errno = (e.number & 0xFFFF);
	resultObj.description += e.description;
	resultObj.sql = new String(SQL1).toString();
}

Response.Write("<br />===========================================================<br /><br />");

while (! RS.EOF) {
	firstnametoremove = new String(RS("Forename")).toString();

	SQLstart = new String("DELETE FROM AvailableFirstNames ")
	SQLend = new String(" WHERE [firstname] = ").toString();

	SQLend += "'"+firstnametoremove+"'";

	SQL2 = new String(SQLstart+SQLend).toString();

	if (debugging) {
		Response.Write("SQL DELETE: ["+SQL2+"]<br />");
	} else {
		try {
			RS2 = Conn.Execute(SQL2);
			firstnamesdeleted += 1;
		}
		catch(e) {
			resultObj.result = false;
			resultObj.errno = (e.number & 0xFFFF);
			resultObj.description += e.description;
			resultObj.sql = new String(SQL2).toString();
			firstnamesdeleted -= 1;
		}

	}


	RS.MoveNext();

}

Response.Write("<br />===========================================================<br /><br />");
Response.Write("Surnames deleted from AvailableLastNames:     "+surnamesdeleted+"<br />");
Response.Write("First names deleted from AvailableFirstNames: "+firstnamesdeleted+"<br />");

%>
