/****** Object:  View [catalog].[environment_variables]    Script Date: 5/15/2018 12:14:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [catalog].[environment_variables]
AS
SELECT     [variable_id], 
           [environment_id], 
           [name],
           [description],
           [type], 
           [sensitive], 
           [value]
FROM       [internal].[environment_variables]
WHERE      [environment_id] in (SELECT [id] FROM [internal].[current_user_readable_environments])
           OR (IS_MEMBER('ssis_admin') = 1)
           OR (IS_SRVROLEMEMBER('sysadmin') = 1)

GO
