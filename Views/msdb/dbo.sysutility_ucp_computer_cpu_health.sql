/****** Object:  View [dbo].[sysutility_ucp_computer_cpu_health]    Script Date: 5/15/2018 12:14:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
	CREATE VIEW dbo.sysutility_ucp_computer_cpu_health 
	AS
	SELECT t.physical_server_name,
			t.health_state,
			t.processing_time
	FROM msdb.dbo.sysutility_ucp_computer_cpu_health_internal AS t
	WHERE t.set_number = (SELECT latest_health_state_id FROM [msdb].[dbo].[sysutility_ucp_processing_state_internal])

GO
