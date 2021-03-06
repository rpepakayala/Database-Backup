/****** Object:  StoredProcedure [dbo].[zw_delete_CustomRange]    Script Date: 5/15/2018 12:09:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_delete_CustomRange] ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser varchar(25)  = NULL , 
@ModifiedByComputer varchar(25)  = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@RangeName varchar(50)  = NULL , 
@SortIndex float  = NULL , 
@StartDateTime datetime  = NULL , 
@StartDTDif datetime  = NULL , 
@StartDTFixed bit  = NULL , 
@FlexStartType int  = NULL , 
@StartRangeType int  = NULL , 
@EndDateTime datetime  = NULL , 
@EndDTDif datetime  = NULL , 
@EndDTFixed bit  = NULL , 
@FlexEndType int  = NULL , 
@EndRangeType int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [CustomRange] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID


GO
