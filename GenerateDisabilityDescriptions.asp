<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Access-Control-Allow-Origin", "*");

// Declare any local functions
function getMyBelief() {
	var RelBlfList = new Array("","01","02","03","10","11","12","13","14","80","98");
	var dummy = 0;

	dummy = Math.floor(Math.random() * 10) +1;
	return RelBlfList[dummy];
}

// Now for any variables local to this page
var dbconnect=Application("testdata");
var RS, RS2, Conn, SQL1, SQL2;
var resultObj = new Object();
var personid = 0;
var mybelief = new String("");
var debugging = false;
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

while (! RS.EOF) {
	mybelief = new String("").toString();
	personid = new String(RS("Person Code")).toString();

	SQLstart = new String("UPDATE AnonPersonFeed ")
	SQLend = new String(" WHERE [Person Code]="+personid).toString();
	SQLmiddle = new String("SET ").toString();

	mybelief = getMyBelief();
	SQLmiddle += "[FusionReligiousBelief] = '"+mybelief+"'";

	SQL2 = new String(SQLstart+SQLmiddle+SQLend).toString();

	if (debugging) {
		Response.Write("SQL Insert: ["+SQL2+"]<br />");
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

%>
