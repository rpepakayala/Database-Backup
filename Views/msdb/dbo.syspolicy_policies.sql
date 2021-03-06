/****** Object:  View [dbo].[syspolicy_policies]    Script Date: 5/15/2018 12:14:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[syspolicy_policies]
AS
    SELECT     
        policy_id,
        name,
        condition_id,
        root_condition_id,
        date_created,
        execution_mode,
        policy_category_id,
        schedule_uid,
        description,
        help_text,
        help_link,
        object_set_id,
        is_enabled,
        job_id,
        created_by,
        modified_by,
        date_modified,
        is_system
    FROM [dbo].[syspolicy_policies_internal]

GO
