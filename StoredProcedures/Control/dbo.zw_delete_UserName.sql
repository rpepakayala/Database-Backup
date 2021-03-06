/****** Object:  StoredProcedure [dbo].[zw_delete_UserName]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_UserName ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](50)   = NULL , 
@ModifiedByComputer [nvarchar](50)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@ParentID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@LoginName [nvarchar](50)   = NULL , 
@Password [nvarchar](50)   = NULL , 
@ForcePWChange bit  = NULL , 
@SecurityTemplateID int  = NULL , 
@SecurityRightTemplateID int  = NULL , 
@LastWebAccess datetime  = NULL , 
@UserLicenseType int  = NULL , 
@PartialTemplateType int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [UserName] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
