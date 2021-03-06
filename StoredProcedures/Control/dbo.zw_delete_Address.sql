/****** Object:  StoredProcedure [dbo].[zw_delete_Address]    Script Date: 5/15/2018 12:09:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_Address ( 
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
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
