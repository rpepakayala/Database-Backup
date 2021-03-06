/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSummaryLogData]    Script Date: 5/15/2018 12:11:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_GetSummaryLogData
@CatalogID int = null,
@ContentSourceID int = null,
@Successes int OUTPUT,
@Errors int OUTPUT,
@Warnings int OUTPUT

AS

declare @UrlWarnings int
declare @DeletedUrlWarnings int
declare @UrlErrors int
declare @DeletedUrlErrors int

BEGIN

    SELECT @Successes = count(*) from MSSCrawlUrl WITH (NOLOCK)
    WHERE ProjectID = @CatalogID 
    AND ContentSourceID = @ContentSourceID
    AND CommitCrawlID <> 0
    AND ErrorLevel = 0

    SELECT @UrlWarnings = count(*) from MSSCrawlUrl WITH (NOLOCK)
    WHERE ProjectID = @CatalogID 
    AND ContentSourceID = @ContentSourceID
	AND CommitCrawlID <> 0
    AND ErrorLevel = 1

    SELECT @DeletedUrlWarnings = count(*) from MSSCrawlDeletedUrl WITH (NOLOCK)
    WHERE ProjectID = @CatalogID 
    AND ContentSourceID = @ContentSourceID
    AND ErrorLevel = 1

    set @Warnings = @UrlWarnings + @DeletedUrlWarnings

    SELECT @UrlErrors = count(*) from MSSCrawlUrl WITH (NOLOCK)
    WHERE ProjectID = @CatalogID 
    AND ContentSourceID = @ContentSourceID
	AND CommitCrawlID <> 0
    AND ErrorLevel = 2

    SELECT @DeletedUrlErrors = count(*) from MSSCrawlDeletedUrl WITH (NOLOCK)
    WHERE ProjectID = @CatalogID 
    AND ContentSourceID = @ContentSourceID
    AND ErrorLevel = 2

    set @Errors = @UrlErrors + @DeletedUrlErrors

END

GO
