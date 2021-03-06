/****** Object:  StoredProcedure [dbo].[proc_MSS_AddCrawledProperty]    Script Date: 5/15/2018 12:13:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddCrawledProperty
@Propset uniqueidentifier,
@PropertyName nvarchar (440), 
@PropertyNameIsEnum bit,
@IsMappedToContent bit,
@VariantType int,
@URI nvarchar (2048)
AS
DECLARE @RetVal int   SET @RetVal = 0
Declare @variantTypeAsVector int
Declare @variantTypeMasked   int
Declare @vector              int 
select @vector = 0x1000
select @variantTypeAsVector = @VariantType | @vector
select @variantTypeMasked   = @VariantType & (~@vector)
IF NOT EXISTS (SELECT * FROM MSSCrawledProperties WHERE Propset = @Propset 
                                                   AND PropertyName =  @PropertyName 
                                                   AND ( VariantType = @variantTypeAsVector OR VariantType = @variantTypeMasked )
                                                   )
        BEGIN
            BEGIN TRANSACTION
            Insert into MSSCrawledProperties ( Propset, 
                                              PropertyName,
                                              VariantType, 
                                              PropertyNameIsEnum, 
                                              IsMappedToContent, 
                                              URI)
                        Values( @Propset,  @PropertyName, @VariantType, @PropertyNameIsEnum, 
                               @IsMappedToContent, @URI)
            Select @RetVal = @@ERROR             
            if 0 <> @RetVal
            BEGIN
               RollBack Transaction
               return @RetVal                           
            END
            Update MSSCrawledPropCategory Set CrawledPropertyCount = CrawledPropertyCount + 1
                                          Where Propset = @Propset
            if 0 <> @RetVal
            BEGIN
               RollBack Transaction
               return @RetVal                           
            END
            Commit Transaction
        END
        return @RetVal

GO
