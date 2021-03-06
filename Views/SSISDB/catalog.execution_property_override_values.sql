/****** Object:  View [catalog].[execution_property_override_values]    Script Date: 5/15/2018 12:14:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [catalog].[execution_property_override_values]
AS
SELECT     [property_id], 
           [execution_id],
           [property_path], 
           [property_value], 
           [sensitive]
FROM       [internal].[execution_property_override_values]
WHERE      [execution_id] in (SELECT [id] FROM [internal].[current_user_readable_operations])
           OR (IS_MEMBER('ssis_admin') = 1)
           OR (IS_SRVROLEMEMBER('sysadmin') = 1)

GO
