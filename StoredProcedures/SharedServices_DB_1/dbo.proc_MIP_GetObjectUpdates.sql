/****** Object:  StoredProcedure [dbo].[proc_MIP_GetObjectUpdates]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_GetObjectUpdates
(
	@Version bigint,
	@CurrentVersion bigint output
)
as
	set nocount on

	exec dbo.proc_MIP_GetVersion 1, @CurrentVersion output

	if (@Version = @CurrentVersion)
		return 0 

	select
		ObjectId,
		Status,
		Version, 
		isnull(LongXml, Xml) as Xml
	from
		dbo.MIPObjects
	where
		Version > @Version

	select
		ObjectId
	from
		dbo.MIPTombstones
	where
		Version > @Version

	if (@@error != 0)
		return 1 

	return 0 

GO
