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
  <title>Checking Worker Details</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="Description" lang="en" content="Checking Worker Details">
    <!--
    <link rel="stylesheet" href="assets/css/app.css">
  -->
  </head>
  <body>

    <div>
      <div>
        <div>
          <h1>Checking Migrated Worker Details</h1>
        </div>
      </div>

      <form id="personidform" name="personidform">
        <div>
          <div>
            <label>UoB Person ID (from ID badge)</label>
            <input type="text" name="personcode" id="personcode" placeholder="Person ID" />&nbsp;&nbsp;
            <a id="personcomparator" href='#'>Check &raquo;</a>
            <!--
            <input type="submit" name="mysubmit" id="mysubmit" value="Check &raquo;" />
            -->
          </div>
        </div>
      </form>
    </div>

    <hr />


      <div id="jsonheader"></div>
      <div id="receivedjson"></div>


    <script src="/UoB/bower_components/jquery/dist/jquery.js"></script>
    <script src="/UoB/js/PersonComparators.js"></script>
  </body>
</html>
<%
%>
