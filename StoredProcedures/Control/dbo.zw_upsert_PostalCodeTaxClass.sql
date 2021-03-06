/****** Object:  StoredProcedure [dbo].[zw_upsert_PostalCodeTaxClass]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_upsert_PostalCodeTaxClass] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PostalCode varchar(25)  = NULL , 
@Identifier varchar(35)  = NULL , 
@City varchar(25)  = NULL , 
@State varchar(25)  = NULL , 
@TaxClassID int  = NULL , 
@County varchar(40)  = NULL , 
@Country varchar(40)  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [PostalCodeTaxClass] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[PostalCode] = @PostalCode, 
		[Identifier] = @Identifier, 
		[City] = @City, 
		[State] = @State, 
		[TaxClassID] = @TaxClassID, 
		[County] = @County, 
		[Country] = @Country, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [PostalCodeTaxClass]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [PostalCode], [Identifier], [City], [State], [TaxClassID], [County], [Country], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @PostalCode, @Identifier, @City, @State, @TaxClassID, @County, @Country, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 


GO
