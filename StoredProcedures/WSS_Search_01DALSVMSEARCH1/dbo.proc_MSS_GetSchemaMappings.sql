/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSchemaMappings]    Script Date: 5/15/2018 12:13:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetSchemaMappings
AS
DECLARE @RetVal int  SET @RetVal = 0
select pid, mappingorder, crawledPropertyid
from MSSSchemaPropertyMappings
return @RetVal

GO
