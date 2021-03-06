/****** Object:  StoredProcedure [dbo].[zw_delete_TransVariation]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_TransVariation ( 
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
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
