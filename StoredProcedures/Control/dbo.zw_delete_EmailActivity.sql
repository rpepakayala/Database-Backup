/****** Object:  StoredProcedure [dbo].[zw_delete_EmailActivity]    Script Date: 5/15/2018 12:09:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_EmailActivity ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@Recipients [nvarchar](MAX)   = NULL , 
@CC [nvarchar](MAX)   = NULL , 
@BCC [nvarchar](MAX)   = NULL , 
@Subject [nvarchar](50)   = NULL , 
@Sender [nvarchar](50)   = NULL , 
@Body [nvarchar](MAX)   = NULL , 
@Attachments [nvarchar](MAX)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [EmailActivity] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
