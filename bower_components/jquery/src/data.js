<<<<<<< HEAD
define([
	"./core",
	"./var/rnotwhite",
	"./core/access",
	"./data/var/data_priv",
	"./data/var/data_user"
], function( jQuery, rnotwhite, access, data_priv, data_user ) {
=======
define( [
	"./core",
	"./core/access",
	"./data/var/dataPriv",
	"./data/var/dataUser"
], function( jQuery, access, dataPriv, dataUser ) {

"use strict";
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

//	Implementation Summary
//
//	1. Enforce API surface and semantic compatibility with 1.9.x branch
//	2. Improve the module's maintainability by reducing the storage
//		paths to a single mechanism.
//	3. Use the same single mechanism to support "private" and "user" data.
//	4. _Never_ expose "private" data to user code (TODO: Drop _data, _removeData)
//	5. Avoid exposing implementation details on user objects (eg. expando properties)
//	6. Provide a clear path for implementation upgrade to WeakMap in 2014

var rbrace = /^(?:\{[\w\W]*\}|\[[\w\W]*\])$/,
<<<<<<< HEAD
	rmultiDash = /([A-Z])/g;
=======
	rmultiDash = /[A-Z]/g;

function getData( data ) {
	if ( data === "true" ) {
		return true;
	}

	if ( data === "false" ) {
		return false;
	}

	if ( data === "null" ) {
		return null;
	}

	// Only convert to a number if it doesn't change the string
	if ( data === +data + "" ) {
		return +data;
	}

	if ( rbrace.test( data ) ) {
		return JSON.parse( data );
	}

	return data;
}
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

function dataAttr( elem, key, data ) {
	var name;

	// If nothing was found internally, try to fetch any
	// data from the HTML5 data-* attribute
	if ( data === undefined && elem.nodeType === 1 ) {
<<<<<<< HEAD
		name = "data-" + key.replace( rmultiDash, "-$1" ).toLowerCase();
=======
		name = "data-" + key.replace( rmultiDash, "-$&" ).toLowerCase();
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		data = elem.getAttribute( name );

		if ( typeof data === "string" ) {
			try {
<<<<<<< HEAD
				data = data === "true" ? true :
					data === "false" ? false :
					data === "null" ? null :
					// Only convert to a number if it doesn't change the string
					+data + "" === data ? +data :
					rbrace.test( data ) ? jQuery.parseJSON( data ) :
					data;
			} catch( e ) {}

			// Make sure we set the data so it isn't changed later
			data_user.set( elem, key, data );
=======
				data = getData( data );
			} catch ( e ) {}

			// Make sure we set the data so it isn't changed later
			dataUser.set( elem, key, data );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		} else {
			data = undefined;
		}
	}
	return data;
}

<<<<<<< HEAD
jQuery.extend({
	hasData: function( elem ) {
		return data_user.hasData( elem ) || data_priv.hasData( elem );
	},

	data: function( elem, name, data ) {
		return data_user.access( elem, name, data );
	},

	removeData: function( elem, name ) {
		data_user.remove( elem, name );
	},

	// TODO: Now that all calls to _data and _removeData have been replaced
	// with direct calls to data_priv methods, these can be deprecated.
	_data: function( elem, name, data ) {
		return data_priv.access( elem, name, data );
	},

	_removeData: function( elem, name ) {
		data_priv.remove( elem, name );
	}
});

jQuery.fn.extend({
=======
jQuery.extend( {
	hasData: function( elem ) {
		return dataUser.hasData( elem ) || dataPriv.hasData( elem );
	},

	data: function( elem, name, data ) {
		return dataUser.access( elem, name, data );
	},

	removeData: function( elem, name ) {
		dataUser.remove( elem, name );
	},

	// TODO: Now that all calls to _data and _removeData have been replaced
	// with direct calls to dataPriv methods, these can be deprecated.
	_data: function( elem, name, data ) {
		return dataPriv.access( elem, name, data );
	},

	_removeData: function( elem, name ) {
		dataPriv.remove( elem, name );
	}
} );

jQuery.fn.extend( {
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
	data: function( key, value ) {
		var i, name, data,
			elem = this[ 0 ],
			attrs = elem && elem.attributes;

		// Gets all values
		if ( key === undefined ) {
			if ( this.length ) {
<<<<<<< HEAD
				data = data_user.get( elem );

				if ( elem.nodeType === 1 && !data_priv.get( elem, "hasDataAttrs" ) ) {
					i = attrs.length;
					while ( i-- ) {

						// Support: IE11+
=======
				data = dataUser.get( elem );

				if ( elem.nodeType === 1 && !dataPriv.get( elem, "hasDataAttrs" ) ) {
					i = attrs.length;
					while ( i-- ) {

						// Support: IE 11 only
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
						// The attrs elements can be null (#14894)
						if ( attrs[ i ] ) {
							name = attrs[ i ].name;
							if ( name.indexOf( "data-" ) === 0 ) {
<<<<<<< HEAD
								name = jQuery.camelCase( name.slice(5) );
=======
								name = jQuery.camelCase( name.slice( 5 ) );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
								dataAttr( elem, name, data[ name ] );
							}
						}
					}
<<<<<<< HEAD
					data_priv.set( elem, "hasDataAttrs", true );
=======
					dataPriv.set( elem, "hasDataAttrs", true );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
				}
			}

			return data;
		}

		// Sets multiple values
		if ( typeof key === "object" ) {
<<<<<<< HEAD
			return this.each(function() {
				data_user.set( this, key );
			});
		}

		return access( this, function( value ) {
			var data,
				camelKey = jQuery.camelCase( key );
=======
			return this.each( function() {
				dataUser.set( this, key );
			} );
		}

		return access( this, function( value ) {
			var data;
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c

			// The calling jQuery object (element matches) is not empty
			// (and therefore has an element appears at this[ 0 ]) and the
			// `value` parameter was not undefined. An empty jQuery object
			// will result in `undefined` for elem = this[ 0 ] which will
			// throw an exception if an attempt to read a data cache is made.
			if ( elem && value === undefined ) {
<<<<<<< HEAD
				// Attempt to get data from the cache
				// with the key as-is
				data = data_user.get( elem, key );
				if ( data !== undefined ) {
					return data;
				}

				// Attempt to get data from the cache
				// with the key camelized
				data = data_user.get( elem, camelKey );
=======

				// Attempt to get data from the cache
				// The key will always be camelCased in Data
				data = dataUser.get( elem, key );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
				if ( data !== undefined ) {
					return data;
				}

				// Attempt to "discover" the data in
				// HTML5 custom data-* attrs
<<<<<<< HEAD
				data = dataAttr( elem, camelKey, undefined );
=======
				data = dataAttr( elem, key );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
				if ( data !== undefined ) {
					return data;
				}

				// We tried really hard, but the data doesn't exist.
				return;
			}

			// Set the data...
<<<<<<< HEAD
			this.each(function() {
				// First, attempt to store a copy or reference of any
				// data that might've been store with a camelCased key.
				var data = data_user.get( this, camelKey );

				// For HTML5 data-* attribute interop, we have to
				// store property names with dashes in a camelCase form.
				// This might not apply to all properties...*
				data_user.set( this, camelKey, value );

				// *... In the case of properties that might _actually_
				// have dashes, we need to also store a copy of that
				// unchanged property.
				if ( key.indexOf("-") !== -1 && data !== undefined ) {
					data_user.set( this, key, value );
				}
			});
=======
			this.each( function() {

				// We always store the camelCased key
				dataUser.set( this, key, value );
			} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
		}, null, value, arguments.length > 1, null, true );
	},

	removeData: function( key ) {
<<<<<<< HEAD
		return this.each(function() {
			data_user.remove( this, key );
		});
	}
});

return jQuery;
});
=======
		return this.each( function() {
			dataUser.remove( this, key );
		} );
	}
} );

return jQuery;
} );
>>>>>>> 5fa71e0e00466be5aac61fc6bef603839eaba19c
