/****** Object:  StoredProcedure [dbo].[sp_TestStringCreation]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE sp_TestStringCreation

AS

DECLARE @sql varchar(1000)
DECLARE @string varchar(100)
SELECT @string = '1786,1787,1788,1790,1916'

SELECT @sql = 'select ordHSubStatus,OrdHStatus,* '
SELECT @sql = @sql + 'from orderhdr '
SELECT @sql = @sql + 'where ordHiD IN (' + @string + ') '
SELECT @sql = @sql + 'order by ordHID desc '

EXEC sp_executesql @sql
GO
