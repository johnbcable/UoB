    //  Define global-scoped dummy data if not data supllied on calls

    var noData = [
        {
            NODATA: 'No data supplied to function'
        }
    ];



    function convertArrayOfObjectsToDAT(args) {
        var result, ctr, keys, columnDelimiter, lineDelimiter, data;

        data = args.data || null;
        if (data == null || !data.length) {
            return null;
        }

        columnDelimiter = args.columnDelimiter || '|';
        lineDelimiter = args.lineDelimiter || '\n';

        keys = Object.keys(data[0]);

        result = '';
        result += keys.join(columnDelimiter);
        result += lineDelimiter;

        data.forEach(function(item) {
            ctr = 0;
            keys.forEach(function(key) {
                if (ctr > 0) result += columnDelimiter;

                result += item[key];
                ctr++;
            });
            result += lineDelimiter;
        });

        return result;
    }

    function downloadDAT(args) {
        var data, filename, link, sourcedata;

        sourcedata = args.data || noData;
        var csv = convertArrayOfObjectsToDAT({
            data: sourcedata
        });

        if (csv == null) return;

        filename = args.filename || 'export.dat';

        if (!csv.match(/^data:text\/csv/i)) {
            csv = 'data:text/csv;charset=utf-8,' + csv;
        }
        data = encodeURI(csv);

        link = document.createElement('a');
        link.setAttribute('href', data);
        link.setAttribute('download', filename);
        link.click();
    }

    /**
    *  VERSION // 0.1
    *  AUTHOR // siegfried.ehret@gmail.com
    *
    *  LICENSE //
    *
    *  DO WTF YOU WANT TO PUBLIC LICENSE
    *                   Version 2, December 2004
    *
    * Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
    *
    * Everyone is permitted to copy and distribute verbatim or modified
    * copies of this license document, and changing it is allowed as long
    * as the name is changed.
    *
    *           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
    *   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
    *
    * 0. You just DO WHAT THE FUCK YOU WANT TO.
    */
    var json2xml = (function (my, undefined) {
      "use strict";
      var tag = function(name, options) {
        var mynumber = parseInt(name);
        var realtag = name;
        if (! (isNaN(mynumber))) {
          realtag = "item"+realtag;
        }
        options = options || {};
        return "<"+(options.closing ? "/" : "")+realtag+">";
      };
      var exports = {
        convert:function(obj, rootname) {
          var xml = "";
          for (var i in obj) {
            if(obj.hasOwnProperty(i)){
              var value = obj[i], type = typeof value;
              if (value instanceof Array && type == 'object') {
                for (var sub in value) {
                  xml += exports.convert(value[sub]);
                }
              } else if (value instanceof Object && type == 'object') {
                xml += tag(i)+exports.convert(value)+tag(i,{closing:1});
              } else {
                xml += tag(i)+value+tag(i,{closing:1});
              }
            }
          }
          return rootname ? tag(rootname) + xml + tag(rootname,{closing:1}) : xml;
        }
      };
      return exports;
    })(json2xml || {});

    function downloadXML(args) {
        var data, filename, link, sourcedata, docroot;
        var dummyroot = 'root';

        sourcedata = args.data || noData;
        docroot = args.root || dummyroot;
        var xml = json2xml.convert(sourcedata, docroot);

        if (xml == null) return;

        filename = args.filename || 'export.xml';

        if (!xml.match(/^data:text\/xml/i)) {
            xml = 'data:text/xml;charset=utf-8,' + xml;
        }
        data = encodeURI(xml);

        link = document.createElement('a');
        link.setAttribute('href', data);
        link.setAttribute('download', filename);
        link.click();
    }
