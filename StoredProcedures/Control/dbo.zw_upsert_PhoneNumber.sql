/****** Object:  StoredProcedure [dbo].[zw_upsert_PhoneNumber]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_PhoneNumber ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@ParentID int  = NULL , 
@ParentStoreID int  = NULL , 
@ParentClassTypeID int  = NULL , 
@PhoneNumberTypeID int  = NULL , 
@CountryCode [nvarchar](10)   = NULL , 
@AreaCode [nvarchar](10)   = NULL , 
@PhoneNumber [nvarchar](25)   = NULL , 
@Extension [nvarchar](10)   = NULL , 
@FormattedText [nvarchar](75)   = NULL , 
@PhoneNumberIndex int  = NULL , 
@PhoneNumberTypeText varchar(50)  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PhoneNumber] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[ParentID] = @ParentID, 
		[ParentStoreID] = @ParentStoreID, 
		[ParentClassTypeID] = @ParentClassTypeID, 
		[PhoneNumberTypeID] = @PhoneNumberTypeID, 
		[CountryCode] = @CountryCode, 
		[AreaCode] = @AreaCode, 
		[PhoneNumber] = @PhoneNumber, 
		[Extension] = @Extension, 
		[FormattedText] = @FormattedText, 
		[PhoneNumberIndex] = @PhoneNumberIndex, 
		[PhoneNumberTypeText] = @PhoneNumberTypeText, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [PhoneNumber]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ParentID], [ParentStoreID], [ParentClassTypeID], [PhoneNumberTypeID], [CountryCode], [AreaCode], [PhoneNumber], [Extension], [FormattedText], [PhoneNumberIndex], [PhoneNumberTypeText], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ParentID, @ParentStoreID, @ParentClassTypeID, @PhoneNumberTypeID, @CountryCode, @AreaCode, @PhoneNumber, @Extension, @FormattedText, @PhoneNumberIndex, @PhoneNumberTypeText, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
