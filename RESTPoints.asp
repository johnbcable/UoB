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
    <title>Fusion HCM RESTPoints - Home Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="Description" lang="en" content="Fusion HCM RESTPoints">
    <style type="text/css">
      table tr td {
        text-align: center;
        padding: 10px;
      }
    </style>
	</head>

	<body>

  <table border="1" cellspacing="5">
    <thead>
      <tr>
        <th>Subject</th>
        <th>View JSON</th>
        <th>Download DAT</th>
        <th>Download CSV</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>All Grades</td>
        <td><a id="allgradeslink" href='#'>JSON</a></td>
        <td><a id="allgradesdat" href='#'>DAT file</td>
        <td><a id="allgradescsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>All Job Families</td>
        <td><a id="alljobfamilieslink" href='#'>JSON</a></td>
        <td><a id="alljobfamiliesdat" href='#'>DAT file</td>
        <td><a id="alljobfamiliescsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>All Jobs</td>
        <td><a id="alljobslink" href='#'>JSON</a></td>
        <td><a id="alljobsdat" href='#'>DAT file</td>
        <td><a id="alljobscsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>All Positions</td>
        <td><a id="allpositionslink" href='#'>JSON</a></td>
        <td><a id="allpositionsdat" href='#'>DAT file</td>
        <td><a id="allpositionscsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>All Locations</td>
        <td><a id="alllocationslink" href='#'>JSON</a></td>
        <td><a id="alllocationsdat" href='#'>DAT file</td>
        <td><a id="alllocationscsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>All Departments</td>
        <td><a id="allorganizationslink" href='#'>JSON</a></td>
        <td><a id="allorganizationsdat" href='#'>DAT file</td>
        <td><a id="allorganizationscsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>All Divisions</td>
        <td><a id="alldivisionslink" href='#'>JSON</a></td>
        <td><a id="alldivisionsdat" href='#'>DAT file</td>
        <td><a id="alldivisionscsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>Payroll Statutory Unit (PSU)</td>
        <td><a id="allpsulink" href='#'>JSON</a></td>
        <td><a id="allpsudat" href='#'>DAT file</td>
        <td><a id="allpsucsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>Tax Reporting Unit (TRU)</td>
        <td><a id="alltrulink" href='#'>JSON</a></td>
        <td><a id="alltrudat" href='#'>DAT file</td>
        <td><a id="alltrucsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>Legal Reporting Unit (LRU)</td>
        <td><a id="alllrulink" href='#'>JSON</a></td>
        <td><a id="alllrudat" href='#'>DAT file</td>
        <td><a id="alllrucsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>Legal Employer (LEMP)</td>
        <td><a id="alllemplink" href='#'>JSON</a></td>
        <td><a id="alllempdat" href='#'>DAT file</td>
        <td><a id="alllempcsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>Reporting Establishment</td>
        <td><a id="allrelink" href='#'>JSON</a></td>
        <td><a id="allredat" href='#'>DAT file</td>
        <td><a id="allrecsv" href='#'>CSV file</td>
      </tr>
      <tr>
        <td>Employee Data</td>
        <td colspan="3">

          <form>
            <div>
              <div>
                <label>UoB Person ID (from ID badge)</label>
                <input type="text" name="personcode" id="personcode" placeholder="Person ID" />&nbsp;&nbsp;
                <a id="personcomparator" href='#'>Check &raquo;</a>
              </div>
            </div>
          </form>

        </td>
      </tr>
    </tbody>
  </table>

  <hr />

  <div id="fusionjsonheader"></div>
  <div id="fusionreceivedjson"></div>

  <hr />

  <div id="legacyjsonheader"></div>
  <div id="legacyreceivedjson"></div>
<%

// Custom ASP code

%>

	<script src="/UoB/bower_components/jquery/dist/jquery.js"></script>
  <script src="/UoB/js/fusionextractdatawriter.js"></script>
  <script src="/UoB/js/RESTPoints.js"></script>
  <script src="/UoB/js/PersonComparators.js"></script>

	</body>



</html>
<%
%>
