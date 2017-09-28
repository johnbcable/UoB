$('#comparisonspreadsheet').click( function(event) {
  event.preventDefault();

  // Set up parameters for this run.

  paramSetup();

  // Reinitialise comparisonSummary Array
  var comparisonSummary = new Array();
  var mycomparison = {};
  var summarylength = 0;
  var peopleList = new Array();

  console.log(debugging ?  "We are in debug mode" : "We are in live mode");

  // Pick up list of people to look at
  //

  if (!debugging)
  {
    var legacyurl = baseLegacyURL + "?id=48";
    console.log(legacyurl);
    $.getJSON(legacyurl, function (legacydata) {
      // console.log("Data returned from getJSON call to legacy URL");
      // console.log(data);

      // console.log("Length of returned legacydata from getJSON");
      // console.log(legacydata.length);
      // console.log(legacydata.constructor === Array ? "legacydata is an Array" : "legacydata is NOT an Array");
      // console.log(legacydata[0]);

      // var jsonstring = JSON.stringify(legacydata);

      // jsonstring = new String("{allPeople:"+jsonstring+"}");

      // var peopledata = eval("("+jsonstring+")");

      // Set up array with list of person IDs

      var summarylength = 0;
      for (var i=0; i < legacydata.length; i++)
      {
        console.log(legacydata[i].PersonCode);
        peopleList[i] = legacydata[i].PersonCode;
        summarylength++;
      }
/*
      var dummy = 0;
      $.each(legacydata, function() {
        $.each(this, function() {
          // console.log(this.PersonCode);
          dummy = this.PersonCode;
          console.log(dummy);
          summarylength = peopleList.push(dummy);
        });
      });
*/
    });
  }
  else
  {
     peopleList = [5500018, 5500215, 5500165, 6704306];
     summarylength = 4;
  }

  console.log("List of people");
  console.log(peopleList);
  // console.log(peopleList.constructor === Array ? "peopleList is an Array" : "peopleList is NOT an Array");

  // Now loop through the set of people comparing each one and adding to resultset
  for (var i=0; i < summarylength; i++) {
    console.log("Comparing employee "+peopleList[i]);
    var mycomparison = compareEmployee(peopleList[i]);
    // console.log("Results from comparing "+peopleList[i]);
    // console.log(mycomparison);
    comparisonSummary.push(mycomparison);
  }

  if ( debugging ) {
      // console.log(comparisonSummary);
      // console.log("About to call downloadCSV");
      if ( debugging ) {
        $('#legacyjsonheader').html('<h1>Comparison matrix</h1>');

        $('#legacyreceivedjson').html();
        $('#legacyreceivedjson').html(JSON.stringify(comparisonSummary));
      }
  }
  // Write out summary spreadsheet
  downloadCSV({ data: comparisonSummary, filename: "ComparisonSummary.csv" });

});
