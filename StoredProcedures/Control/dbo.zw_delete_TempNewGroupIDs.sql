/****** Object:  StoredProcedure [dbo].[zw_delete_TempNewGroupIDs]    Script Date: 5/15/2018 12:09:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE [dbo].[zw_delete_TempNewGroupIDs] ( 
@GroupID int  = NULL , 
@ID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [TempNewGroupIDs] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [GroupID] = @GroupID
		AND [ID] = @ID


GO
