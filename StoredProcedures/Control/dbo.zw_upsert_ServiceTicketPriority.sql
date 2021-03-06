/****** Object:  StoredProcedure [dbo].[zw_upsert_ServiceTicketPriority]    Script Date: 5/15/2018 12:09:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_upsert_ServiceTicketPriority] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PriorityName varchar(50)  = NULL , 
@PriorityLevel int  = NULL , 
@UseDefaultColors bit  = NULL , 
@FontColor int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [ServiceTicketPriority] 
	 SET   
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[PriorityName] = @PriorityName, 
		[PriorityLevel] = @PriorityLevel, 
		[UseDefaultColors] = @UseDefaultColors, 
		[FontColor] = @FontColor, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [ServiceTicketPriority]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [PriorityName], [PriorityLevel], [UseDefaultColors], [FontColor], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @PriorityName, @PriorityLevel, @UseDefaultColors, @FontColor, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 


GO
