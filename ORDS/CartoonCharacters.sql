CONN mapping/uHxwGkzYuuPNXLQO6uE5@MAPD
BEGIN
ORDS.define_module(
                p_module_name => 'cartoon',
                p_base_path => 'cartoon/',
                p_items_per_page => 0);
ORDS.define_template(
                p_module_name => 'cartoon',
                p_pattern => 'name/');
-- READ : All records.
ORDS.define_handler(
                p_module_name => 'cartoon',
                p_pattern => 'name/',
                p_method => 'GET',
                p_source_type => ORDS.source_type_query,
                p_source => 'SELECT * FROM CartoonCharacters',
                p_items_per_page => 0);
-- READ : One Record
ORDS.define_template(
                p_module_name => 'cartoon',
                p_pattern => 'name/:name');
ORDS.define_handler(
                p_module_name => 'cartoon',
                p_pattern => 'name/:name',
                p_method => 'GET',
                p_source_type => ORDS.source_type_query,
                p_source => 'SELECT * FROM CartoonCharacters WHERE forename = :name UNION SELECT * FROM CartoonCharacters WHERE lastname = :name',
                p_items_per_page => 0);
COMMIT;
END;
/



