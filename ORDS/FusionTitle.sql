CREATE OR REPLACE FUNCTION getFusionTitle (oldtitle IN VARCHAR2)
  RETURN VARCHAR2
IS

  CURSOR c1 is
   SELECT NVL(Trim(FUSIONTITLE),'NONE') as FUSIONTITLE FROM TITLECODES T
     WHERE T.LEGACYTITLE = oldtitle;

  my_title VARCHAR2(32);
  my_retrievedtitle VARCHAR2(32);

BEGIN

/*
LEGACYTITLE	        VARCHAR2(30),
FUSIONTITLE         VARCHAR2(30),
DESCRIPTION         VARCHAR2(255)
*/

  my_title := UPPER(oldtitle);
  OPEN c1;
  FETCH c1 INTO my_retrievedtitle;
  IF my_retrievedtitle != 'NONE'
  THEN
    my_title := my_retrievedtitle;
  END IF;
  CLOSE c1;

  RETURN Trim(my_title);

END;
/
