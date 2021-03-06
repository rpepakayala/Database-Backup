/****** Object:  StoredProcedure [dbo].[proc_MSS_SetCrawledPropertyMapToContent]    Script Date: 5/15/2018 12:11:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_SetCrawledPropertyMapToContent
@crawledPropId int,
@IsMappedToContent bit
AS

DECLARE @RetVal int  SET @RetVal = 0

Update dbo.MSSCrawledProperties set IsMappedToContent = @IsMappedToContent,
                                    LastModified = CURRENT_TIMESTAMP
        where CrawledPropertyId = @crawledPropId
SELECT @RetVal = @@ERROR
if 0 <> @RetVal
BEGIN
        RollBack Transaction
        return @RetVal                           
END

Update MSSSchemaHighLevelProps set LastCPAddsBenignModified = CURRENT_TIMESTAMP
if ( 0 != @RetVal )
    SELECT @RetVal = @@ERROR

return @RetVal

GO
