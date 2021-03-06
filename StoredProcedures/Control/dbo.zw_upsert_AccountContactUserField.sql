/****** Object:  StoredProcedure [dbo].[zw_upsert_AccountContactUserField]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_AccountContactUserField ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@username [nvarchar](MAX)   = NULL , 
@password [nvarchar](MAX)   = NULL , 
@OPT___OUT_of_FASTMAIL varchar(1)  = NULL , 
@AllowWebAccess varchar(1)  = NULL , 
@LastWebAccess datetime  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [AccountContactUserField] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[username] = @username, 
		[password] = @password, 
		[OPT___OUT_of_FASTMAIL] = @OPT___OUT_of_FASTMAIL, 
		[AllowWebAccess] = @AllowWebAccess, 
		[LastWebAccess] = @LastWebAccess, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [AccountContactUserField]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [username], [password], [OPT___OUT_of_FASTMAIL], [AllowWebAccess], [LastWebAccess], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @username, @password, @OPT___OUT_of_FASTMAIL, @AllowWebAccess, @LastWebAccess, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
