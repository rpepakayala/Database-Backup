/****** Object:  StoredProcedure [dbo].[sp_remove_log_shipping_monitor_account]    Script Date: 5/15/2018 12:10:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE sp_remove_log_shipping_monitor_account
AS
BEGIN
  SET NOCOUNT ON
  EXECUTE sp_dropuser N'log_shipping_monitor_probe'
  EXECUTE sp_droplogin N'log_shipping_monitor_probe'
END

GO
