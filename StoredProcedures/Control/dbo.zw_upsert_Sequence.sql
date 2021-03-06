/****** Object:  StoredProcedure [dbo].[zw_upsert_Sequence]    Script Date: 5/15/2018 12:09:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/* ************************************ Sequence *************************************** */
CREATE PROCEDURE [dbo].[zw_upsert_Sequence] ( 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@NextNumber int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
     INSERT INTO [Sequence]( [StoreID], [ClassTypeID], [NextNumber], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @StoreID, @ClassTypeID, @NextNumber, @zw_franchise_id, getdate(), getdate(), 1 )

GO
