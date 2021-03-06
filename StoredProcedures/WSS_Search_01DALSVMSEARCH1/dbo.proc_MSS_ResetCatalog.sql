/****** Object:  StoredProcedure [dbo].[proc_MSS_ResetCatalog]    Script Date: 5/15/2018 12:13:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_ResetCatalog
    @nCatalogId SMALLINT
AS
begin
    SET NOCOUNT ON
    truncate table MSSDocProps 
    truncate table MSSDuplicateHashes
    truncate table MSSDefinitions
    truncate table MSSDocSdids 
    truncate table MSSSessionDocProps
    truncate table MSSSessionDocPropsAlt
    truncate table MSSCrawlChangedSourceDocs
    truncate table MSSCrawlChangedTargetDocs
    truncate table MSSAnchorPendingChangeLog
    truncate table MSSAnchorChangeLog
    truncate table MSSSessionDefinitions
    truncate table MSSSessionDefinitionsAlt
    truncate table MSSSessionDocSdids
    truncate table MSSSessionDocSdidsAlt
    truncate table MSSSessionDocSignatures
    truncate table MSSSessionDocSignaturesAlt
    truncate table MSSSessionDuplicateHashes
    truncate table MSSSessionDuplicateHashesAlt
    truncate table MSSSessionExistingDocs
    truncate table MSSSessionExistingDocsAlt
end

GO
