/****** Object:  StoredProcedure [dbo].[proc_MSS_GetLastLocationConfigUpdate]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetLastLocationConfigUpdate
 AS
SET NOCOUNT ON

SELECT LastUpdate
FROM dbo.MSSLocationSystem

GO
