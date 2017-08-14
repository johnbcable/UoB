<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Access-Control-Allow-Origin", "*");

// Declare any local functions
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Now for any variables local to this page
var dbconnect=Application("testdata");
var RS, RS2, Conn, SQL1, SQL2, SQL3, SQL4;
var resultObj = new Object();
var personid = 0;
var mysurnameid = 0;
var myforenameid = 0;
var debugging = false;
var mydebug = new String("N").toString();
var myfirstname = new String("").toString();
var mylastname = new String("").toString();

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

SQL1 = new String("SELECT [Person Code] FROM AnonPersonFeed ORDER BY [Person Code]");

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
	Response.Write("<table><thead><th>Forenameid</th><th>Surnameid</th><th>firstname</th><th>Surname</th></thead><tbody>");
}


while (! RS.EOF) {

	personid = new String(RS("Person Code")).toString();
	mysurnameid = getRandomInt(1,87623);
	myforenameid = getRandomInt(1,4826);

	// Now go and get the names - forename first
	SQL3 = new String("SELECT [firstname] FROM AvailableFirstNames WHERE uniqueref = "+myforenameid).toString();
	SQL4 = new String("SELECT [LastName] FROM AvailableLastNames WHERE uniqueref = "+mysurnameid).toString();

		myfirstname = "NOT FOUND";
		RS2 = Conn.Execute(SQL3);
		if (! RS2.EOF) {
			myfirstname = new String(RS2("firstname")).toString();
		}

		mylastname = "NOT FOUND";
		RS2 = Conn.Execute(SQL4);
		if (! RS2.EOF) {
			mylastname = new String(RS2("LastName")).toString();
		}

		if (debugging) {
			Response.Write("<tr><td>"+myforenameid+"</td><td>"+mysurnameid+"</td><td>"+myfirstname+"</td><td>"+mylastname+"</td></tr>");
		}

	SQLstart = new String("UPDATE AnonPersonFeed ")
	SQLend = new String(" WHERE [Person Code]="+personid).toString();
	SQLmiddle = new String("SET ").toString();

	SQLmiddle += "AnonymisedSurname = '"+mylastname+"', AnonymisedForename = '"+myfirstname+"'";

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
