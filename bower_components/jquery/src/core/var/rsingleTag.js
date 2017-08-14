<<<<<<< HEAD
define(function() {
	// Match a standalone tag
	return (/^<(\w+)\s*\/?>(?:<\/\1>|)$/);
});
=======
define( function() {
	"use strict";

	// Match a standalone tag
	return ( /^<([a-z][^\/\0>:\x20\t\r\n\f]*)[\x20\t\r\n\f]*\/?>(?:<\/\1>|)$/i );
} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
