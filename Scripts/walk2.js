var fs = require('fs');
var path = require('path');
var walk = require('fs-walk');

var rootpath = 'c:\\Work\\WorkLinkRawData\\WorkLinkFiles';

walk.walkSync(dir, filelist) ({
	// var perm = stat.isDirectory() ? 0755 : 0644;
	var files = fs.readdirSync(rootpath);
	var fullparts = fullname.split("\\");

 	filelist = filelist || [];
 	files.forEach(function(file) {
       if (fs.statSync(path.join(dir, file)).isDirectory()) {
           filelist = walk.walkSync(path.join(dir, file), filelist);
       }
       else {
           filelist.push(path.join(dir, file));
       }
    });
    return filelist;
});



