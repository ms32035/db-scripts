SELECT
    t.name AS TableName,
    SUM(ps.reserved_page_count) * 8.0 / 1024 AS SizeInMB
FROM
    sys.dm_db_partition_stats ps
JOIN
    sys.objects t ON ps.object_id = t.object_id
WHERE
    t.type_desc = 'USER_TABLE'
GROUP BY
    t.name
ORDER BY
    SizeInMB DESC;
