/****** Object:  View [dbo].[syspolicy_target_sets]    Script Date: 5/15/2018 12:14:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[syspolicy_target_sets]
AS
    SELECT     
        target_set_id,
        object_set_id,
        type_skeleton,
        type,
        enabled
    FROM [dbo].[syspolicy_target_sets_internal]

GO
