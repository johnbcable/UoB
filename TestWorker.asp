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
    <title>Check Worker - Home Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="Description" lang="en" content="Check Worker">
    <style type="text/css">
      table tr td {
        padding: 10px;
      }
      table tr th {
        padding: 10px;
        text-align: left;
      }
      .notok {
        background-color: red;
        font-weight: bold;
        color: white;
      }
      td.notok p::before {
        content: &#10060; &nbsp;&nbsp;&nbsp;
      }
      .ok {
        font-weight: bold;
        color: green;
      }
      td.ok p::after {
         &nbsp;&nbsp;&nbsp;&#10004;
      }
    </style>
	</head>

	<body>

  <form>
  <table border="1" cellspacing="5" width="90%" align="center">
    <thead>
      <tr>
        <th>Subject</th>
        <th>User Id to Check</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Run Parameters</td>
        <td>
        <div>
          <div>
            <label>Debug mode?</label>
            <select id="debugmode">
              <option  selected value="N">No</option>
              <option  value="Y">Yes</option>
            </select><br />
            <label>Which legacy system?</label>
            <select id="legacysystem">
              <option  selected value="ACCESS">Anonymised Access MDB</option>
              <option  value="ALTAHRN">Alta HR (copy)</option>
            </select><br />
            <label>Which target Fusion environment</label>
            <select id="targetsystem">
              <option  selected value="edzz-test">Fusion Dev Environment</option>
            </select>
          </div>
        </div>
      </tr>
      <tr>
        </td>
        <td>Single Employee Comparison</td>
        <td>
            <div>
              <div>
                <label>UoB Person ID (from ID badge)</label>
                <input type="text" name="personcode" id="personcode" placeholder="Person ID" /><br />
                <a id="personcomparator" name="personcomparator" href='#'>Check &raquo;</a>
              </div>
            </div>

        </td>
      </tr>
      <!--    test out creating comparison spreadsheet  -->
      <tr>
        <td>
          Cohort Summary Comparison
        </td>
        <td>
          <a id="comparisonspreadsheet" name="comparisonspreadsheet" href="#">Generate comparison spreadsheet</a>
        </td>
      </tr>
      <!--    test low-level functions  -->
      <tr>
        <td>
          Low-level function test
        </td>
        <td>
          <a id="functiontest" name="functiontest" href="#">Run Tests</a>
        </td>
      </tr>
    </tbody>
  </table>
  </form>

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
      <table border="1" cellspacing="5" width="100%" align="center">
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
            <td id="legacytitle">{{other.TITLE}}</td>
            {{#is comparison.Title "OK"}}
            <td class="ok" id="comparisontitle">{{comparison.Title}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisontitle">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.Title}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Forename</td>
            <td id="fusionforename">{{model.FirstName}}</td>
            <td id="legacyforename">{{other.FORENAME}}</td>
            {{#is comparison.Forename "OK"}}
            <td class="ok" id="comparisonforename">{{comparison.Forename}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonforename">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.Forename}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Surname</td>
            <td id="fusionsurname">{{model.LastName}}</td>
            <td id="legacysurname">{{other.SURNAME}}</td>
            {{#is comparison.Surname "OK"}}
            <td class="ok" id="comparisonsurname">{{comparison.Surname}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonsurname">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.Surname}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Preferred Name</td>
            <td id="fusionpreferredname">{{model.PreferredName}}</td>
            <td id="legacypreferredname">{{other.PREFERREDNAME}}</td>
            {{#is comparison.Preferredname "OK"}}
            <td class="ok" id="comparisonpreferredname">{{comparison.Preferredname}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonpreferredname">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.Preferredname}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Person Code</td>
            <td id="fusionpersoncode">{{model.PersonNumber}}</td>
            <td id="legacypersoncode">{{other.PERSONNUMBER}}</td>
            {{#is comparison.PersonCode "OK"}}
            <td class="ok" id="comparisonpersoncode">{{comparison.PersonCode}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonpersoncode">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.PersonCode}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Home Telephone</td>
            <td id="fusionhometelephone">{{model.HomeTelephone}}</td>
            <td id="legacyhometelephone">{{other.HOMEPHONENUMBER}}</td>
            {{#is comparison.HomeTelephone "OK"}}
            <td class="ok" id="comparisonhometelephone">{{comparison.HomeTelephone}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonhometelephone">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.HomeTelephone}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Work Email</td>
            <td id="fusionworkemail">{{model.WorkEmail}}</td>
            <td id="legacyworkemail">{{other.WORKEMAIL}}</td>
            {{#is comparison.WorkEmail "OK"}}
            <td class="ok" id="comparisonemail">{{comparison.WorkEmail}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonemail">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.WorkEmail}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Address</td>
            <td id="fusionaddress">
              {{model.AddressLine1}}<br />
              {{model.AddressLine2}}<br />
              {{model.AddressLine3}}<br />
              {{model.City}}<br />
              {{model.Region}}<br />
              {{model.Country}}<br />
              {{model.PostalCode}}<br />
            </td>
            <td id="legacyaddress">
              {{other.ADDRESSLINE1}}<br />
              {{other.ADDRESSLINE2}}<br />
              {{other.ADDRESSLINE3}}<br />
              {{other.CITY}}<br />
              {{other.REGION}}<br />
              {{other.COUNTRY}}<br />
              {{other.POSTALCODE}}<br />
            </td>
            {{#is comparison.Address "OK"}}
            <td class="ok" id="comparisonaddress">{{comparison.Address}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonaddress">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.Address}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Date Of Birth</td>
            <td id="fusiondob">{{model.DateOfBirth}}</td>
            <td id="legacydob">{{other.DATEOFBIRTH}}</td>
            {{#is comparison.DateOfBirth "OK"}}
            <td class="ok" id="comparisondob">{{comparison.DateOfBirth}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisondob">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.DateOfBirth}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Ethnicity</td>
            <td id="fusionethnicity">{{model.Ethnicity}}</td>
            <td id="legacyethnicity">{{other.ETHNICITY}}</td>
            {{#is comparison.Ethnicity "OK"}}
            <td class="ok" id="comparisonethnicity">{{comparison.Ethnicity}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonethnicity">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.Ethnicity}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>Gender</td>
            <td id="fusiongender">{{model.Gender}}</td>
            <td id="legacygender">{{other.GENDER}}</td>
            {{#is comparison.Gender "OK"}}
            <td class="ok" id="comparisongender">{{comparison.Gender}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisongender">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.Gender}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>NI Number</td>
            <td id="fusionni">{{model.NationalId}}</td>
            <td id="legacyni">{{other.NATIONALID}}</td>
            {{#is comparison.NINumber "OK"}}
            <td class="ok" id="comparisonni">{{comparison.NINumber}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonni">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.NINumber}}</td>
            {{/is}}
          </tr>
          <tr>
            <td>User Name</td>
            <td id="fusionusername">{{model.UserName}}</td>
            <td id="legacyusername">{{other.USERNAME}}</td>
            {{#is comparison.UserName "OK"}}
            <td class="ok" id="comparisonusername">{{comparison.UserName}} &#10004;</td>
            {{else}}
            <td class="notok" id="comparisonusername">&#10060 &nbsp;&nbsp;&nbsp;{{comparison.UserName}}</td>
            {{/is}}
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
  <script src="/UoB/js/dataextractwriter.js"></script>
  <script src="/UoB/js/datatransforms.js"></script>
  <script src="/UoB/js/TestWorker.js"></script>

	</body>



</html>
<%
%>
