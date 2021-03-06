/****** Object:  StoredProcedure [dbo].[zw_delete_PartInventoryConversion]    Script Date: 5/15/2018 12:09:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_PartInventoryConversion ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PartID int  = NULL , 
@IsAutomatic bit  = NULL , 
@IsDefault bit  = NULL , 
@ConversionFormula [nvarchar](MAX)   = NULL , 
@ConsumptionFormula [nvarchar](MAX)   = NULL , 
@InclusionFormula [nvarchar](MAX)   = NULL , 
@UnitID int  = NULL , 
@UnitType int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PartInventoryConversion] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
