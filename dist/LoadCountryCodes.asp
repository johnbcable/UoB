<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Access-Control-Allow-Origin", "*");

// Declare any local functions



// Now for any variables local to this page
var dbconnect=Application("testdata");
var RS, RS2, Conn, SQL1, SQL2, SQL3, SQL4;
var resultObj = new Object();
var isocode = new String("").toString();
var isodesc = new String("").toString();
var hesacode = new String("").toString();
var hesadesc = new String("").toString();

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

SQL1 = new String("SELECT * FROM CountryCodes");

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

	isocode = new String(RS("ISOCountryCode")).toString();
	isodesc = new String(RS("ISODescription")).toString();
	hesacode = new String(RS("HESACode")).toString();
	hesadesc = new String(RS("HESADescription")).toString();

	if (isocode == '' || isocode == 'null' || isocode == 'undefined')
		isocode = new String("").toString();
	if (hesacode == '' || hesacode == 'null' || hesacode == 'undefined')
		hesacode = new String("").toString();
	if (isodesc == '' || isodesc == 'null' || isodesc == 'undefined')
		isodesc = new String("").toString();
	if (hesadesc == '' || hesadesc == 'null' || hesadesc == 'undefined')
		hesadesc = new String("").toString();

	Response.Write("INSERT INTO COUNTRYCODES VALUES ('"+isocode+"','"+isodesc+"','"+hesacode+"','"+hesadesc+"');<br />");

	RS.MoveNext();

}

%>
