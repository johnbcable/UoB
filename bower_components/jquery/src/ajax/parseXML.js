<<<<<<< HEAD
define([
	"../core"
], function( jQuery ) {

// Cross-browser xml parsing
jQuery.parseXML = function( data ) {
	var xml, tmp;
=======
define( [
	"../core"
], function( jQuery ) {

"use strict";

// Cross-browser xml parsing
jQuery.parseXML = function( data ) {
	var xml;
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	if ( !data || typeof data !== "string" ) {
		return null;
	}

<<<<<<< HEAD
	// Support: IE9
	try {
		tmp = new DOMParser();
		xml = tmp.parseFromString( data, "text/xml" );
=======
	// Support: IE 9 - 11 only
	// IE throws on parseFromString with invalid input.
	try {
		xml = ( new window.DOMParser() ).parseFromString( data, "text/xml" );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	} catch ( e ) {
		xml = undefined;
	}

	if ( !xml || xml.getElementsByTagName( "parsererror" ).length ) {
		jQuery.error( "Invalid XML: " + data );
	}
	return xml;
};

return jQuery.parseXML;

<<<<<<< HEAD
});
=======
} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
