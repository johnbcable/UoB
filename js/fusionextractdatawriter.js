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
        lineDelimiter = args.lineDelimiter || '\r\n';

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

    //  ===============================================
    //  Now as .csv
    // ============================================
    function convertArrayOfObjectsToCSV(args) {
        var result, ctr, keys, columnDelimiter, lineDelimiter, data, dummy;

        console.log("args.data as received by convertArrayOfObjectsToCSV");
        console.log(args.data);

        data = args.data || null;

        console.log("data after copying from args.data");
        console.log(data);

        if (data == null) {
          console.log("null data sent to convertArrayOfObjectsToCSV");
            return null;
        }
        if (!data.length) {
          console.log("array sent to convertArrayOfObjectsToCSV has no length");
            return null;
        }

        columnDelimiter = args.columnDelimiter || ',';
        lineDelimiter = args.lineDelimiter || '\r\n';

        console.log(data[0]);
        dummy = data[0];
        console.log(dummy);
        keys = Object.keys(data[0]);
        // console.log(Object.getOwnPropertyNames(data[0]));
       console.log(keys);

        result = '';
        result += keys.join(columnDelimiter);
        result += lineDelimiter;

        console.log(result);

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

    function downloadCSV(args) {
        var data, filename, link, sourcedata;

        sourcedata = args.data || noData;
        console.log("Source data as sent to downloadCSV is ");
        console.log(sourcedata);
        var csv = convertArrayOfObjectsToCSV({
            data: sourcedata
        });
        if (csv == null) {
          console.log("null returned from convertArrayOfObjectsToCSV "+args);
          return;
        };

        filename = args.filename || 'export.csv';

        if (!csv.match(/^data:text\/csv/i)) {
            csv = 'data:text/csv;charset=utf-8,' + csv;
        }
        data = encodeURI(csv);

        link = document.createElement('a');
        link.setAttribute('href', data);
        link.setAttribute('download', filename);
        link.click();
    }
