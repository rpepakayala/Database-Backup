/****** Object:  StoredProcedure [dbo].[proc_MIP_GetObjectVersion]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_GetObjectVersion
(
	@CurrentVersion bigint output
)
as
	set nocount on

	declare @return int
	exec @return = dbo.proc_MIP_GetVersion 1, @CurrentVersion output

	return @return

GO
