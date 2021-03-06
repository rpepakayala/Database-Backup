/****** Object:  StoredProcedure [dbo].[proc_MSS_AddAndReturnCrawledProperty]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddAndReturnCrawledProperty
@Propset            uniqueidentifier,
@PropertyName       nvarchar (440), 
@PropertyNameIsEnum bit,
@VariantType        int,
@FriendlyName       nvarchar (64),
@ManagedType        int,
@crawledPropId     int OUTPUT,
@pid               int OUTPUT,
@crawledPropExists bit OUTPUT,
@managedPropExists bit OUTPUT,
@IsSampleCacheFull bit OUTPUT,
@IsMappedToContent bit OUTPUT,
@FullTextQueriable bit OUTPUT,
@Retrievable       bit OUTPUT,
@HasMultipleValues bit OUTPUT,
@MappingOrder      int OUTPUT
AS
select @crawledPropId = -1 -- temp change from -1
select @pid = -1  -- temp change from -1
DECLARE @RetVal int   SET @RetVal = 0
DECLARE @mappingExists bit Select @mappingExists = 0
 Select @crawledPropExists = 0
 Select @managedPropExists = 0
 Select @MappingOrder      = 100
 Select @IsSampleCacheFull = 0
 BEGIN TRANSACTION
--
-- look for crawled property and set values if we find it.
     SELECT @crawledPropExists = 1,
            @crawledPropId = crawledPropertyId, 
	    @IsMappedToContent = IsMappedToContent,
	    @IsSampleCacheFull = IsSampleCacheFull
       FROM dbo.MSSCrawledProperties 
       WHERE Propset = @Propset 
	     AND PropertyName =  @PropertyName 
	     AND VariantType = @VariantType
--
--  add a crawled property that we did not already have 
    if ( @crawledPropExists = 0 )
    BEGIN
        Insert into MSSCrawledProperties ( Propset, 
                                          PropertyName,
                                          VariantType, 
                                          PropertyNameIsEnum, 
                                          IsMappedToContent 
                                       )
                     Values( @Propset,  
                             @PropertyName, 
                             @VariantType, 
                             @PropertyNameIsEnum, 
                             @IsMappedToContent 
                               )
       Select @RetVal = @@ERROR
       Select @crawledPropId = @@IDENTITY
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
    END

--
--  When these flags are set, we automatically associate this crawled property
--  with a managed property.  We expect the managed property to be new (it's new for 
--  the crawler) but handle the case where it is already created.
    if  ( 0 <> @FullTextQueriable OR 
          0 <> @Retrievable )
    BEGIN
        SELECT @managedPropExists = 1,
               @pid = pid, 
               @FullTextQueriable = FullTextQueriable,
               @Retrievable = Retrievable,
               @HasMultipleValues = HasMultipleValues
         FROM dbo.MSSManagedProperties
         WHERE @FriendlyName = FriendlyName

        if ( @managedPropExists = 0 )
        BEGIN
            Update dbo.MSSSchemaHighLevelProps Set PID = PID+ 1

            select @pid = pid from MSSSchemaHighLevelProps

            Insert into dbo.MSSManagedProperties                
                (   [PID], 
                    [FriendlyName], 
                    [ManagedType], 
                    [FullTextQueriable], 
                    [Retrievable], 
                    [Hidden],
                    [HasMultipleValues] )
                VALUES(@pid, 
                        @FriendlyName, 
                        @ManagedType, 
                        @FullTextQueriable,
                        @Retrievable,
                        0,
                        @HasMultipleValues )
            Select @RetVal = @@ERROR
            if 0 <> @RetVal
            BEGIN
            RollBack Transaction
            return @RetVal                           
            END
        END
--
-- Add the mapping between crawled prop and managed prop.  It's OK if the mapping
-- is already there.
        SELECT @mappingExists = 1,
	       @mappingOrder = mappingOrder 
          FROM dbo.MSSSchemaPropertyMappings
          WHERE @pid = pid AND @crawledPropId = CrawledPropertyId 

        if ( @mappingExists = 0 )
        BEGIN
	        exec @RetVal = proc_MSS_AddPropertyMappingsFromIds @pid,  @crawledPropId
	        if 0 <> @RetVal
	        BEGIN
	                RollBack Transaction
	                return @RetVal                           
	        END
       END
   END 

commit transaction

return @RetVal


GO
