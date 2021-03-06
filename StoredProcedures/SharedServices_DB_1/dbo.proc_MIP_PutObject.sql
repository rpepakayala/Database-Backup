/****** Object:  StoredProcedure [dbo].[proc_MIP_PutObject]    Script Date: 5/15/2018 12:11:26 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
create procedure dbo.proc_MIP_PutObject
(
	@ObjectId uniqueidentifier,
	@Status int,
	@Version bigint,
	@Xml ntext,
	@NewVersion bigint output
)
as
	set nocount on

	declare @CurrentVersion rowversion

	declare @IsLongXml bit
	if (datalength(@xml) > col_length('dbo.MIPObjects', 'Xml')) set @IsLongXml = 1 else set @IsLongXml = 0

	declare @error int

	begin tran

	select
		@CurrentVersion = Version 
	from
		dbo.MIPObjects with (updlock, rowlock)
	where
		ObjectId = @ObjectId

	if (@@rowcount = 0)
	begin

		if (@Version is not null)
		begin
			rollback tran
			return 1 
		end

		exec @error = dbo.proc_MIP_GetNextVersion 1, @NewVersion output
		if (@error != 0)
		begin
			rollback tran
			return @error 
		end

		insert into dbo.MIPObjects
		(
			ObjectId,
			Status,
			Version,
			Xml,
			LongXml
		)
		values
		(
			@ObjectId,
			@Status,
			@NewVersion,
			case when (@IsLongXml = 0) then @Xml else null end,
			case when (@IsLongXml = 1) then @Xml else null end
		)

		if (@@error != 0) or (@@rowcount != 1)
		begin
			rollback tran
			return 2 
		end

		delete from
			dbo.MIPTombstones 
		where
			(ObjectId = @ObjectId)
	end
	else
	begin

		if (@Version != @CurrentVersion)
		begin
			rollback tran
			return 3 
		end

		exec @error = dbo.proc_MIP_GetNextVersion 1, @NewVersion output
		if (@error != 0)
		begin
			rollback tran
			return @error 
		end

		update
			dbo.MIPObjects
		set
			Status = @Status,
			Version = @NewVersion,
			Xml = case when (@IsLongXml = 0) then @Xml else null end,
			LongXml = case when (@IsLongXml = 1) then @Xml else null end
		where
			(ObjectId = @ObjectId)

		if (@@error != 0) or (@@rowcount != 1)
		begin
			rollback tran
			return 4 
		end
	end

	commit tran

	return 0 

GO
