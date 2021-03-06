/****** Object:  StoredProcedure [dbo].[proc_MSS_AddCrawledPropertyCategoryWithRef]    Script Date: 5/15/2018 12:13:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddCrawledPropertyCategoryWithRef
@Propset uniqueidentifier,
@DiscoverNewProperties bit,
@MapToContents bit,
@FullTextQueriable bit,
@Retrievable bit,
@ExistingPropset uniqueidentifier,
@SubCategoryName nvarchar(64),
@URINamespace nvarchar (256)
AS
DECLARE @CategoryName nvarchar (64)
if EXISTS (SELECT * FROM MSSCrawledPropCategory WHERE Propset = @ExistingPropset)
   select @CategoryName = CategoryName from MSSCrawledPropCategory WHERE Propset = @ExistingPropset
else
   select @CategoryName = N'Basic'
DECLARE @RetVal int  SET @RetVal = 0
exec @RetVal = proc_MSS_AddCrawledPropertyCategory @Propset, @DiscoverNewProperties, @MapToContents, @FullTextQueriable, @Retrievable, @CategoryName, @SubCategoryName, @URINamespace   
return @RetVal

GO
