/****** Object:  StoredProcedure [dbo].[zw_upsert_IOTemplate]    Script Date: 5/15/2018 12:09:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


 
 
 
CREATE PROCEDURE dbo.[zw_upsert_IOTemplate] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate smalldatetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@TemplateType int  = NULL , 
@TemplateName [nvarchar](30)   = NULL , 
@Template [nvarchar](MAX)   = NULL , 
@CategoryID int  = NULL , 
@TextFormat int  = NULL ,
@zw_franchise_id char(7) 
)
AS
SET NOCOUNT ON
 
	 UPDATE [IOTemplate] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[TemplateType] = @TemplateType, 
		[TemplateName] = @TemplateName, 
		[Template] = @Template, 
		[CategoryID] = @CategoryID, 
		[TextFormat] = @TextFormat, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
	WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [IOTemplate]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [TemplateType], [TemplateName], [Template], [CategoryID], [TextFormat], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @TemplateType, @TemplateName, @Template, @CategoryID, @TextFormat, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
