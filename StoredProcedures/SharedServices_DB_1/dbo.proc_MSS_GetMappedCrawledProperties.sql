/****** Object:  StoredProcedure [dbo].[proc_MSS_GetMappedCrawledProperties]    Script Date: 5/15/2018 12:11:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetMappedCrawledProperties
@pid int,
@resultsCount int
AS
    SET ROWCOUNT @resultsCount
    SELECT
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
    INNER JOIN dbo.MSSSchemaPropertyMappings as M
        on M.crawledPropertyId = CP.crawledPropertyId
    INNER JOIN dbo.MSSCrawledPropCategory as CAT 
        on CP.Propset = CAT.Propset
    WHERE
        M.pid = @pid
    ORDER BY M.MappingOrder
    SET ROWCOUNT 0


GO
