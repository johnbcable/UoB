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
    <title>Handlebars Demo Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="Description" lang="en" content="Fusion HCM RESTPoints">
    <style type="text/css">
      table tr td {
        padding: 10px;
      }
    </style>
	</head>

	<body>

  <table border="1" cellspacing="5">
    <thead>
      <tr>
        <th>Description</th>
        <th>Link</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Two models, one HB template</td>
        <td><a id="hbdual" href='#'>Show</a></td>
      </tr>

    </tbody>
  </table>

  <hr />

  <div id="main"></div>

  <hr />


<%

// Custom ASP code

%>

<!--       Handlebars templates    -->

<script id="dualmodel-template" type="x-handlebars-template">
<div class="row hide-for-small-only">
  <div class="large-10 medium-10 large-offset-1 medium-offset-1 columns">
    <div class="row">
      <table>
        <thead>
          <tr>
            <th>Description</th>
            <th>Model 1 Data</th>
            <th>Model 2 Data</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Personal Title</td>
            <td id="model1title">{{model.salutation}}</td>
            <td id="model2title">{{other.title}}</td>
          </tr>
          <tr>
            <td>Forename</td>
            <td id="model1forename">{{model.firstname}}</td>
            <td id="model2forename">{{other.forename}}</td>
          </tr>
          <tr>
            <td>Surname</td>
            <td id="model1surname">{{model.lastname}}</td>
            <td id="model2surname">{{other.surname}}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>
</script>


<!--    End of Handlebars templates    -->

	<script src="/UoB/bower_components/jquery/dist/jquery.js"></script>
  <script src="/UoB/bower_components/handlebars/handlebars.js"></script>
  <script src="/UoB/js/swag.js"></script>
  <script>Swag.registerHelpers(window.Handlebars);</script>
  <script src="/UoB/js/fusionextractdatawriter.js"></script>
  <script src="/UoB/js/HBDemo.js"></script>

	</body>



</html>
<%
%>
