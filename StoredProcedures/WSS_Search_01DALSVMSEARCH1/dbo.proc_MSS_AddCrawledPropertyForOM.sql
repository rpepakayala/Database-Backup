/****** Object:  StoredProcedure [dbo].[proc_MSS_AddCrawledPropertyForOM]    Script Date: 5/15/2018 12:13:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddCrawledPropertyForOM
@Propset uniqueidentifier,
@PropertyName nvarchar (440), 
@PropertyNameIsEnum bit,
@VariantType int,
@CrawledPropertyId int OUTPUT
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
                                              IsMappedToContent)
                        Values( @Propset,  @PropertyName, @VariantType, @PropertyNameIsEnum, 
                                0 )
            Select @RetVal = @@ERROR 
            Select @CrawledPropertyId = @@IDENTITY                        
            if 0 <> @RetVal
            BEGIN
               RollBack Transaction
               return @RetVal                           
            END
            Update MSSCrawledPropCategory Set CrawledPropertyCount = CrawledPropertyCount + 1
                                          Where Propset = @Propset
            Select @RetVal = @@ERROR                                           
            if 0 <> @RetVal
            BEGIN
               RollBack Transaction
               return @RetVal                           
            END
            Update MSSSchemaHighLevelProps set LastCPAddsBenignModified = CURRENT_TIMESTAMP
            SELECT @RetVal = @@ERROR            
            if ( 0 != @RetVal )
            BEGIN
                RollBack Transaction
                return @RetVal  
            END
            Commit Transaction
        END
else
    SELECT @CrawledPropertyId = crawledPropertyId FROM MSSCrawledProperties WHERE Propset = @Propset 
                                                   AND PropertyName =  @PropertyName 
                                                   AND VariantType = @VariantType                    

GO
