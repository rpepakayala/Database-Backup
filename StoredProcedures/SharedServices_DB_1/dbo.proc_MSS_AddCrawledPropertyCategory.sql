/****** Object:  StoredProcedure [dbo].[proc_MSS_AddCrawledPropertyCategory]    Script Date: 5/15/2018 12:11:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddCrawledPropertyCategory
@Propset uniqueidentifier,
@DiscoverNewProperties bit,
@MapToContents bit,
@FullTextQueriable bit,
@Retrievable bit,
@CategoryName nvarchar (64), 
@SubCategoryName nvarchar(64),
@URINamespace nvarchar (256)
AS

DECLARE @RetVal int  SET @RetVal = 0

if not exists (select * from MSSCrawledPropCategory where propset = @Propset )
BEGIN
 Insert into MSSCrawledPropCategory ( Propset, 
                            CategoryName,
                            SubCategoryName,
                            DiscoverNewProperties, 
                            MapToContents, 
                            FullTextQueriable, 
                            Retrievable, 
                            URINamespace )
                    Values( @Propset,  @CategoryName, @SubCategoryName, @DiscoverNewProperties, @MapToContents, 
                            @FullTextQueriable, @Retrievable, @URINamespace)
END

SELECT @RetVal = @@ERROR

Update MSSSchemaHighLevelProps set LastCatChange = CURRENT_TIMESTAMP
if ( 0 != @RetVal )
    SELECT @RetVal = @@ERROR

return @RetVal

GO
