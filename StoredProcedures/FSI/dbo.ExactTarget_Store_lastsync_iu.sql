/****** Object:  StoredProcedure [dbo].[ExactTarget_Store_lastsync_iu]    Script Date: 5/15/2018 12:09:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[ExactTarget_Store_lastsync_iu]
(
@zw_franchise_id varchar(10),
@lastsync datetime
)
AS
SET NOCOUNT ON
BEGIN

UPDATE _ExactTarget_Integration_Stores
SET LastSync = @lastsync
WHERE zw_franchise_id = @zw_franchise_id

END



GO
