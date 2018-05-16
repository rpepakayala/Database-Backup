/****** Object:  StoredProcedure [dbo].[ExactTarget_Contact_Subscriber_iu]    Script Date: 5/15/2018 12:09:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[ExactTarget_Contact_Subscriber_iu]
(
@contactid int,
@zw_franchise_id varchar(10),
@subscriber_id int
)
AS 
SET NOCOUNT ON
BEGIN
	
	UPDATE _ExactTarget_Integration_Contacts
	SET
		subscriber_id = @subscriber_id,
		LastSync = getdate()
	WHERE 
		[contactid] = @contactid
	AND 
		[zw_franchise_id] = @zw_franchise_id

END






GO
