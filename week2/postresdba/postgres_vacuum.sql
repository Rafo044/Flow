


CREATE TABLE 		test_vacuum(id   SERIAL PRIMARY KEY ,
								name TEXT
								);

INSERT INTO 		test_vacuum(name)
VALUES  			('A'),('B'),('C');


SELECT 				*
FROM 				test_vacuum;

SELECT     			xmin,xmax,ctid,*
FROM 				test_vacuum;


UPDATE        		test_vacuum
SET   				name = 'B2'
WHERE               id = 2;


DELETE FROM         test_vacuum
WHERE               id = 3;

SELECT     			xmin,xmax,ctid,*
FROM 				test_vacuum;


SHOW maintenance_work_mem;
SHOW work_mem;


EXPLAIN SELECT name FROM test_vacuum WHERE name = 'A';


CREATE EXTENSION pg_visibility;


SELECT * FROM pg_visibility_map('test_vacuum');


SHOW autovacuum_naptime;

SELECT relname,
       last_autovacuum,
       n_dead_tup,
       vacuum_count
FROM pg_stat_all_tables
WHERE relname = 'test_vacuum';

CREATE EXTENSION IF NOT EXISTS pageinspect;

SELECT lp, lp_flags, t_xmin, t_xmax, t_ctid, t_data
FROM heap_page_items(get_raw_page('test_vacuum', 0));

SELECT relname,
       n_live_tup,
       n_dead_tup,
       last_vacuum,
       last_autovacuum,
       vacuum_count,
       autovacuum_count
FROM pg_stat_user_tables
WHERE relname = 'test_vacuum';

SHOW autovacuum_enabled;


EXPLAIN SELECT relname, reloptions
FROM pg_class
WHERE relname = 'test_vacuum';




ANALYZE test_vacuum;








