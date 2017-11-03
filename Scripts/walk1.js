var fs = require('fs');
var path = require('path');
var walk = require('fs-walk');

walk.walkSync('WorkLinkFiles', function(basedir, filename, stat) {
    // var perm = stat.isDirectory() ? 0755 : 0644;
    var fullname = path.join(basedir, filename);
    var fullparts = fullname.split("\\");

    var curdir = fullparts[3];

    

    console.log(fullparts);
});
