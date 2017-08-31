<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Access-Control-Allow-Origin", "*");

//  Global variables
//

// Now for any variables local to this page
var dbconnect=Application("testdata");
var RS, RS2, Conn, SQL1, SQL2, SQL3, SQL4;
var resultObj = new Object();

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

%>
<!doctype html>
<html class="no-js" lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>VM Web Site - Home Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="Description" lang="en" content="Home Page">
    <style type="text/css">
      table tr td {
        padding: 10px;
      }
    </style>
	</head>

	<body>

  <table border="1" cellspacing="5" cellpadding="5">
    <thead>
      <tr>
        <th>Topic Area</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a href="CheckWorker.asp">Legacy / Fusion Worker Cross-Check</a></td>
      </tr>
      <tr>
        <td><a href="RESTPoints.asp">Fusion HCM REST Points</a></td>
      </tr>
      </tr>
    </tbody>
  </table>


<!--       Handlebars templates    -->


<!--    End of Handlebars templates    -->

	<script src="/UoB/bower_components/jquery/dist/jquery.js"></script>
<!--
  <script src="/UoB/bower_components/handlebars/handlebars.js"></script>
  <script src="/UoB/js/swag.js"></script>
  <script>Swag.registerHelpers(window.Handlebars);</script>
-->
	</body>



</html>
<%
%>
