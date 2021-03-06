/****** Object:  StoredProcedure [dbo].[proc_MSS_AddCrawledPropertyCategoryWithDefaults]    Script Date: 5/15/2018 12:13:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddCrawledPropertyCategoryWithDefaults
@CategoryName         nvarchar(64) OUTPUT,
@DiscoverNewProperties bit OUTPUT,
@MapToContents        bit OUTPUT,
@FullTextQueriable     bit OUTPUT,
@Retrievable          bit OUTPUT,
@Propset uniqueidentifier
as
select @DiscoverNewProperties = 1
select @MapToContents = 1
select @FullTextQueriable = 0
select @Retrievable = 0
DECLARE @RetVal int                 select @RetVal = 0
DECLARE @CategoryNameId int
BEGIN TRANSACTION
       Update dbo.MSSSchemaHighLevelProps Set LastCategoryName = LastCategoryName + 1
       select @RetVal = @@ERROR
       if 0 <> @RetVal  BEGIN
                ROLLBACK TRANSACTION
                return @RetVal
       END
       select @CategoryNameId = LastCategoryName from MSSSchemaHighLevelProps
       select @CategoryName = 'Category ' + CAST(@CategoryNameId as nvarchar(64) )
       exec  @RetVal = proc_MSS_AddCrawledPropertyCategory @Propset, @DiscoverNewProperties, @MapToContents, @FullTextQueriable,  @Retrievable,  @CategoryName, ' ', ' '
       if 0 <> @RetVal  BEGIN
                ROLLBACK TRANSACTION
                return @RetVal
       END
COMMIT TRANSACTION

GO
