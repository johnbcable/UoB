<<<<<<< HEAD
CREATE DIRECTORY test_dir AS 'c:\';
-- CREATE DIRECTORY test_dir AS '/tmp';
 
DECLARE
  fileHandler UTL_FILE.FILE_TYPE;
BEGIN
  fileHandler := UTL_FILE.FOPEN('test_dir', 'test_file.txt', 'W');
  UTL_FILE.PUTF(fileHandler, 'Writing TO a file\n');
  UTL_FILE.FCLOSE(fileHandler);
EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;
/

=======
CREATE DIRECTORY test_dir AS 'c:\';
-- CREATE DIRECTORY test_dir AS '/tmp';
 
DECLARE
  fileHandler UTL_FILE.FILE_TYPE;
BEGIN
  fileHandler := UTL_FILE.FOPEN('test_dir', 'test_file.txt', 'W');
  UTL_FILE.PUTF(fileHandler, 'Writing TO a file\n');
  UTL_FILE.FCLOSE(fileHandler);
EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;
/

>>>>>>> 0104ec4e7ab52d8fdbcea8b9efc1d52c7c9d89f8
