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

  <div id="main"></div>

  <hr />

  <div id="fusionjsonheader"></div>
  <div id="fusionreceivedjson"></div>

  <hr />

  <div id="legacyjsonheader"></div>
  <div id="legacyreceivedjson"></div>
<%

// Custom ASP code

%>

<!--       Handlebars templates    -->

<script id="fusionlist-template" type="x-handlebars-template">
{{#if fusionemployees}}
<div class="row hide-for-small-only">
  <div class="large-10 medium-10 large-offset-1 medium-offset-1 fusionlist columns">
    <div class="row">
      <table>
        <thead>
          <tr>
            <th>Description</th>
            <th>Fusion Data</th>
            <th>Legacy Data</th>
          </tr>
        </thead>
        <tbody>
        {{#each fusionemployees}}
          <tr>
            <td>Personal Title</td>
            <td id="fusiontitle">{{Salutation}}</td>
            <td id="legacytitle"></td>
          </tr>
          <tr>
            <td>Forename</td>
            <td id="fusionforename">{{FirstName}}</td>
            <td id="legacyforename"></td>
          </tr>
          <tr>
            <td>Surname</td>
            <td id="fusionsurname">{{LastName}}</td>
            <td id="legacysurname"></td>
          </tr>
          <tr>
            <td>Preferred Name</td>
            <td id="fusionpreferredname">{{PreferredName}}</td>
            <td id="legacypreferredname"></td>
          </tr>
          <tr>
            <td>Person Code</td>
            <td id="fusionpersoncode">{{PersonNumber}}</td>
            <td id="legacypersoncode"></td>
          </tr>
          <tr>
            <td>Home Telephone</td>
            <td id="fusionhometelephone">{{HomeTelephone}}</td>
            <td id="legacyhometelephone"></td>
          </tr>
          <tr>
            <td>Work Email</td>
            <td id="fusionworkemail">{{WorkEmail}}</td>
            <td id="legacyworkemail"></td>
          </tr>
          <tr>
            <td>Address</td>
            <td id="fusionaddress">
              {{AddressLine1}}<br />
              {{AddressLine2}}<br />
              {{AddressLine3}}<br />
              {{Town}}<br />
              {{Region}}<br />
              {{Country}}<br />
              {{Postcode}}<br />
            </td>
            <td id="legacyaddress">

            </td>
          </tr>
          <tr>
            <td>Date Of Birth</td>
            <td id="fusiondob">{{DateOfBirth}}</td>
            <td id="legacydob"></td>
          </tr>
          <tr>
            <td>Ethnicity</td>
            <td id="fusionethnicity">{{Ethnicity}}</td>
            <td id="legacyethnicity"></td>
          </tr>
          <tr>
            <td>Gender</td>
            <td id="fusiongender">{{Gender}}</td>
            <td id="legacygender"></td>
          </tr>
          <tr>
            <td>NI Number</td>
            <td id="fusionni">{{NationalId}}</td>
            <td id="legacyni"></td>
          </tr>
          <tr>
            <td>User Name</td>
            <td id="fusionusername">{{UserName}}</td>
            <td id="legacyusername"></td>
          </tr>
        </tbody>
      </table>
  {{/each}}
  {{else}}
  <div class="row">
    <div class="large-10 medium-10 small-12 large-offset-1 medium-offset-1 columns">
      <p>
        No fusion data found
      </p>
    </div>
  </div>
  {{/if}}
  </script>


<!--    End of Handlebars templates    -->

	<script src="/UoB/bower_components/jquery/dist/jquery.js"></script>
  <script src="/UoB/bower_components/handlebars/handlebars.js"></script>
  <script src="/UoB/js/swag.js"></script>
  <script>Swag.registerHelpers(window.Handlebars);</script>
  <script src="/UoB/js/fusionextractdatawriter.js"></script>
  <script src="/UoB/js/RESTPoints.js"></script>

	</body>



</html>
<%
%>
