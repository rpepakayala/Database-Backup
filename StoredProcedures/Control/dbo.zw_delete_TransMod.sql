/****** Object:  StoredProcedure [dbo].[zw_delete_TransMod]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_TransMod ( 
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
@TransHeaderID int  = NULL , 
@TransHeaderClassTypeID int  = NULL , 
@GoodsItemID int  = NULL , 
@GoodsItemClassTypeID int  = NULL , 
@GoodsItemCode [nvarchar](35)   = NULL , 
@PricingLevel float  = NULL , 
@PricingLevelOverridden bit  = NULL , 
@DiscountLevel float  = NULL , 
@DiscountLevelOverridden bit  = NULL , 
@QuantityApplied float  = NULL , 
@SortOrder int  = NULL , 
@FormattedText [nvarchar](MAX)   = NULL , 
@ListID int  = NULL , 
@ListText [nvarchar](MAX)   = NULL , 
@Units int  = NULL , 
@UnitsText [nvarchar](8)   = NULL , 
@ValueType int  = NULL , 
@ValueAsString [nvarchar](MAX)   = NULL , 
@ValueAsFloat float  = NULL , 
@ValueAsInteger int  = NULL , 
@ValueAsDateTime datetime  = NULL , 
@ValueAsBinary image  = NULL , 
@ValueAsBlob image  = NULL , 
@ModifierPrice money  = NULL , 
@ModifierCalcPrice money  = NULL , 
@ModifierOverriddenPrice money  = NULL , 
@ModifierIsOverridden bit  = NULL , 
@MeAndSonsModifierPrice money  = NULL , 
@InternalNotes [nvarchar](MAX)   = NULL , 
@PartStr [nvarchar](MAX)   = NULL , 
@ValueOverridden bit  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [TransMod] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
