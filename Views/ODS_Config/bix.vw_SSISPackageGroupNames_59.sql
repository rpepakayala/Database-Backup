/****** Object:  View [bix].[vw_SSISPackageGroupNames_59]    Script Date: 5/15/2018 12:14:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [bix].[vw_SSISPackageGroupNames_59]
AS
(
    SELECT 
        [LogID],
        [GroupID],
        [PackageName]
    FROM [dbo].[SSISPackageGroupNames]
)
GO
