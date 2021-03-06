/****** Object:  StoredProcedure [dbo].[proc_MSS_SetCrawledPropertyIsSampleCacheFull]    Script Date: 5/15/2018 12:13:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_SetCrawledPropertyIsSampleCacheFull
@crawledPropId int,
@IsSampleCacheFull bit,
@UseDateTrigger bit
AS
DECLARE @RetVal int  SET @RetVal = 0
if ( @UseDateTrigger = 1 )
BEGIN
    Update dbo.MSSCrawledProperties set IsSampleCacheFull = @IsSampleCacheFull,
                                    LastModified = CURRENT_TIMESTAMP
        where CrawledPropertyId = @crawledPropId
    SELECT @RetVal = @@ERROR
    if ( 0 != @RetVal )
        return @RetVal
    Update MSSSchemaHighLevelProps set LastCPAddsBenignModified = CURRENT_TIMESTAMP
    if ( 0 != @RetVal )
        SELECT @RetVal = @@ERROR
END
else
BEGIN
    Update dbo.MSSCrawledProperties set IsSampleCacheFull = @IsSampleCacheFull
        where CrawledPropertyId = @crawledPropId    
END    
return @RetVal

GO
