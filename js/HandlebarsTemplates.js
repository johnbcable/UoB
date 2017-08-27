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
                <td id="fusiontitle">{{Title}}</td>
                <td id="legacytitle"></td>
              </tr>
              <tr>
                <td>Forename</td>
                <td id="fusionforename">{{Forename}}</td>
                <td id="legacyforename"></td>
              </tr>
              <tr>
                <td>Surname</td>
                <td id="fusionsurname">{{Surname}}</td>
                <td id="legacysurname"></td>
              </tr>
              <tr>
                <td>Preferred Name</td>
                <td id="fusionpreferredname">{{PreferredName}}</td>
                <td id="legacypreferredname"></td>
              </tr>
              <tr>
                <td>Person Code</td>
                <td id="fusionpersoncode">{{PersonCode}}</td>
                <td id="legacypersoncode"></td>
              </tr>
              <tr>
                <td>Home Telephone</td>
                <td id="fusionhometelephone">{{HomeTelephone}}</td>
                <td id="legacyhometelephone"></td>
              </tr>
              <tr>
                <td>Work Email</td>
                <td id="fusionworkemail">{{WorksEmailAddress}}</td>
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
                <td id="fusionethnicity">{{EthnicOriginDescription}}</td>
                <td id="legacyethnicity"></td>
              </tr>
              <tr>
                <td>Gender</td>
                <td id="fusiongender">{{Gender}}</td>
                <td id="legacygender"></td>
              </tr>
              <tr>
                <td>NI Number</td>
                <td id="fusionni">{{NINumber}}</td>
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
