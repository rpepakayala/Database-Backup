/****** Object:  StoredProcedure [dbo].[integration_log_error_api]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[integration_log_error_api](
@occurred datetime = [getdate()],
@sender varchar(100) = NULL,
@error_message varchar(max) = NULL,
@account varchar(100) = NULL,
@list_id int = -1,
@subscriber_id int = -1,
@action varchar(150) = NULL,
@request varchar(max) = NULL,
@response varchar(max) = NULL
)
AS
SET NOCOUNT ON

INSERT INTO _zw_ExactTargetAPI(occurred, sender, logEntry, account, list_id, subscriber_id, [action], request, response )
VALUES (@occurred, @sender, @error_message, @account, @list_id, @subscriber_id, @action, @request, @response )

GO
