/****** Object:  StoredProcedure [dbo].[sp_delete_log_shipping_secondary]    Script Date: 5/15/2018 12:10:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE sp_delete_log_shipping_secondary 
  @secondary_server_name   sysname,
  @secondary_database_name sysname
AS BEGIN
  SET NOCOUNT ON
  DELETE FROM msdb.dbo.log_shipping_secondaries WHERE 
    secondary_server_name   = @secondary_server_name AND
    secondary_database_name = @secondary_database_name
END

GO
