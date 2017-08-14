
CREATE OR REPLACE DIRECTORY migration_files_dir AS '/u25/migration-files';
GRANT READ, WRITE ON DIRECTORY migration_files_dir TO SIDILECL_RW,CABLEJ_RW,BRADBUDJ_RW;

desc all_directories;
select * from all_directories;

DECLARE
  fileHandler UTL_FILE.FILE_TYPE;
BEGIN
  fileHandler := UTL_FILE.FOPEN('MIGRATION_FILES_DIR', 'test_file.txt', 'W');
  UTL_FILE.PUTF(fileHandler, 'Writing TO a file\n');
  UTL_FILE.FCLOSE(fileHandler);
EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;

SELECT * FROM TABLE(uob_file_api.file_contents('MIGRATION_FILES_DIR', 'test_file.txt'));
desc upay_staff_extract;


Declare
file1 utl_file.file_type;
Begin
file1:= utl_file.fopen('MIGRATION_FILES_DIR','sample.txt','w');
utl_file.put_line(file1,'Welcome' );
utl_file.fclose(file1);
end;
/
SELECT * FROM TABLE(uob_file_api.file_contents('MIGRATION_FILES_DIR', 'sample.txt'));



desc all_directories
select owner, directory_name from all_directories;


