/****** Object:  StoredProcedure [dbo].[proc_MSS_GetManagedPropertyAliasesByPid]    Script Date: 5/15/2018 12:13:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetManagedPropertyAliasesByPid
@PID int
as
Select alias from MSSManagedPropAliases where pid = @PID

GO
