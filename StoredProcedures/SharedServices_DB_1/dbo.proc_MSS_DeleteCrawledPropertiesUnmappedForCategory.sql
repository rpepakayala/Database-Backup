/****** Object:  StoredProcedure [dbo].[proc_MSS_DeleteCrawledPropertiesUnmappedForCategory]    Script Date: 5/15/2018 12:11:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_DeleteCrawledPropertiesUnmappedForCategory
@CategoryName nvarchar(64)
AS
BEGIN TRANSACTION
        Declare @RetVal int
	    Delete dbo.MSSCrawledProperties 
	           Where CrawledPropertyId in
	           ( Select CP.crawledPropertyId 
	              From MSSCrawledProperties as CP
                  INNER JOIN dbo.MSSCrawledPropCategory as C
                     on CP.Propset = C.Propset
	              WHERE C.CategoryName = @CategoryName 
                    AND CP.IsMappedToContent = 0
                    AND NOT EXISTS 
                      ( Select * from MSSSchemaPropertyMappings 
                        Where CrawledPropertyId = CP.CrawledPropertyId ) 
               )
    Select @RetVal = @@ERROR 
    if 0 <> @RetVal
    BEGIN
       RollBack Transaction
       return @RetVal                           
    END

    update msscrawledPropCategory set crawledPropertyCount = 
         ( select count(*) from msscrawledProperties where propset = msscrawledPropCategory.propset )
    Select @RetVal = @@ERROR 
    if 0 <> @RetVal
    BEGIN
       RollBack Transaction
       return @RetVal                           
    END

COMMIT TRANSACTION               

GO
