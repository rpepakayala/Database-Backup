/****** Object:  StoredProcedure [dbo].[sp_insertFactVelocityDirect]    Script Date: 5/15/2018 12:10:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[sp_insertFactVelocityDirect]
	@WebNumber int,
	@Month nvarchar(30),
	@Programs int,
	@Appointments int
AS
BEGIN
	SET NOCOUNT ON;

	Declare @intReturnCode int, @PK_Store int
	select @intReturnCode = 0
	
	select @PK_Store = (select TOP 1 PK_Store from Analysis.DimStore where Webnumber = @WebNumber and DimStore_SCD_End_Date is null)

    if @PK_Store is null
	Begin
		select @PK_Store = (select TOP 1 PK_Store from Analysis.DimStore where Webnumber = @WebNumber and DimStore_SCD_End_Date is not null and DimStore_SCD_End_Date >= CONVERT(datetime, @Month, 101))
	End

	if @PK_Store is not null
	BEGIN
		if EXISTS (select * from Analysis.FactVelocityDirect where FK_Store = @PK_Store and FK_Date = CONVERT(datetime, @Month, 101))
		BEGIN
		  UPDATE Analysis.FactVelocityDirect
			SET Programs=@Programs, Appointments =@Appointments 
			where FK_Store = @PK_Store and FK_Date = CONVERT(datetime, @Month, 101)
		END
		ELSE
		BEGIN
			Insert Analysis.FactVelocityDirect (FK_Store, FK_Date, Programs,Appointments   )
			Values (@PK_Store, CONVERT(datetime, @Month, 101), @Programs,@Appointments )
		END
	END

	select @intReturnCode = @@error
	return @intReturnCode
END

GO
