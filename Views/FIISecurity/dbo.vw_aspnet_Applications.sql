/****** Object:  View [dbo].[vw_aspnet_Applications]    Script Date: 5/15/2018 12:13:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

  CREATE VIEW [dbo].[vw_aspnet_Applications]
  AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
  FROM [dbo].[aspnet_Applications]
  
GO
