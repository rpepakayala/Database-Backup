/****** Object:  StoredProcedure [dbo].[zw_delete_AccountUserField]    Script Date: 5/15/2018 12:09:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_AccountUserField ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@List_Source [nvarchar](MAX)   = NULL , 
@Sub_COMPANY_NAME [nvarchar](MAX)   = NULL , 
@Sub_CONTACT_NAME [nvarchar](MAX)   = NULL , 
@Sub_PHONE [nvarchar](MAX)   = NULL , 
@Sub_SHIPPING_METHOD [nvarchar](MAX)   = NULL , 
@Sub_P_O__NUMBER [nvarchar](MAX)   = NULL , 
@Sub_P_O__AMOUNT float  = NULL , 
@Sub_SHIP_DATE_PROJECTED datetime  = NULL , 
@Sub_TRACKING_NO_ float  = NULL , 
@Sub_ITEM_RECEIVED_DATE datetime  = NULL , 
@Sub_NOTES [nvarchar](MAX)   = NULL , 
@Recently_Picked_up_List datetime  = NULL , 
@Absent_Customers datetime  = NULL , 
@Do_not_mails datetime  = NULL , 
@Exclude_From_Fastmail datetime  = NULL , 
@letter_guide datetime  = NULL , 
@letter_guide_discount datetime  = NULL , 
@nothing datetime  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [AccountUserField] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
