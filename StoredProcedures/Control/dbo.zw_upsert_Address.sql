/****** Object:  StoredProcedure [dbo].[zw_upsert_Address]    Script Date: 5/15/2018 12:09:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_upsert_Address ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@StreetAddress1 [nvarchar](40)   = NULL , 
@StreetAddress2 [nvarchar](40)   = NULL , 
@City [nvarchar](25)   = NULL , 
@State [nvarchar](25)   = NULL , 
@County [nvarchar](25)   = NULL , 
@PostalCode [nvarchar](25)   = NULL , 
@Country [nvarchar](25)   = NULL , 
@FormattedText [nvarchar](MAX)   = NULL , 
@TaxClassID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Address] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[StreetAddress1] = @StreetAddress1, 
		[StreetAddress2] = @StreetAddress2, 
		[City] = @City, 
		[State] = @State, 
		[County] = @County, 
		[PostalCode] = @PostalCode, 
		[Country] = @Country, 
		[FormattedText] = @FormattedText, 
		[TaxClassID] = @TaxClassID, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Address]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [StreetAddress1], [StreetAddress2], [City], [State], [County], [PostalCode], [Country], [FormattedText], [TaxClassID], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @StreetAddress1, @StreetAddress2, @City, @State, @County, @PostalCode, @Country, @FormattedText, @TaxClassID, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END

GO
