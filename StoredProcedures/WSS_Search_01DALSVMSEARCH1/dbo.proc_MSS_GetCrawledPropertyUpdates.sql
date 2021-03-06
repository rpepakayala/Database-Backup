/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCrawledPropertyUpdates]    Script Date: 5/15/2018 12:13:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCrawledPropertyUpdates
@UpDate datetime
AS
    SELECT 
        Propset, 
        PropertyName,        
        PropertyNameIsEnum,        
        IsMappedToContent,
        IsSampleCacheFull,
        VariantType,
        CrawledPropertyId,        
        URI,
        LastModified
    FROM 
        dbo.MSSCrawledProperties 
    WHERE
        ( LastModified > @UpDate  )

GO
