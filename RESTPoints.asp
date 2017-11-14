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
    <title>Fusion HCM RESTPoints - Test Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="Description" lang="en" content="Test Fusion HCM RESTPoints">
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
        <th>Download XML</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>All Grades</td>
        <td><a id="allgradeslink" href='#'>JSON</a></td>
        <td><a id="allgradesdat" href='#'>DAT file</td>
        <td><a id="allgradescsv" href='#'>CSV file</td>
        <td><a id="allgradesxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>All Job Families</td>
        <td><a id="alljobfamilieslink" href='#'>JSON</a></td>
        <td><a id="alljobfamiliesdat" href='#'>DAT file</td>
        <td><a id="alljobfamiliescsv" href='#'>CSV file</td>
        <td><a id="alljobfamiliesxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>All Jobs</td>
        <td><a id="alljobslink" href='#'>JSON</a></td>
        <td><a id="alljobsdat" href='#'>DAT file</td>
        <td><a id="alljobscsv" href='#'>CSV file</td>
        <td><a id="alljobsxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>All Positions</td>
        <td><a id="allpositionslink" href='#'>JSON</a></td>
        <td><a id="allpositionsdat" href='#'>DAT file</td>
        <td><a id="allpositionscsv" href='#'>CSV file</td>
        <td><a id="allpositionsxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>All Locations</td>
        <td><a id="alllocationslink" href='#'>JSON</a></td>
        <td><a id="alllocationsdat" href='#'>DAT file</td>
        <td><a id="alllocationscsv" href='#'>CSV file</td>
        <td><a id="alllocationsxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>All Departments</td>
        <td><a id="allorganizationslink" href='#'>JSON</a></td>
        <td><a id="allorganizationsdat" href='#'>DAT file</td>
        <td><a id="allorganizationscsv" href='#'>CSV file</td>
        <td><a id="allorganizationsxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>All Divisions</td>
        <td><a id="alldivisionslink" href='#'>JSON</a></td>
        <td><a id="alldivisionsdat" href='#'>DAT file</td>
        <td><a id="alldivisionscsv" href='#'>CSV file</td>
        <td><a id="alldivisionsxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>Payroll Statutory Unit (PSU)</td>
        <td><a id="allpsulink" href='#'>JSON</a></td>
        <td><a id="allpsudat" href='#'>DAT file</td>
        <td><a id="allpsucsv" href='#'>CSV file</td>
        <td><a id="allpsuxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>Tax Reporting Unit (TRU)</td>
        <td><a id="alltrulink" href='#'>JSON</a></td>
        <td><a id="alltrudat" href='#'>DAT file</td>
        <td><a id="alltrucsv" href='#'>CSV file</td>
        <td><a id="alltruxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>Legal Reporting Unit (LRU)</td>
        <td><a id="alllrulink" href='#'>JSON</a></td>
        <td><a id="alllrudat" href='#'>DAT file</td>
        <td><a id="alllrucsv" href='#'>CSV file</td>
        <td><a id="alllruxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>Legal Employer (LEMP)</td>
        <td><a id="alllemplink" href='#'>JSON</a></td>
        <td><a id="alllempdat" href='#'>DAT file</td>
        <td><a id="alllempcsv" href='#'>CSV file</td>
        <td><a id="alllempxml" href='#'>XML file</td>
      </tr>
      <tr>
        <td>Reporting Establishment</td>
        <td><a id="allrelink" href='#'>JSON</a></td>
        <td><a id="allredat" href='#'>DAT file</td>
        <td><a id="allrecsv" href='#'>CSV file</td>
        <td><a id="allrexml" href='#'>XML file</td>
      </tr>
    </tbody>
  </table>

    <br />
    <a href="index.asp">Home page &raquo;</a>
    <br />

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

<!--
  Fusion

{"Title":"MRS.","Forename":"Keira","Surname":"Grobstein","PreferredName":null,"PersonNumber":5500165,"HomePhoneNumber":null,"WorkEmail":"e.grobstein@yopmail.com","AddressLine1":"55 Tagwell Road","AddressLine2":null,"AddressLine3":null,"City":"Droitwich","Region":"Worcestershire","Country":null,"PostalCode":"WR9 7AQ","DateOfBirth":"1971-04-26","Ethnicity":"White-British","Gender":"F","NationalId":"NX707818A","UserName":"QUEENNM"}

Legacy

{"Title":"MRS.","Forename":"Keira","Surname":"Grobstein","PreferredName":null,"PersonNumber":5500165,"HomePhoneNumber":null,"WorkEmail":"e.grobstein@yopmail.com","AddressLine1":"55 Tagwell Road","AddressLine2":null,"AddressLine3":null,"City":"Droitwich","Region":"Worcestershire","Country":null,"PostalCode":"WR9 7AQ","DateOfBirth":"1971-04-26","Ethnicity":"White-British","Gender":"F","NationalId":"NX707818A","UserName":"QUEENNM"}

