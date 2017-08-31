//
//	RESTPoints.js
//
//	All Javascript routines to generate all segments of a a Worker.dat
//	as separate files
//
//	Normally called from RESTPoints.asp
//
//  Global variables
//


var baseCoreURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreApi/resources/11.12.1.0/";
var baseSetupURL = "https://edzz-test.hcm.em3.oraclecloud.com/hcmCoreSetupApi/resources/11.12.1.0/";
var legacyURL = "http://its-n-jcnc-01/UoB/fetchJSON.asp?id=49";
var jsonstring;

// Utility functions

// Register Handlebars helpers





$(document).ready(function() {

/*

function myfunc() {
   return {"name": "bob", "number": 1};
}

var myobj = myfunc();
console.log(myobj.name, myobj.number); // logs "bob 1"

*/

	// ===========================================
	// Employee

	$('#hbdual').click( function(event) {
		event.preventDefault();
		var myfusionemployee = {salutation: "MR.", firstname: "John", lastname: "Cable"};   // defaults to employee 5500165
		var mylegacyemployee = {title: "Mr", forename: "John", surname: "Cable"};   // defualts to employee 5500165
    var context = {
        model: myfusionemployee,
        other: mylegacyemployee
    };


    var theTemplateScript = $("#dualmodel-template").html();
    console.log(theTemplateScript);

    /*
    // Compile the Handlebars template
    var theTemplate = Handlebars.compile(theTemplateScript);

    // Clear out the display area
    $("#main").empty();
    $("#main").append(theTemplate(fusionemployeedata));

    */

    var theTemplate = Handlebars.compile(theTemplateScript);
    console.log("After compile");


    /*
    var template  = Handlebars.template(templateSpec);
    console.log("After Handlebars.template");
    */

    // Clear out the display area
    $("#main").empty();
    $("#main").append(theTemplate(context));

});


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
	// Organizations
	// 1. Departments
	$('#allorganizationslink').click( function(event) {
		event.preventDefault();
		getOrganisations('DEPARTMENT');
	});

	$('#allorganizationsdat').click( function(event) {
		event.preventDefault();
		getOrganisations('DEPARTMENT','DAT');
	});

	$('#allorganizationscsv').click( function(event) {
		event.preventDefault();
		getOrganisations('DEPARTMENT','CSV');
	});

	// 2. Divisions
	$('#alldivisionslink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_DIVISION');
	});

	$('#alldivisionsdat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_DIVISION','DAT');
	});

	$('#alldivisionscsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_DIVISION','CSV');
	});

	// 3. Payroll Statutory Units
	$('#allpsulink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_PSU');
	});

	$('#allpsudat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_PSU','DAT');
	});

	$('#allpsucsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_PSU','CSV');
	});

	// 4. Tax Reporting Unit
	$('#alltrulink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_TRU');
	});

	$('#alltrudat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_TRU','DAT');
	});

	$('#alltrucsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_TRU','CSV');
	});

	// 5. Legal Reporting Unit
	$('#alllrulink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LRU');
	});

	$('#alllrudat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LRU','DAT');
	});

	$('#alllrucsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LRU','CSV');
	});

	// 6. Legal Employer
	$('#alllemplink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LEMP');
	});

	$('#alllempdat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LEMP','DAT');
	});

	$('#alllempcsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_LEMP','CSV');
	});

	// 7. Reporting Establishment
	$('#allrelink').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_REPORTING_ESTABLISHMENT');
	});

	$('#allredat').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_REPORTING_ESTABLISHMENT','DAT');
	});

	$('#allrecsv').click( function(event) {
		event.preventDefault();
		getOrganisations('HCM_REPORTING_ESTABLISHMENT','CSV');
	});

})  // end of document.ready
