SELECT
    deqs.execution_count AS [Count],
    deqs.last_execution_time AS [Time],
    dest.text AS [Query],
    deqs.total_elapsed_time / 100000 as total_elapsed_time,
    deqs.last_elapsed_time / 100000 as last_elapsed_time,
    deqs.max_elapsed_time / 100000 as max_elapsed_time,
    deqs.total_rows,
    deqs.last_rows,
    deqs.max_rows,
    deqs.total_logical_reads,
    deqs.last_logical_reads,
    deqs.max_logical_reads,
    deqs.total_dop,
    deqs.last_dop,
    deqs.max_dop,
    deqs.total_grant_kb,
    deqs.last_grant_kb,
    deqs.max_grant_kb,
    deqs.total_num_physical_reads,
    deqs.max_num_physical_reads,
    deqs.last_num_page_server_reads,
    deqs.total_columnstore_segment_reads,
    deqs.total_columnstore_segment_skips,
    deqs.last_columnstore_segment_reads,
    deqs.last_columnstore_segment_skips,
    deqs.max_columnstore_segment_reads,
    deqs.max_columnstore_segment_skips

FROM
    sys.dm_exec_query_stats AS deqs
CROSS APPLY
    sys.dm_exec_sql_text(deqs.sql_handle) AS dest
ORDER BY
    deqs.last_execution_time DESC
