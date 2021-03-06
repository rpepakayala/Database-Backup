/****** Object:  StoredProcedure [dbo].[proc_MSS_SetCrawledCategoryPropertiesAllOM]    Script Date: 5/15/2018 12:13:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_SetCrawledCategoryPropertiesAllOM
@Name nvarchar(64),
@NewName nvarchar(64),
@DiscoverNewProperties bit,
@MapToContents bit,
@AutoCreateManagedProperties bit
AS
DECLARE @RetVal int  SET @RetVal = 0
IF (@NewName != @Name) AND (EXISTS (SELECT * FROM MSSCrawledPropCategory WHERE CategoryName = @NewName))
    return 1
Update MSSCrawledPropCategory Set CategoryName = @NewName,
                                  DiscoverNewProperties = @DiscoverNewProperties,
                                  MapToContents = @MapToContents,
                                  FullTextQueriable = @AutoCreateManagedProperties,
                                  Retrievable = @AutoCreateManagedProperties
            where CategoryName = @Name  
SELECT @RetVal = @@ERROR
Update MSSSchemaHighLevelProps set LastCatChange = CURRENT_TIMESTAMP
if ( 0 != @RetVal )
    SELECT @RetVal = @@ERROR
return @RetVal

GO
