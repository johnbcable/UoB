SELECT * FROM ALL_DIRECTORIES

Declare
file1 utl_file.file_type;
Begin
file1:= utl_file.fopen('MIGRATION_SHARED_DIR','Contact.dat','w');
utl_file.put_line(file1,'Welcome' );
utl_file.fclose(file1);
end;
/
SELECT * FROM TABLE(uob_file_api.file_contents('MIGRATION_SHARED_DIR', 'Contact.dat'));


@JCZZ.sql

desc hes_people@hr_link

SELECT * FROM TABLE(uob_file_api.file_contents('MIGRATION_SHARED_DIR', 'test_file.txt'));

