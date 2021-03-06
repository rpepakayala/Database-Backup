/****** Object:  View [dbo].[sysutility_ucp_managed_instances]    Script Date: 5/15/2018 12:14:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[sysutility_ucp_managed_instances]
AS
    SELECT     
        instance_id,
        instance_name,
        virtual_server_name,
        date_created,
        created_by,
        agent_proxy_account,
        cache_directory,
        management_state
    FROM [dbo].[sysutility_ucp_managed_instances_internal]

GO
