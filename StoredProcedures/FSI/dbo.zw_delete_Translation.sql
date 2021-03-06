/****** Object:  StoredProcedure [dbo].[zw_delete_Translation]    Script Date: 5/15/2018 12:09:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_Translation ( 
@AMERICAN varchar(80)   = NULL , 
@ENGLISH varchar(80)   = NULL , 
@SPANISH varchar(80)   = NULL , 
@DateCreated datetime  = NULL , 
@DateModified datetime  = NULL , 
@Chinese varchar(80)   = NULL , 
@FrenchCanadian varchar(80)   = NULL , 
@Portuguese varchar(80)   = NULL , 
@Australian varchar(80)   = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Translation] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [AMERICAN] = @AMERICAN

GO
