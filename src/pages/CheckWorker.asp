<%@language="JScript" CODEPAGE="65001"%>
<%
Response.AddHeader("Access-Control-Allow-Origin", "*");

//  Global variables
//

// Now for any variables local to this page
// var dbconnect=Application("testdata");
// var RS, RS2, Conn, SQL1, SQL2, SQL3, SQL4;
// var resultObj = new Object();

// var debugging = false;
// var mydebug = new String("N").toString();

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
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foundation for Sites</title>
    <link rel="stylesheet" href="assets/css/app.css">
  </head>
  <body>
  <div class="grid-container">
    <div class="grid-x grid-margin-x">
      <div class="large-12 cell">
        <h1>Checking Migrated Worker Details</h1>
      </div>
    </div>

    <hr />

    <form>
      <div class="grid-x grid-margin-x">
        <div class="large-12 cell">
          <label>UoB Person ID (from ID badge)</label>
          <input type="text" placeholder="Person ID" />
        </div>
      </div>
    </form>
</div>
<script src="assets/js/app.js"></script>
</body>
</html>
<%
%>
