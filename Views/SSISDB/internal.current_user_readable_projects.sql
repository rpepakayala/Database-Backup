/****** Object:  View [internal].[current_user_readable_projects]    Script Date: 5/15/2018 12:14:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [internal].[current_user_readable_projects]
AS
SELECT     [object_id] AS [ID]
FROM       [catalog].[effective_object_permissions]
WHERE      [object_type] = 2
           AND  [permission_type] = 1

GO
