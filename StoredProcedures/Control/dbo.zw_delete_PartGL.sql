/****** Object:  StoredProcedure [dbo].[zw_delete_PartGL]    Script Date: 5/15/2018 12:09:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_PartGL ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate smalldatetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@EntryDateTime smalldatetime  = NULL , 
@Cost [numeric](18,4)  = NULL , 
@UnitCost [numeric](18,4)  = NULL , 
@GroupID int  = NULL , 
@GLAccountID int  = NULL , 
@GLAccountClassTypeID int  = NULL , 
@CustomerID int  = NULL , 
@CustomerClassTypeID int  = NULL , 
@VendorID int  = NULL , 
@VendorClassTypeID int  = NULL , 
@PartID int  = NULL , 
@PartClassTypeID int  = NULL , 
@ProductID int  = NULL , 
@ProductClassTypeID int  = NULL , 
@ModifierID int  = NULL , 
@ModifierClassTypeID int  = NULL , 
@TransHeaderID int  = NULL , 
@TransHeaderClassTypeID int  = NULL , 
@TransDetailID int  = NULL , 
@TransDetailClassTypeID int  = NULL , 
@TransModID int  = NULL , 
@TransModClassTypeID int  = NULL , 
@TransPartID int  = NULL , 
@TransPartClassTypeID int  = NULL , 
@Quantity [numeric](18,4)  = NULL , 
@Description [nvarchar](50)   = NULL , 
@Reserved bit  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PartGL] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
