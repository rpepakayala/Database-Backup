/****** Object:  StoredProcedure [dbo].[zw_upsert_TransVariation]    Script Date: 5/15/2018 12:09:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_TransVariation ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@TransactionType int  = NULL , 
@ParentID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@VariationName [nvarchar](50)   = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@SortIndex int  = NULL , 
@CreatedDate datetime  = NULL , 
@PricingLevel float  = NULL , 
@PricingLevelOverridden bit  = NULL , 
@DiscountLevel float  = NULL , 
@DiscountLevelOverridden bit  = NULL , 
@HTMLShortFormat [nvarchar](MAX)   = NULL , 
@HTMLLongFormat [nvarchar](MAX)   = NULL , 
@BasePrice [decimal](18,4)  = NULL , 
@DiscountPrice [decimal](18,4)  = NULL , 
@ModifierPrice [decimal](18,4)  = NULL , 
@RawSubTotalPrice [decimal](18,4)  = NULL , 
@RoundingPrice [decimal](18,4)  = NULL , 
@SubTotalPrice [decimal](18,4)  = NULL , 
@TaxesPrice [decimal](18,4)  = NULL , 
@TotalPrice [decimal](18,4)  = NULL , 
@SonsBasePrice [decimal](18,4)  = NULL , 
@SonsDiscountPrice [decimal](18,4)  = NULL , 
@SonsModifierPrice [decimal](18,4)  = NULL , 
@SonsRawSubTotalPrice [decimal](18,4)  = NULL , 
@SonsRoundingPrice [decimal](18,4)  = NULL , 
@SonsSubTotalPrice [decimal](18,4)  = NULL , 
@SonsTaxesPrice [decimal](18,4)  = NULL , 
@SonsTotalPrice [decimal](18,4)  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [TransVariation] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[TransactionType] = @TransactionType, 
		[ParentID] = @ParentID, 
		[ParentClassTypeID] = @ParentClassTypeID, 
		[VariationName] = @VariationName, 
		[Notes] = @Notes, 
		[SortIndex] = @SortIndex, 
		[CreatedDate] = @CreatedDate, 
		[PricingLevel] = @PricingLevel, 
		[PricingLevelOverridden] = @PricingLevelOverridden, 
		[DiscountLevel] = @DiscountLevel, 
		[DiscountLevelOverridden] = @DiscountLevelOverridden, 
		[HTMLShortFormat] = @HTMLShortFormat, 
		[HTMLLongFormat] = @HTMLLongFormat, 
		[BasePrice] = @BasePrice, 
		[DiscountPrice] = @DiscountPrice, 
		[ModifierPrice] = @ModifierPrice, 
		[RawSubTotalPrice] = @RawSubTotalPrice, 
		[RoundingPrice] = @RoundingPrice, 
		[SubTotalPrice] = @SubTotalPrice, 
		[TaxesPrice] = @TaxesPrice, 
		[TotalPrice] = @TotalPrice, 
		[SonsBasePrice] = @SonsBasePrice, 
		[SonsDiscountPrice] = @SonsDiscountPrice, 
		[SonsModifierPrice] = @SonsModifierPrice, 
		[SonsRawSubTotalPrice] = @SonsRawSubTotalPrice, 
		[SonsRoundingPrice] = @SonsRoundingPrice, 
		[SonsSubTotalPrice] = @SonsSubTotalPrice, 
		[SonsTaxesPrice] = @SonsTaxesPrice, 
		[SonsTotalPrice] = @SonsTotalPrice, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [TransVariation]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [TransactionType], [ParentID], [ParentClassTypeID], [VariationName], [Notes], [SortIndex], [CreatedDate], [PricingLevel], [PricingLevelOverridden], [DiscountLevel], [DiscountLevelOverridden], [HTMLShortFormat], [HTMLLongFormat], [BasePrice], [DiscountPrice], [ModifierPrice], [RawSubTotalPrice], [RoundingPrice], [SubTotalPrice], [TaxesPrice], [TotalPrice], [SonsBasePrice], [SonsDiscountPrice], [SonsModifierPrice], [SonsRawSubTotalPrice], [SonsRoundingPrice], [SonsSubTotalPrice], [SonsTaxesPrice], [SonsTotalPrice], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @TransactionType, @ParentID, @ParentClassTypeID, @VariationName, @Notes, @SortIndex, @CreatedDate, @PricingLevel, @PricingLevelOverridden, @DiscountLevel, @DiscountLevelOverridden, @HTMLShortFormat, @HTMLLongFormat, @BasePrice, @DiscountPrice, @ModifierPrice, @RawSubTotalPrice, @RoundingPrice, @SubTotalPrice, @TaxesPrice, @TotalPrice, @SonsBasePrice, @SonsDiscountPrice, @SonsModifierPrice, @SonsRawSubTotalPrice, @SonsRoundingPrice, @SonsSubTotalPrice, @SonsTaxesPrice, @SonsTotalPrice, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
