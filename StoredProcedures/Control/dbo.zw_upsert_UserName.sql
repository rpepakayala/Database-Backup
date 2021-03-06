/****** Object:  StoredProcedure [dbo].[zw_upsert_UserName]    Script Date: 5/15/2018 12:09:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_UserName ( 
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
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[ParentID] = @ParentID, 
		[ParentClassTypeID] = @ParentClassTypeID, 
		[LoginName] = @LoginName, 
		[Password] = @Password, 
		[ForcePWChange] = @ForcePWChange, 
		[SecurityTemplateID] = @SecurityTemplateID, 
		[SecurityRightTemplateID] = @SecurityRightTemplateID, 
		[LastWebAccess] = @LastWebAccess, 
		[UserLicenseType] = @UserLicenseType, 
		[PartialTemplateType] = @PartialTemplateType, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [UserName]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ParentID], [ParentClassTypeID], [LoginName], [Password], [ForcePWChange], [SecurityTemplateID], [SecurityRightTemplateID], [LastWebAccess], [UserLicenseType], [PartialTemplateType], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ParentID, @ParentClassTypeID, @LoginName, @Password, @ForcePWChange, @SecurityTemplateID, @SecurityRightTemplateID, @LastWebAccess, @UserLicenseType, @PartialTemplateType, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
