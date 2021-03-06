/****** Object:  StoredProcedure [dbo].[proc_MIP_GetVersion]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_GetVersion
(
	@VersionId int,
	@Version bigint output
)
as
	set nocount on

	select
		@Version = Version
	from
		dbo.MIPVersion
	where
		VersionId = @VersionId

	if (@@error != 0)
		return 100 

	if (@Version is null)
		set @Version = 0

	return 0 

GO
