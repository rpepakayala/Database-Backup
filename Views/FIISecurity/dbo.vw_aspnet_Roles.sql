/****** Object:  View [dbo].[vw_aspnet_Roles]    Script Date: 5/15/2018 12:13:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

  CREATE VIEW [dbo].[vw_aspnet_Roles]
  AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], [dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], [dbo].[aspnet_Roles].[Description]
  FROM [dbo].[aspnet_Roles]
  
GO
