/****** Object:  StoredProcedure [dbo].[usp_SSIS_TruncateStagingTables]    Script Date: 5/15/2018 12:09:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
Create PROC [dbo].[usp_SSIS_TruncateStagingTables]
as
DECLARE temp_cursor Cursor 
FOR 
SELECT '['+s.name+'].['+t.name+']'
FROM sys.tables T
JOIN sys.schemas S ON t.schema_id = s.schema_id  WHERE 
type='U' AND s.name='dbo'
ORDER BY 1
OPEN  temp_cursor
DECLARE @dbname AS VARCHAR(200)
DECLARE @str_sql AS VARCHAR(2000)
Fetch NEXT FROM temp_cursor INTO @dbname
While (@@FETCH_STATUS <> -1)
BEGIN
	SET @str_sql = 'Truncate Table '+@dbname
	PRINT @str_sql
	EXEC (@str_sql)
	Fetch NEXT FROM temp_cursor INTO @dbname
END
CLOSE temp_cursor
DEALLOCATE temp_cursor
GO
