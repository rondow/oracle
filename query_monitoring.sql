SELECT spm.status
     , COUNT (sid) AS count_of_parallel_slaves
     , MIN (spm.first_change_time) AS first_change_time
     , MAX (spm.last_change_time) AS last_change_time
     , spm.plan_line_id
     , spm.plan_operation
     , spm.plan_options
     , sp.object_node
     , sp.object_owner
     , sp.object_name
     , sp.object_alias
     , sp.object_type
     , sp.optimizer
     , TO_CHAR (MIN (sp.CARDINALITY), '999,999,999,999,990') AS expected_rows
     , TO_CHAR (SUM (spm.output_rows), '999,999,999,999,990') AS actual_rows
     , TO_CHAR (SUM(spm.output_rows)/ NULLIF (((MAX (spm.last_change_time)-MIN(spm.first_change_time))*24*60*60), 0), '999,999,999,999,990') AS rows_per_second
     , NUMTODSINTERVAL (MAX (spm.last_change_time)-MIN(spm.first_change_time), 'DAY') AS elapsed_time
     , NUMTODSINTERVAL ((MIN (sp.CARDINALITY) - SUM (spm.output_rows)) 
                       / NULLIF (SUM(spm.output_rows)
                               / NULLIF ((MAX (spm.last_change_time)-MIN(spm.first_change_time)), 0)
                               , 0
                                )
                      , 'DAY'
                       ) AS estimated_time_remaining
     , sp.other_tag
     , sp.partition_start
     , sp.partition_stop
     , sp.distribution
     , sp.access_predicates
FROM gv$sql_plan_monitor spm
   INNER JOIN
      gv$sql_plan sp
   ON (    spm.inst_id = sp.inst_id
       AND spm.sql_id = sp.sql_id
       AND spm.plan_line_id = sp.ID
       AND spm.sql_child_address = sp.child_address)
WHERE spm.sql_id = 'b70v9nx0j4rw1' -- Change as needed
   AND spm.status = 'EXECUTING'
GROUP BY spm.status
     , spm.plan_line_id
     , spm.plan_operation
     , spm.plan_options
     , sp.object_node
     , sp.object_owner
     , sp.object_name
     , sp.object_alias
     , sp.object_type
     , sp.optimizer
     , sp.other_tag
     , sp.partition_start
     , sp.partition_stop
     , sp.distribution
     , sp.access_predicates
ORDER BY spm.plan_line_id ASC;
