/****** Object:  StoredProcedure [dbo].[sp_RemoveMinusTwos]    Script Date: 5/15/2018 12:13:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE sp_RemoveMinusTwos AS DECLARE @TableName varchar(255)

DECLARE TableCursor CURSOR FOR
SELECT table_name FROM information_schema.tables
WHERE table_type = 'base table'

OPEN TableCursor

FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
BEGIN
  SELECT @tablename = RTRIM(@tablename)

  EXEC ('Delete From ' + @tablename + ' WHERE StoreID = -2')

  FETCH NEXT FROM TableCursor INTO @TableName
END

CLOSE TableCursor

DEALLOCATE TableCursor

GO
