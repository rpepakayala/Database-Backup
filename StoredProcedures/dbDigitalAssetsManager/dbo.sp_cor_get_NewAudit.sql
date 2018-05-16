/****** Object:  StoredProcedure [dbo].[sp_cor_get_NewAudit]    Script Date: 5/15/2018 12:09:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROC [dbo].[sp_cor_get_NewAudit] 
 	@UserID int,
	@ActionCode smallint,
	@LastAuditID numeric
AS  

BEGIN 

	insert into dbo.AUDIT 	( UserID , ActionCode, [Date], LastAuditID )
		values		( @UserID , @ActionCode,  getdate(), @LastAuditID )
	if @@rowcount > 0 
		select @@identity
	else
		select -1






END


GO