-->

<!--       Handlebars templates    -->

<script id="comparator-template" type="x-handlebars-template">
<div class="row hide-for-small-only">
  <div class="large-10 medium-10 large-offset-1 medium-offset-1 fusionlist columns">
    <div class="row">
      <table border="1" cellspacing="5">
        <thead>
          <tr>
            <th>Description</th>
            <th>Fusion Data</th>
            <th>Legacy Data</th>
            <th>Comparison</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Personal Title</td>
            <td id="fusiontitle">{{model.Salutation}}</td>
            <td id="legacytitle">{{other.Title}}</td>
            <td id="comparisontitle">{{comparison.Title}}</td>
          </tr>
          <tr>
            <td>Forename</td>
            <td id="fusionforename">{{model.FirstName}}</td>
            <td id="legacyforename">{{other.Forename}}</td>
            <td id="comparisonforename">{{comparison.Forename}}</td>
          </tr>
          <tr>
            <td>Surname</td>
            <td id="fusionsurname">{{model.LastName}}</td>
            <td id="legacysurname">{{other.Surname}}</td>
            <td id="comparisonsurname">{{comparison.Surname}}</td>
          </tr>
          <tr>
            <td>Preferred Name</td>
            <td id="fusionpreferredname">{{model.PreferredName}}</td>
            <td id="legacypreferredname">{{other.PreferredName}}</td>
            <td id="comparisonpreferredname">{{comparison.Preferredname}}</td>
          </tr>
          <tr>
            <td>Person Code</td>
            <td id="fusionpersoncode">{{model.PersonNumber}}</td>
            <td id="legacypersoncode">{{other.PersonNumber}}</td>
            <td id="comparisonpersoncode">{{comparison.PersonCode}}</td>
          </tr>
          <tr>
            <td>Home Telephone</td>
            <td id="fusionhometelephone">{{model.HomeTelephone}}</td>
            <td id="legacyhometelephone">{{other.HomePhoneNumber}}</td>
            <td id="comparisonhometelephone">{{comparison.HomeTelephone}}</td>
          </tr>
          <tr>
            <td>Work Email</td>
            <td id="fusionworkemail">{{model.WorkEmail}}</td>
            <td id="legacyworkemail">{{other.WorkEmail}}</td>
            <td id="comparisonemail">{{comparison.WorkEmail}}</td>
          </tr>
          <tr>
            <td>Address</td>
            <td id="fusionaddress">
              {{model.AddressLine1}}<br />
              {{model.AddressLine2}}<br />
              {{model.AddressLine3}}<br />
              {{model.Town}}<br />
              {{model.Region}}<br />
              {{model.Country}}<br />
              {{model.PostalCode}}<br />
            </td>
            <td id="legacyaddress">
              {{other.AddressLine1}}<br />
              {{other.AddressLine2}}<br />
              {{other.AddressLine3}}<br />
              {{other.Town}}<br />
              {{other.Region}}<br />
              {{other.Country}}<br />
              {{other.PostalCode}}<br />
            </td>
            <td id="comparisonaddress">{{comparison.Address}}</td>
          </tr>
          <tr>
            <td>Date Of Birth</td>
            <td id="fusiondob">{{model.DateOfBirth}}</td>
            <td id="legacydob">{{other.DateOfBirth}}</td>
            <td id="comparisondob">{{comparison.DateOfBirth}}</td>
          </tr>
          <tr>
            <td>Ethnicity</td>
            <td id="fusionethnicity">{{model.Ethnicity}}</td>
            <td id="legacyethnicity">{{other.Ethnicity}}</td>
            <td id="comparisonethnicity">{{comparison.Ethnicity}}</td>
          </tr>
          <tr>
            <td>Gender</td>
            <td id="fusiongender">{{model.Gender}}</td>
            <td id="legacygender">{{other.Gender}}</td>
            <td id="comparisongender">{{comparison.Gender}}</td>
          </tr>
          <tr>
            <td>NI Number</td>
            <td id="fusionni">{{model.NationalId}}</td>
            <td id="legacyni">{{other.NationalId}}</td>
            <td id="comparisonni">{{comparison.NINumber}}</td>
          </tr>
          <tr>
            <td>User Name</td>
            <td id="fusionusername">{{model.UserName}}</td>
            <td id="legacyusername">{{other.UserName}}</td>
            <td id="comparisonusername">{{comparison.UserName}}</td>
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
  <script src="/UoB/js/datawriter.js"></script>
  <script src="/UoB/js/RESTPoints.js"></script>

	</body>



</html>
<%
%>
