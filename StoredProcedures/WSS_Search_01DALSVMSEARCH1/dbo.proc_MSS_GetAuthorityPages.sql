/****** Object:  StoredProcedure [dbo].[proc_MSS_GetAuthorityPages]    Script Date: 5/15/2018 12:13:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetAuthorityPages
AS
	SELECT DisplayUrl, DisplayHash, Authoritylevel FROM dbo.MSSClickDistanceSeeds

GO
