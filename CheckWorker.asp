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

      <form>
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

    <!--       Handlebars templates    -->

    <script id="fusionlist-template" type="x-handlebars-template">
    {{#if fusionperson}}
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
            {{#each fusionperson}}
              <tr>
                <td>Personal Title</td>
                <td id="fusiontitle">{{fusionperson.Title}}</td>
                <td id="legacytitle"></td>
              </tr>
              <tr>
                <td>Forename</td>
                <td id="fusionforename">{{fusionperson.Forename}}</td>
                <td id="legacyforename"></td>
              </tr>
              <tr>
                <td>Surname</td>
                <td id="fusionsurname">{{fusionperson.Surname}}</td>
                <td id="legacysurname"></td>
              </tr>
              <tr>
                <td>Preferred Name</td>
                <td id="fusionpreferredname">{{fusionperson.PreferredName}}</td>
                <td id="legacypreferredname"></td>
              </tr>
              <tr>
                <td>Person Code</td>
                <td id="fusionpersoncode">{{fusionperson.PersonCode}}</td>
                <td id="legacypersoncode"></td>
              </tr>
              <tr>
                <td>Home Telephone</td>
                <td id="fusionhometelephone">{{fusionperson.HomeTelephone}}</td>
                <td id="legacyhometelephone"></td>
              </tr>
              <tr>
                <td>Work Email</td>
                <td id="fusionworkemail">{{fusionperson.WorksEmailAddress}}</td>
                <td id="legacyworkemail"></td>
              </tr>
              <tr>
                <td>Address</td>
                <td id="fusionaddress">
                  {{fusionperson.AddressLine1}}<br />
                  {{fusionperson.AddressLine2}}<br />
                  {{fusionperson.AddressLine3}}<br />
                  {{fusionperson.Town}}<br />
                  {{fusionperson.Region}}<br />
                  {{fusionperson.Country}}<br />
                  {{fusionperson.Postcode}}<br />
                </td>
                <td id="legacyaddress">

                </td>
              </tr>
              <tr>
                <td>Date Of Birth</td>
                <td id="fusiondob">{{fusionperson.DateOfBirth}}</td>
                <td id="legacydob"></td>
              </tr>
              <tr>
                <td>Ethnicity</td>
                <td id="fusionethnicity">{{fusionperson.EthnicOriginDescription}}</td>
                <td id="legacyethnicity"></td>
              </tr>
              <tr>
                <td>Gender</td>
                <td id="fusiongender">{{fusionperson.Gender}}</td>
                <td id="legacygender"></td>
              </tr>
              <tr>
                <td>NI Number</td>
                <td id="fusionni">{{fusionperson.NINumber}}</td>
                <td id="legacyni"></td>
              </tr>
              <tr>
                <td>User Name</td>
                <td id="fusionusername">{{fusionperson.UserName}}</td>
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
    <script src="/UoB/js/PersonComparators.js"></script>
  </body>
</html>
<%
%>
