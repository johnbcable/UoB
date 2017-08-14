//
//	RESTPoints.js
//
//	All Javascript routines to generate all segments of a a Worker.dat
//	as separate files
//
//	Normally called from RESTPoints.html
//
//  Global variables
//


var baseCoreURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/"
var baseSetupURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreSetupApi/resources/11.12.1.0/"

// ============================================================================
function getGrades(filetype) {

	var url = baseSetupURL +"grades?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#jsonheader').html('');
	$('#receivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#jsonheader').html('<h1>All Grades</h1>');

			$('#receivedjson').html(jsonstring);

  		if (generatedfiletype == 'DAT') {
				console.log("DAT file chosen");
				downloadDAT({ data: data.items, filename: "Grade.dat" });
			}
			if (generatedfiletype == 'CSV') {
				console.log("CSV file chosen");
				downloadCSV({ data: data.items, filename: "Grade.csv" });
			}

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}

// ============================================================================
function getJobs(filetype) {

	var url = baseSetupURL +"jobs?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#jsonheader').html('');
	$('#receivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#jsonheader').html('<h1>All Jobs</h1>');

			$('#receivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
 				console.log("DAT file chosen");
 				downloadDAT({ data: data.items, filename: "Job.dat" });
 			}
 			if (generatedfiletype == 'CSV') {
 				console.log("CSV file chosen");
 				downloadCSV({ data: data.items, filename: "Job.csv" });
 			}

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}

// ============================================================================
function getPositions(filetype) {

	var url = baseSetupURL +"positions?onlyData&limit=30000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#jsonheader').html('');
	$('#receivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#jsonheader').html('<h1>All Positions</h1>');

			$('#receivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: "Position.dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename: "Position.csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}


// ============================================================================
function getJobFamilies(filetype) {

	var url = baseSetupURL +"jobFamilies?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#jsonheader').html('');
	$('#receivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#jsonheader').html('<h1>All Job Families</h1>');

			$('#receivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: "JobFamily.dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename: "JobFamily.csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}


// ============================================================================
function getLocations(filetype) {

	var url = baseSetupURL +"locations?onlyData&limit=1000";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#jsonheader').html('');
	$('#receivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#jsonheader').html('<h1>All Locations</h1>');

			$('#receivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: "Location.dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename: "Location.csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}

// ============================================================================
function getDepartments(filetype) {

	var url = baseSetupURL +"organizations?onlyData&limit=1000&q=ClassificationCode=DEPARTMENT";
	var generatedfiletype = filetype || '';

	console.log(url);

	// var eventsfound = false;
	$('#jsonheader').html('');
	$('#receivedjson').html('');

	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		headers: {"Authorization": "Basic " + btoa("TECHADMIN6:Banzai29")},
		success: function(data) {
			var jsonstring = JSON.stringify(data);

			$('#jsonheader').html('<h1>All Departments</h1>');

			$('#receivedjson').html(jsonstring);

			if (generatedfiletype == 'DAT') {
				 console.log("DAT file chosen");
				 downloadDAT({ data: data.items, filename: "Organization.dat" });
			 }
			 if (generatedfiletype == 'CSV') {
				 console.log("CSV file chosen");
				 downloadCSV({ data: data.items, filename: "Organization.csv" });
			 }

		},
		error: function(xhr, textStatus, errorThrown) {
			$('#error').html(xhr.responseText);
		}

	});  // end of ajax call

}


$(document).ready(function() {

	// ===========================================
	// Grades

	$('#allgradeslink').click( function(event) {
		event.preventDefault();
		getGrades();
	});

	$('#allgradesdat').click( function(event) {
		event.preventDefault();
		getGrades('DAT');
	});

	$('#allgradescsv').click( function(event) {
		event.preventDefault();
		getGrades('CSV');
	});

	// ===========================================
	// Job Families

	$('#alljobfamilieslink').click( function(event) {
		event.preventDefault();
		getJobFamilies();
	});

	$('#alljobfamiliesdat').click( function(event) {
		event.preventDefault();
		getJobFamilies('DAT');
	});

	$('#alljobfamiliescsv').click( function(event) {
		event.preventDefault('CSV');
		getJobFamilies();
	});

	// ===========================================
	// Jobs

	$('#alljobslink').click( function(event) {
		event.preventDefault();
		getJobs();
	});

	$('#alljobsdat').click( function(event) {
		event.preventDefault();
		getJobs('DAT');
	});

	$('#alljobscsv').click( function(event) {
		event.preventDefault();
		getJobs('CSV');
	});

	// ===========================================
	// Positions
	$('#allpositionslink').click( function(event) {
		event.preventDefault();
		getPositions();
	});

	$('#allpositionsdat').click( function(event) {
		event.preventDefault();
		getPositions('DAT');
	});

	$('#allpositionscsv').click( function(event) {
		event.preventDefault();
		getPositions('CSV');
	});

	// ===========================================
	// Locations
	$('#alllocationslink').click( function(event) {
		event.preventDefault();
		getLocations();
	});

	$('#alllocationsdat').click( function(event) {
		event.preventDefault();
		getLocations('DAT');
	});

	$('#alllocationscsv').click( function(event) {
		event.preventDefault();
		getLocations('CSV');
	});

	// ===========================================
	// Organizations (departments)
	$('#allorganizationslink').click( function(event) {
		event.preventDefault();
		getDepartments();
	});

	$('#allorganizationsdat').click( function(event) {
		event.preventDefault();
		getDepartments('DAT');
	});

	$('#allorganizationscsv').click( function(event) {
		event.preventDefault();
		getDepartments('CSV');
	});


})  // end of document.ready
