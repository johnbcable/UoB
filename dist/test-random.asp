<%@language="JScript" CODEPAGE="65001"%>
<%

Response.AddHeader("Access-Control-Allow-Origin", "*");

var RelBlfList = new Array("","01","02","03","10","11","12","13","14","80","98");
var dummy = 0;

for (i=0; i<20; i++) {
	dummy = Math.floor(Math.random() * 10) +1;
	Response.Write("Random number: "+dummy+" - Religious Belief code: "+RelBlfList[dummy]+"</br>");
}

%>
