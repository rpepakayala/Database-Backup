/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCrawledPropertiesForOM]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCrawledPropertiesForOM
@CategoryName nvarchar(64),
@Filter nvarchar(440),
@MaxProps int,
@LastPropset uniqueIdentifier,
@LastPropertyName nvarchar(440),
@ForwardDirection bit
AS
        Set ROWCOUNT @MaxProps
        if @ForwardDirection = 1
	BEGIN 
        if @CategoryName = '%%'
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
                CP.PropertyName Like(@Filter)
                AND ( CP.PropertyName > @LastPropertyName
	                 or ( CP.PropertyName = @LastPropertyName
	                      and CP.Propset > @LastPropset ) )
            ORDER BY CP.PropertyName, CP.Propset
        ELSE
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
                AND CP.PropertyName Like(@Filter)
                AND ( CP.PropertyName > @LastPropertyName
	                 or ( CP.PropertyName = @LastPropertyName
	                      and CP.Propset > @LastPropset ) )
            ORDER BY CP.PropertyName, CP.Propset
	END
	else
	BEGIN
        if @CategoryName = '%%'
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
                CP.PropertyName Like(@Filter)
                AND ( CP.PropertyName < @LastPropertyName
	                 or ( CP.PropertyName = @LastPropertyName
	                      and CP.Propset < @LastPropset ) )
            ORDER BY CP.PropertyName DESC, CP.Propset DESC
        ELSE
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
                AND CP.PropertyName Like(@Filter)
                AND ( CP.PropertyName < @LastPropertyName
	                 or ( CP.PropertyName = @LastPropertyName
	                      and CP.Propset < @LastPropset ) )
            ORDER BY CP.PropertyName DESC, CP.Propset DESC
	END

        Set ROWCOUNT 0


GO
