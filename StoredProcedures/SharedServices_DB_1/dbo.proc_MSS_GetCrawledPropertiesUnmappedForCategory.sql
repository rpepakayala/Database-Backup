/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCrawledPropertiesUnmappedForCategory]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCrawledPropertiesUnmappedForCategory
@CategoryName nvarchar(64)
AS
	    SELECT 
	        C.CategoryName,
	        CP.Propset, 
	        CP.PropertyName,        
	        CP.PropertyNameIsEnum,        
	        CP.IsMappedToContent,
	        CP.IsSampleCacheFull,
	        CP.VariantType,
	        CP.CrawledPropertyId        
	    FROM 
	        dbo.MSSCrawledProperties as CP
        INNER JOIN dbo.MSSCrawledPropCategory as C
            on CP.Propset = C.Propset
	    WHERE
            C.CategoryName = @CategoryName 
            AND CP.IsMappedToContent = 0 
            AND NOT EXISTS 
              ( Select * from MSSSchemaPropertyMappings 
                Where CrawledPropertyId = CP.CrawledPropertyId ) 
        ORDER BY CP.PropertyName, CP.Propset

GO
