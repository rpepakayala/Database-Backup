/****** Object:  View [dbo].[syspolicy_target_set_levels]    Script Date: 5/15/2018 12:14:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[syspolicy_target_set_levels]
AS
    SELECT     
        target_set_level_id,
        target_set_id,
        type_skeleton,
        condition_id,
        level_name
    FROM [dbo].[syspolicy_target_set_levels_internal]

GO
