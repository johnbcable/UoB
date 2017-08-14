CONN testuser1/testuser1@pdb1
BEGIN
ORDS.define_module(
	p_module_name => 'testmodule9',
	p_base_path => 'testmodule9/',
	p_items_per_page => 0);
ORDS.define_template(
	p_module_name => 'testmodule9',
	p_pattern => 'emp/');
-- READ : All records.
ORDS.define_handler(
	p_module_name => 'testmodule9',
	p_pattern => 'emp/',
	p_method => 'GET',
	p_source_type => ORDS.source_type_query,
	p_source => 'SELECT * FROM emp',
	p_items_per_page => 0);
-- INSERT
ORDS.define_handler(
	p_module_name => 'testmodule9',
	p_pattern => 'emp/',
	p_method => 'POST',
	p_source_type => ORDS.source_type_plsql,
	p_source => 'BEGIN
					create_employee (p_empno => :empno,
									p_ename => :ename,
									p_job => :job,
									p_mgr => :mgr,
									p_hiredate => :hiredate,
									p_sal => :sal,
									p_comm => :comm,
									p_deptno => :deptno);
				END;',
	p_items_per_page => 0);
-- UPDATE
ORDS.define_handler(
	p_module_name => 'testmodule9',
	p_pattern => 'emp/',
	p_method => 'PUT',
	p_source_type => ORDS.source_type_plsql,
	p_source => 'BEGIN
					amend_employee(p_empno => :empno,
									p_ename => :ename,
									p_job => :job,
									p_mgr => :mgr,
									p_hiredate => :hiredate, 
									p_sal => :sal,
									p_comm => :comm,
									p_deptno => :deptno);
				END;',
	p_items_per_page => 0);
-- DELETE
ORDS.define_handler(
	p_module_name => 'testmodule9',
	p_pattern => 'emp/',
	p_method => 'DELETE',
	p_source_type => ORDS.source_type_plsql,
	p_source => 'BEGIN
					remove_employee(p_empno => :empno);
				END;',
	p_items_per_page => 0);
-- READ : One Record
ORDS.define_template(
	p_module_name => 'testmodule9',
	p_pattern => 'emp/:empno');
ORDS.define_handler(
	p_module_name => 'testmodule9',
	p_pattern => 'emp/:empno',
	p_method => 'GET',
	p_source_type => ORDS.source_type_query,
	p_source => 'SELECT * FROM emp WHERE empno = :empno',
	p_items_per_page => 0);
COMMIT;
END;
/