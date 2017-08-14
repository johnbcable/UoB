<<<<<<< HEAD
define([
	"../core"
], function( jQuery ) {

// Multifunctional method to get and set values of a collection
// The value/s can optionally be executed if it's a function
var access = jQuery.access = function( elems, fn, key, value, chainable, emptyGet, raw ) {
=======
define( [
	"../core"
], function( jQuery ) {

"use strict";

// Multifunctional method to get and set values of a collection
// The value/s can optionally be executed if it's a function
var access = function( elems, fn, key, value, chainable, emptyGet, raw ) {
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	var i = 0,
		len = elems.length,
		bulk = key == null;

	// Sets many values
	if ( jQuery.type( key ) === "object" ) {
		chainable = true;
		for ( i in key ) {
<<<<<<< HEAD
			jQuery.access( elems, fn, i, key[i], true, emptyGet, raw );
=======
			access( elems, fn, i, key[ i ], true, emptyGet, raw );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		}

	// Sets one value
	} else if ( value !== undefined ) {
		chainable = true;

		if ( !jQuery.isFunction( value ) ) {
			raw = true;
		}

		if ( bulk ) {
<<<<<<< HEAD
=======

>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
			// Bulk operations run against the entire set
			if ( raw ) {
				fn.call( elems, value );
				fn = null;

			// ...except when executing function values
			} else {
				bulk = fn;
				fn = function( elem, key, value ) {
					return bulk.call( jQuery( elem ), value );
				};
			}
		}

		if ( fn ) {
			for ( ; i < len; i++ ) {
<<<<<<< HEAD
				fn( elems[i], key, raw ? value : value.call( elems[i], i, fn( elems[i], key ) ) );
=======
				fn(
					elems[ i ], key, raw ?
					value :
					value.call( elems[ i ], i, fn( elems[ i ], key ) )
				);
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
			}
		}
	}

<<<<<<< HEAD
	return chainable ?
		elems :

		// Gets
		bulk ?
			fn.call( elems ) :
			len ? fn( elems[0], key ) : emptyGet;
=======
	if ( chainable ) {
		return elems;
	}

	// Gets
	if ( bulk ) {
		return fn.call( elems );
	}

	return len ? fn( elems[ 0 ], key ) : emptyGet;
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
};

return access;

<<<<<<< HEAD
});
=======
} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
