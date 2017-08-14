<<<<<<< HEAD
define([
	"../core",
	"../var/strundefined"
], function( jQuery, strundefined ) {

var
=======
define( [
	"../core"
], function( jQuery, noGlobal ) {

"use strict";

var

>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	// Map over jQuery in case of overwrite
	_jQuery = window.jQuery,

	// Map over the $ in case of overwrite
	_$ = window.$;

jQuery.noConflict = function( deep ) {
	if ( window.$ === jQuery ) {
		window.$ = _$;
	}

	if ( deep && window.jQuery === jQuery ) {
		window.jQuery = _jQuery;
	}

	return jQuery;
};

// Expose jQuery and $ identifiers, even in AMD
// (#7102#comment:10, https://github.com/jquery/jquery/pull/557)
// and CommonJS for browser emulators (#13566)
<<<<<<< HEAD
if ( typeof noGlobal === strundefined ) {
	window.jQuery = window.$ = jQuery;
}

});
=======
if ( !noGlobal ) {
	window.jQuery = window.$ = jQuery;
}

} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
