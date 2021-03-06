/****** Object:  StoredProcedure [dbo].[proc_MSS_SetCrawledPropertyLastModified]    Script Date: 5/15/2018 12:11:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_SetCrawledPropertyLastModified
@crawledPropId int
AS
DECLARE @RetVal int  SET @RetVal = 0
DECLARE @DateNow datetime Select @DateNow = CURRENT_TIMESTAMP

Update dbo.MSSCrawledProperties set LastModified = @DateNow
            where CrawledPropertyId = @crawledPropId
SELECT @RetVal = @@ERROR

Update MSSSchemaHighLevelProps set LastCPAddsBenignModified = @DateNow
if ( 0 != @RetVal )
    SELECT @RetVal = @@ERROR

return @RetVal

GO
