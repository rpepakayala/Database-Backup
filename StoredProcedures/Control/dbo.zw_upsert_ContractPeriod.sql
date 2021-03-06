/****** Object:  StoredProcedure [dbo].[zw_upsert_ContractPeriod]    Script Date: 5/15/2018 12:09:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_upsert_ContractPeriod] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@PeriodName varchar(50)  = NULL , 
@NumberOf int  = NULL , 
@UseMonths bit  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [ContractPeriod] 
	 SET   
		[StoreID] = @StoreID, 
		[ClassTypeID] = @ClassTypeID, 
		[ModifiedByUser] = @ModifiedByUser, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[SeqID] = @SeqID, 
		[IsSystem] = @IsSystem, 
		[IsActive] = @IsActive, 
		[PeriodName] = @PeriodName, 
		[NumberOf] = @NumberOf, 
		[UseMonths] = @UseMonths, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [ContractPeriod]( [ID], [StoreID], [ClassTypeID], [ModifiedByUser], [ModifiedByComputer], [ModifiedDate], [SeqID], [IsSystem], [IsActive], [PeriodName], [NumberOf], [UseMonths], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @ID, @StoreID, @ClassTypeID, @ModifiedByUser, @ModifiedByComputer, @ModifiedDate, @SeqID, @IsSystem, @IsActive, @PeriodName, @NumberOf, @UseMonths, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 


GO
