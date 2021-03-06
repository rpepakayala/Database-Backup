/****** Object:  StoredProcedure [dbo].[zw_upsert_IndustryDatabase]    Script Date: 5/15/2018 12:09:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_IndustryDatabase ( 
@IndustryTypeID int  = NULL , 
@StoreID int  = NULL , 
@IndustryType varchar(25)   = NULL , 
@ActiveType bit  = NULL , 
@SICCode varchar(7)   = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'Industry Database'
 
	 UPDATE [Industry Database] 
	 SET   
		[IndustryType] = @IndustryType, 
		[ActiveType] = @ActiveType, 
		[SICCode] = @SICCode, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [IndustryTypeID] = @IndustryTypeID
		AND [StoreID] = @StoreID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Industry Database]( [IndustryTypeID], [StoreID], [IndustryType], [ActiveType], [SICCode], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @IndustryTypeID, @StoreID, @IndustryType, @ActiveType, @SICCode, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
