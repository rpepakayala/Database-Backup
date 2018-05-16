/****** Object:  View [dbo].[sysmanagement_shared_registered_servers]    Script Date: 5/15/2018 12:14:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[sysmanagement_shared_registered_servers]
AS
(
    SELECT server_id, server_group_id, name, server_name, description, server_type
    FROM [msdb].[dbo].[sysmanagement_shared_registered_servers_internal]
)

GO
