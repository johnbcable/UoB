<<<<<<< HEAD
define([
=======
define( [
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	"../core",
	"../event"
], function( jQuery ) {

<<<<<<< HEAD
// Attach a bunch of functions for handling common AJAX events
jQuery.each( [ "ajaxStart", "ajaxStop", "ajaxComplete", "ajaxError", "ajaxSuccess", "ajaxSend" ], function( i, type ) {
	jQuery.fn[ type ] = function( fn ) {
		return this.on( type, fn );
	};
});

});
=======
"use strict";

// Attach a bunch of functions for handling common AJAX events
jQuery.each( [
	"ajaxStart",
	"ajaxStop",
	"ajaxComplete",
	"ajaxError",
	"ajaxSuccess",
	"ajaxSend"
], function( i, type ) {
	jQuery.fn[ type ] = function( fn ) {
		return this.on( type, fn );
	};
} );

} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
