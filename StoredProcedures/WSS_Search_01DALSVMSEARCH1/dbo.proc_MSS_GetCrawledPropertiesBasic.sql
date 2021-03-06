/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCrawledPropertiesBasic]    Script Date: 5/15/2018 12:13:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCrawledPropertiesBasic
@Propset uniqueidentifier,
@PropertyName nvarchar(440)
AS
    SELECT 
        Propset, 
        PropertyName,        
        PropertyNameIsEnum,        
        IsMappedToContent,
        IsSampleCacheFull,
        VariantType,
        CrawledPropertyId,        
        URI
    FROM 
        dbo.MSSCrawledProperties 
    WHERE
        ( Propset > @Propset  ) or
        ( @Propset = Propset and PropertyName > @PropertyName )

GO
