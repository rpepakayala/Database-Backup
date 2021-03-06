/****** Object:  StoredProcedure [dbo].[zw_delete_EstimateModifiersDatabase]    Script Date: 5/15/2018 12:09:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_EstimateModifiersDatabase ( 
@ID int  = NULL , 
@OrderDetailID int  = NULL , 
@AVID int  = NULL , 
@OrderID int  = NULL , 
@Answer int  = NULL , 
@Price float  = NULL , 
@PriceOverridden bit  = NULL , 
@CalcPrice float  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Estimate Modifiers Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID

GO
