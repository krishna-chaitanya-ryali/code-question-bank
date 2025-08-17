SELECT constraint_name, constraint_type, status
FROM user_constraints
WHERE table_name = UPPER('YOUR_TABLE');

SELECT a.constraint_name,
       a.table_name   AS child_table,
       a.column_name  AS child_column,
       c.table_name   AS parent_table,
       c.column_name  AS parent_column
FROM user_cons_columns a
JOIN user_constraints b
     ON a.constraint_name = b.constraint_name
JOIN user_cons_columns c
     ON b.r_constraint_name = c.constraint_name
WHERE b.constraint_type = 'R'
  AND c.table_name = UPPER('YOUR_TABLE');

-- Disable foreign key constraint
ALTER TABLE child_table_name DISABLE CONSTRAINT fk_name;

-- Delete parent data
DELETE FROM your_table;

-- Reload from backup
INSERT INTO your_table
SELECT * FROM your_table_backup;

-- Re-enable the constraint
ALTER TABLE child_table_name ENABLE CONSTRAINT fk_name;


SELECT 'ALTER TABLE ' || table_name || ' DISABLE CONSTRAINT ' || constraint_name || ';' AS disable_sql,
       'ALTER TABLE ' || table_name || ' ENABLE CONSTRAINT '  || constraint_name || ';' AS enable_sql
FROM user_constraints
WHERE r_constraint_name IN (
    SELECT constraint_name
    FROM user_constraints
    WHERE table_name = UPPER('YOUR_TABLE')
      AND constraint_type = 'P'
);
