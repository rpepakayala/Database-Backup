/****** Object:  StoredProcedure [dbo].[dt_dropuserobjectbyid]    Script Date: 5/15/2018 12:09:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
**	Drop an object from the dbo.dtproperties table
*/
create procedure dbo.dt_dropuserobjectbyid
	@id int
as
	set nocount on
	delete from dbo.dtproperties where objectid=@id

GO
