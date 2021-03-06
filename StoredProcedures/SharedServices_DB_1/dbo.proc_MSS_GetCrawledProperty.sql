/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCrawledProperty]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCrawledProperty
@Propset uniqueidentifier,
@PropertyName nvarchar(440),
@VariantType int
AS
    SELECT Top 1
        CAT.CategoryName,
        CP.Propset, 
        CP.PropertyName,        
        CP.PropertyNameIsEnum,        
        CP.IsMappedToContent,
        CP.IsSampleCacheFull,
        CP.VariantType,
        CP.CrawledPropertyId        
    FROM 
        dbo.MSSCrawledProperties as CP
    INNER JOIN dbo.MSSCrawledPropCategory as CAT 
        on CP.Propset = CAT.Propset
    WHERE
        CP.Propset = @Propset
        and CP.PropertyName = @PropertyName 
        and CP.VariantType  = @VariantType

GO
