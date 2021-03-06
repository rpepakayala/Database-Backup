/****** Object:  StoredProcedure [dbo].[proc_MIP_GetNextVersion]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_GetNextVersion
(
	@VersionId int,
	@Version bigint output
)
as
	set nocount on

	update
		dbo.MIPVersion
	set
		@Version = Version = Version + 1
	where
		VersionId = @VersionId

	if (@@error != 0)
		return 101 

	if (@Version is null)
	begin
		if (@VersionId is null)
			return 102 

		set @Version = 1

		insert into dbo.MIPVersion
		(
			VersionId,
			Version
		)
		values
		(
			@VersionId,
			@Version 
		)

		if ((@@rowcount != 1) or (@@error != 0))
			return 103 
	end

	return 0 

GO
