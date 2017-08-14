CREATE OR REPLACE PROCEDURE GenerateAllContacts
IS

contactkount NUMBER(6);
namekount NUMBER(6);
emailkount NUMBER(6);
phonekount NUMBER(6);
relkount NUMBER(6);
addresskount NUMBER(6);

BEGIN

contactkount := 0;
namekount := 0;
emailkount := 0;
phonekount := 0;
relkount := 0;
addresskount := 0;
  --
  -- Main procedure controlling the production of various output files
  -- required for the Contact information
  --
  --    1.  Top-level contact info
  --
  contactkount := GenerateContact();
  --
  --    2.  Level 2 Contact Name
  --
  namekount := GenerateContactName();
  --
  --    3.  Level 2 Contact Email
  --
  emailkount := GenerateContactEmail();
  --
  --    4.  Level 2 contact phone
  --
  phonekount := GenerateContactPhone();
  --
  --    5.  Level 2 Contact Relationship
  --
  relkount := GenerateContactRelationship();
  --
  --    6.  Level 2 Contact Address
  --
  addresskount := GenerateContactAddress();

  --
  -- Ouput Summary information
  --
  -- set serveroutput on

  dbms_output.put_line('=====================================================');
  dbms_output.put_line('Summary report from GenerateAllContacts');
  dbms_output.put_line(' ');
  dbms_output.put_line('Top-level Contact entries                '||to_char(contactkount,'999999'));
  dbms_output.put_line('Contact Name entries                     '||to_char(namekount,'999999'));
  dbms_output.put_line('Contact Email entries                    '||to_char(emailkount,'999999'));
  dbms_output.put_line('Contact Phone entries                    '||to_char(phonekount,'999999'));
  dbms_output.put_line('Contact Relationship entries             '||to_char(relkount,'999999'));
  dbms_output.put_line('Contact Address entries                  '||to_char(addresskount,'999999'));
  dbms_output.put_line(' ');
  dbms_output.put_line('=====================================================');









END GenerateAllContacts;

/
