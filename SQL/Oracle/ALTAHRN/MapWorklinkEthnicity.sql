CREATE OR REPLACE FUNCTION MapWorklinkEthnicity(WL_ETHNICITY IN VARCHAR2)
  RETURN VARCHAR2
IS
  ALTAETHNIC  VARCHAR2(40);
BEGIN

  ALTAETHNIC := '90';

  BEGIN
    SELECT ALTAETHNICORIGIN INTO ALTAETHNIC
    FROM WORKLINKETHNICORIGINS
    WHERE STUDENTETHNICORIGIN = WL_ETHNICITY;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ALTAETHNIC := '90';   -- 90 === NOT Known
  END;

  RETURN ALTAETHNIC;

END;
/
