/****** Object:  View [dbo].[vw_aspnet_WebPartState_Paths]    Script Date: 5/15/2018 12:13:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

  CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
  AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], [dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
  FROM [dbo].[aspnet_Paths]
  
GO
