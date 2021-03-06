/****** Object:  StoredProcedure [dbo].[zw_upsert_FontDatabase]    Script Date: 5/15/2018 12:09:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_FontDatabase ( 
@FontListID int  = NULL , 
@FontList varchar(30)   = NULL , 
@Fonts varchar(MAX)   = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'FontDatabase'
 
	 UPDATE [FontDatabase] 
	 SET   
		[FontList] = @FontList, 
		[Fonts] = @Fonts, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [FontListID] = @FontListID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [FontDatabase]( [FontListID], [FontList], [Fonts], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @FontListID, @FontList, @Fonts, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
