<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Access-Control-Allow-Origin", "*");

// Declare any local functions
function getRandomEmail(firstname, surname) {
		var workemail = new String("").toString();
		var myfirstinitial = firstname.substring(1,1);

		workemail += myfirstinitial+"."+surname+"@yopmail.com";
    return workemail;
}

// Now for any variables local to this page
var dbconnect=Application("testdata");
var RS, RS2, Conn, SQL1, SQL2, SQL3, SQL4;
var resultObj = new Object();
var personid = 0;
var myworkemail = new String("").toString();
var mysurname = new String("").toString();
var myforename = new String("").toString();
var debugging = true;
var mydebug = new String("N").toString();

// Are we running in debug mode

// mydebug = Request.QueryString("debug");
// if (mydebug == "" || mydebug == "null" || mydebug == "undefined")
// {
//	mydebug = new String("N").toString();
// }

// if (mydebug == "Y") {
//	debugging = true;
// } else {
//	debugging = false;
// }

Conn = Server.CreateObject("ADODB.Connection");
RS = Server.CreateObject("ADODB.RecordSet");
RS2 = Server.CreateObject("ADODB.RecordSet");
Conn.Open(dbconnect);

SQL1 = new String("SELECT [Person Code], [AnonymisedSurname], [AnonymisedForename]  FROM AnonPersonFeed");

try {
	RS = Conn.Execute(SQL1);
}
catch(e) {
	resultObj.result = false;
	resultObj.errno = (e.number & 0xFFFF);
	resultObj.description += e.description;
	resultObj.sql = new String(SQL1).toString();
}

if (debugging) {
	Response.Write("<table><thead><th>Person Code</th><th>Surname</th><th>firstname</th><th>Email</th></thead><tbody>");
}


while (! RS.EOF) {

	personid = new String(RS("Person Code")).toString();
	mysurname = new String(RS("AnonymisedSurname")).toString();
	myforename = new String(RS("AnonymisedForename")).toString();
	myworkemail = getRandomEmail(myforename, mysurname);

	if (debugging) {
		Response.Write("<tr><td>"+personid+"</td><td>"+mysurname+"</td><td>"+myfirstname+"</td><td>"+workemail+"</td></tr>");
	}

	SQLstart = new String("UPDATE AnonPersonFeed ");
	SQLend = new String(" WHERE [Person Code]="+personid).toString();
	SQLmiddle = new String("SET ").toString();

	SQLmiddle += "AnonymisedWorkEmail = '"+workemail+"'";

	SQL2 = new String(SQLstart+SQLmiddle+SQLend).toString();

	if (debugging) {
		Response.Write("SQL Update: ["+SQL2+"]<br />");
	} else {
		try {
			RS2 = Conn.Execute(SQL2);
		}
		catch(e) {
			resultObj.result = false;
			resultObj.errno = (e.number & 0xFFFF);
			resultObj.description += e.description;
			resultObj.sql = new String(SQL2).toString();
		}

	}

	RS.MoveNext();

}

if (debugging) {
	Response.Write("</tbody></table>");
}

%>
