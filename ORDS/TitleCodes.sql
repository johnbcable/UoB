CONN mapping/uHxwGkzYuuPNXLQO6uE5@MAPD
BEGIN
ORDS.define_module(
                p_module_name => 'personal',
                p_base_path => 'personal/',
                p_items_per_page => 0);
ORDS.define_template(
                p_module_name => 'personal',
                p_pattern => 'title/');
-- READ : All records.
ORDS.define_handler(
                p_module_name => 'personal',
                p_pattern => 'title/',
                p_method => 'GET',
                p_source_type => ORDS.source_type_query,
                p_source => 'SELECT * FROM TitleCodes',
                p_items_per_page => 0);
-- READ : One Record
ORDS.define_template(
                p_module_name => 'personal',
                p_pattern => 'title/:titlecode');
ORDS.define_handler(
                p_module_name => 'personal',
                p_pattern => 'title/:titlecode',
                p_method => 'GET',
                p_source_type => ORDS.source_type_query,
                p_source => 'SELECT * FROM TitleCodes WHERE LegacyTitle = :titlecode UNION SELECT * FROM TitleCodes WHERE FusionTitle = :titlecode',
                p_items_per_page => 0);
COMMIT;
END;
/



