/****** Object:  View [bix].[vw_SSISGlobalSettings_59]    Script Date: 5/15/2018 12:14:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [bix].[vw_SSISGlobalSettings_59]
AS
(
    SELECT 
        [SettingKey],
        [SettingValue],
        [DateCreated],
        [DateModified],
        [LastUserChanged],
        [Description]
    FROM [dbo].[SSISGlobalSettings]
)
GO
