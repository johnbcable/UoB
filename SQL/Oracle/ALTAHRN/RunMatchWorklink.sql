CREATE OR REPLACE PROCEDURE RunMatchWorklink
IS

matchkount NUMBER(6);
analysekount NUMBER(6);

BEGIN

matchkount := 0;
analysekount := 0;
  --
  -- Main procedure controlling the matching of imported
  -- Worklink student data with AltaHR
  --
  matchkount := MATCHWORKLINK();

  analysekount := AnalyseWorklink();

  /*
  dbms_output.put_line('=====================================================');
  dbms_output.put_line('Summary report from MATCHWORKLINK');
  dbms_output.put_line(' ');
  dbms_output.put_line('Total matched to Alta                  '||to_char(matchkount,'999999'));
  dbms_output.put_line('Total analysed                         '||to_char(analysekount,'999999'));
  dbms_output.put_line(' ');
  dbms_output.put_line('=====================================================');
*/

END RunMatchWorklink;

/
