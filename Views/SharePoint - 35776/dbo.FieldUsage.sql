/****** Object:  View [dbo].[FieldUsage]    Script Date: 5/15/2018 12:14:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[FieldUsage]
AS
    SELECT
        SiteId,
        ContentTypeId,
        WebId,
        ListId AS FieldId
    FROM
        ContentTypeUsage
    WHERE
        IsFieldId = 1

GO
