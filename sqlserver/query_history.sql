SELECT
    deqs.execution_count AS [Count],
    deqs.last_execution_time AS [Time],
    dest.text AS [Query]
FROM
    sys.dm_exec_query_stats AS deqs
CROSS APPLY
    sys.dm_exec_sql_text(deqs.sql_handle) AS dest
ORDER BY
    deqs.last_execution_time DESC
