--========================================
--        Background process
--========================================

SELECT 		pid,usename,client_addr ,
			client_port ,backend_start ,
			state ,query ,
			application_name 
FROM 		pg_stat_activity
ORDER  BY 	backend_start ;



SELECT 		pid,
			CASE 
				WHEN backend_type = 'client backend' 
				THEN 'Client Backend'
			END AS process_types,
			CASE 
				WHEN state IS NULL 
				THEN 'Background Process'
				ELSE state
			END AS status
			
FROM 		pg_stat_activity;


SELECT 		name,setting,unit,short_desc 
FROM  		pg_settings
WHERE 		name IN ('maintenance_work_mem',
			'work_mem','temp_buffers','max_connections');  




















