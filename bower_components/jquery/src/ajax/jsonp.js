<<<<<<< HEAD
define([
=======
define( [
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	"../core",
	"./var/nonce",
	"./var/rquery",
	"../ajax"
], function( jQuery, nonce, rquery ) {

<<<<<<< HEAD
=======
"use strict";

>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
var oldCallbacks = [],
	rjsonp = /(=)\?(?=&|$)|\?\?/;

// Default jsonp settings
<<<<<<< HEAD
jQuery.ajaxSetup({
=======
jQuery.ajaxSetup( {
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	jsonp: "callback",
	jsonpCallback: function() {
		var callback = oldCallbacks.pop() || ( jQuery.expando + "_" + ( nonce++ ) );
		this[ callback ] = true;
		return callback;
	}
<<<<<<< HEAD
});
=======
} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

// Detect, normalize options and install callbacks for jsonp requests
jQuery.ajaxPrefilter( "json jsonp", function( s, originalSettings, jqXHR ) {

	var callbackName, overwritten, responseContainer,
		jsonProp = s.jsonp !== false && ( rjsonp.test( s.url ) ?
			"url" :
<<<<<<< HEAD
			typeof s.data === "string" && !( s.contentType || "" ).indexOf("application/x-www-form-urlencoded") && rjsonp.test( s.data ) && "data"
=======
			typeof s.data === "string" &&
				( s.contentType || "" )
					.indexOf( "application/x-www-form-urlencoded" ) === 0 &&
				rjsonp.test( s.data ) && "data"
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		);

	// Handle iff the expected data type is "jsonp" or we have a parameter to set
	if ( jsonProp || s.dataTypes[ 0 ] === "jsonp" ) {

		// Get callback name, remembering preexisting value associated with it
		callbackName = s.jsonpCallback = jQuery.isFunction( s.jsonpCallback ) ?
			s.jsonpCallback() :
			s.jsonpCallback;

		// Insert callback into url or form data
		if ( jsonProp ) {
			s[ jsonProp ] = s[ jsonProp ].replace( rjsonp, "$1" + callbackName );
		} else if ( s.jsonp !== false ) {
			s.url += ( rquery.test( s.url ) ? "&" : "?" ) + s.jsonp + "=" + callbackName;
		}

		// Use data converter to retrieve json after script execution
<<<<<<< HEAD
		s.converters["script json"] = function() {
=======
		s.converters[ "script json" ] = function() {
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
			if ( !responseContainer ) {
				jQuery.error( callbackName + " was not called" );
			}
			return responseContainer[ 0 ];
		};

<<<<<<< HEAD
		// force json dataType
=======
		// Force json dataType
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		s.dataTypes[ 0 ] = "json";

		// Install callback
		overwritten = window[ callbackName ];
		window[ callbackName ] = function() {
			responseContainer = arguments;
		};

		// Clean-up function (fires after converters)
<<<<<<< HEAD
		jqXHR.always(function() {
			// Restore preexisting value
			window[ callbackName ] = overwritten;

			// Save back as free
			if ( s[ callbackName ] ) {
				// make sure that re-using the options doesn't screw things around
				s.jsonpCallback = originalSettings.jsonpCallback;

				// save the callback name for future use
=======
		jqXHR.always( function() {

			// If previous value didn't exist - remove it
			if ( overwritten === undefined ) {
				jQuery( window ).removeProp( callbackName );

			// Otherwise restore preexisting value
			} else {
				window[ callbackName ] = overwritten;
			}

			// Save back as free
			if ( s[ callbackName ] ) {

				// Make sure that re-using the options doesn't screw things around
				s.jsonpCallback = originalSettings.jsonpCallback;

				// Save the callback name for future use
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
				oldCallbacks.push( callbackName );
			}

			// Call if it was a function and we have a response
			if ( responseContainer && jQuery.isFunction( overwritten ) ) {
				overwritten( responseContainer[ 0 ] );
			}

			responseContainer = overwritten = undefined;
<<<<<<< HEAD
		});
=======
		} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

		// Delegate to script
		return "script";
	}
<<<<<<< HEAD
});

});
=======
} );

} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
