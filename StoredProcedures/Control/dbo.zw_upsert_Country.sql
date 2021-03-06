/****** Object:  StoredProcedure [dbo].[zw_upsert_Country]    Script Date: 5/15/2018 12:09:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_Country ( 
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
@Country [nvarchar](40)   = NULL , 
@CountryShortName [nvarchar](15)   = NULL , 
@CountryCode int  = NULL , 
@PhoneFormatString [nvarchar](30)   = NULL , 
@PhoneTemplate [nvarchar](50)   = NULL , 
@AddressFormatString [nvarchar](30)   = NULL , 
@AreaCodeDigits int  = NULL , 
@ZipMaxDigits int  = NULL , 
@ZipShortDigits int  = NULL , 
@TranslationLanguage [nvarchar](30)   = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Country] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[ParentID] = @ParentID, 
		[ParentClassTypeID] = @ParentClassTypeID, 
		[Country] = @Country, 
		[CountryShortName] = @CountryShortName, 
		[CountryCode] = @CountryCode, 
		[PhoneFormatString] = @PhoneFormatString, 
		[PhoneTemplate] = @PhoneTemplate, 
		[AddressFormatString] = @AddressFormatString, 
		[AreaCodeDigits] = @AreaCodeDigits, 
		[ZipMaxDigits] = @ZipMaxDigits, 
		[ZipShortDigits] = @ZipShortDigits, 
		[TranslationLanguage] = @TranslationLanguage, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Country]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [ParentID], [ParentClassTypeID], [Country], [CountryShortName], [CountryCode], [PhoneFormatString], [PhoneTemplate], [AddressFormatString], [AreaCodeDigits], [ZipMaxDigits], [ZipShortDigits], [TranslationLanguage], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @ParentID, @ParentClassTypeID, @Country, @CountryShortName, @CountryCode, @PhoneFormatString, @PhoneTemplate, @AddressFormatString, @AreaCodeDigits, @ZipMaxDigits, @ZipShortDigits, @TranslationLanguage, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
