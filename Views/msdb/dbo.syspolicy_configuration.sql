/****** Object:  View [dbo].[syspolicy_configuration]    Script Date: 5/15/2018 12:14:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[syspolicy_configuration]
AS
    SELECT 
        name,
        CASE WHEN name = N'Enabled' and SERVERPROPERTY('EngineEdition') = 4 THEN 0 ELSE current_value END AS current_value
    FROM [dbo].[syspolicy_configuration_internal] 

GO
