SELECT
        *
FROM
        INFORMATION_SCHEMA.COLUMNS
WHERE
        table_schema = 'public'
ORDER BY
        table_name, ordinal_position
