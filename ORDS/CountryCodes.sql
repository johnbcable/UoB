CONN mapping/uHxwGkzYuuPNXLQO6uE5@MAPD
BEGIN
ORDS.define_module(
                p_module_name => 'reference',
                p_base_path => 'reference/',
                p_items_per_page => 0);
ORDS.define_template(
                p_module_name => 'reference',
                p_pattern => 'country/');
-- READ : All records.
ORDS.define_handler(
                p_module_name => 'reference',
                p_pattern => 'country/',
                p_method => 'GET',
                p_source_type => ORDS.source_type_query,
                p_source => 'SELECT * FROM CountryCodes',
                p_items_per_page => 0);
-- READ : One Record
ORDS.define_template(
                p_module_name => 'reference',
                p_pattern => 'country/:countrycode');
ORDS.define_handler(
                p_module_name => 'reference',
                p_pattern => 'country/:countrycode',
                p_method => 'GET',
                p_source_type => ORDS.source_type_query,
                p_source => 'SELECT * FROM CountryCodes WHERE ISOCountryCode = :countrycode UNION SELECT * FROM CountryCodes WHERE HESACode = :countrycode',
                p_items_per_page => 0);
COMMIT;
END;
/



