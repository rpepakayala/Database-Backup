/****** Object:  StoredProcedure [dbo].[zw_upsert_AccountCodeDatabase]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/******************************************* ALTER **************************************************/ 
CREATE PROCEDURE zw_upsert_AccountCodeDatabase ( 
@ID varchar(20)   = NULL , 
@Type varchar(1)   = NULL , 
@Description varchar(30)   = NULL , 
@Number int  = NULL , 
@Text varchar(50)   = NULL , 
@BreakOutSub bit  = NULL , 
@BaseText varchar(50)   = NULL , 
@ModifierText varchar(50)   = NULL , 
@DiscountText varchar(50)   = NULL , 
@InstallText varchar(50)   = NULL , 
@OmitFromExport bit  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'Account Code Database'
 
	 UPDATE [Account Code Database] 
	 SET   
		[Type] = @Type, 
		[Description] = @Description, 
		[Number] = @Number, 
		[Text] = @Text, 
		[BreakOutSub] = @BreakOutSub, 
		[BaseText] = @BaseText, 
		[ModifierText] = @ModifierText, 
		[DiscountText] = @DiscountText, 
		[InstallText] = @InstallText, 
		[OmitFromExport] = @OmitFromExport, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [Account Code Database]( [ID], [Type], [Description], [Number], [Text], [BreakOutSub], [BaseText], [ModifierText], [DiscountText], [InstallText], [OmitFromExport], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @Type, @Description, @Number, @Text, @BreakOutSub, @BaseText, @ModifierText, @DiscountText, @InstallText, @OmitFromExport, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
