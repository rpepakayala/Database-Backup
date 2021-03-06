/****** Object:  StoredProcedure [dbo].[proc_MIP_DropObject]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_DropObject
(
	@ObjectId uniqueidentifier
)
as
	set nocount on

	delete from
		dbo.MIPObjects
	where
		ObjectId = @ObjectId

	if (@@error != 0)
		return 1 

	return 0 

GO
