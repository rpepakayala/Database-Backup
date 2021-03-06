/****** Object:  StoredProcedure [dbo].[proc_MSS_AddPropertyMapping]    Script Date: 5/15/2018 12:11:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddPropertyMapping
@FriendlyName nvarchar(64),
@CrawledPropset uniqueIdentifier,
@CrawledPropertyName nvarchar(440),
@CrawledVariantType int
AS

DECLARE @RetVal int  SET @RetVal = 0
DECLARE @PID    int  SET @PID = 0
DECLARE @CrawledPropertyId int Set @CrawledPropertyId = 0

BEGIN TRANSACTION
    select @PID=PID from MSSManagedProperties where @FriendlyName = FriendlyName

    if @PID = 0
    BEGIN
        select @FriendlyName, @PID
        ROLLBACK TRANSACTION
        return 11
    END

    Declare @variantTypeAsVector int
    Declare @variantTypeMasked   int
    Declare @vector              int 
    select @vector = 0x1000
    select @variantTypeAsVector = @CrawledVariantType | @vector
    select @variantTypeMasked   = @CrawledVariantType & (~@vector)

    select @CrawledPropertyId=CrawledPropertyId from MSSCrawledProperties 
        where @CrawledPropset = Propset
          and @CrawledPropertyName = PropertyName
          and (@variantTypeAsVector = VariantType or @variantTypeMasked = VariantType)

    if @CrawledPropertyId = 0
    BEGIN
       select @CrawledPropset, @CrawledPropertyName, @CrawledPropertyId
       ROLLBACK TRANSACTION
       return 13
    END

    exec proc_MSS_AddPropertyMappingsFromIds @PID, @CrawledPropertyId

COMMIT TRANSACTION

GO
