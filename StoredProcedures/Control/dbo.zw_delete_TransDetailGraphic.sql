/****** Object:  StoredProcedure [dbo].[zw_delete_TransDetailGraphic]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_TransDetailGraphic ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@DetailImage image  = NULL , 
@LongImage image  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [TransDetailGraphic] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
