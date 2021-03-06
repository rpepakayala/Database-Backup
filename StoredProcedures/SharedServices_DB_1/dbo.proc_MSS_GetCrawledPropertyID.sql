/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCrawledPropertyID]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCrawledPropertyID
@Propset uniqueidentifier, 
@PropertyName nvarchar(440),        
@VariantType int
AS
	    SELECT Top 1
           CP.CrawledPropertyId as 'PropertyID'
	    FROM 
           dbo.MSSCrawledProperties as CP
	    WHERE
	       CP.Propset          = @Propset
           AND CP.PropertyName = @PropertyName
           AND CP.VariantType  = @VariantType

GO
