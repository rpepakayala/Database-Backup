/****** Object:  StoredProcedure [dbo].[zw_delete_GL]    Script Date: 5/15/2018 12:09:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_GL ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@EntryDateTime datetime  = NULL , 
@Amount [decimal](18,4)  = NULL , 
@Classification int  = NULL , 
@IsTaxable bit  = NULL , 
@GroupID int  = NULL , 
@GLAccountID int  = NULL , 
@GLAccountClassTypeID int  = NULL , 
@AccountID int  = NULL , 
@AccountClassTypeID int  = NULL , 
@TransactionID int  = NULL , 
@TransactionClassTypeID int  = NULL , 
@TransDetailID int  = NULL , 
@TransDetailClassTypeID int  = NULL , 
@GoodsItemID int  = NULL , 
@GoodsItemClassTypeID int  = NULL , 
@Description [nvarchar](50)   = NULL , 
@DivisionID int  = NULL , 
@Notes [nvarchar](MAX)   = NULL , 
@IsModified bit  = NULL , 
@IsUser bit  = NULL , 
@TaxClassID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [GL] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
