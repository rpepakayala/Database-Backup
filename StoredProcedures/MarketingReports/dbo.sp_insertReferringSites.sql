/****** Object:  StoredProcedure [dbo].[sp_insertReferringSites]    Script Date: 5/15/2018 12:10:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE sp_insertReferringSites
	@WebNumber int,
	@Month nvarchar(30),
	@ReferringSite nvarchar(100),
	@Visits int
AS
BEGIN
	SET NOCOUNT ON;

	Declare @intReturnCode int
	select @intReturnCode = 0
	
	if EXISTS (select * from dbo.WebTrafficStaging2 where WebNumber = @WebNumber and Month = CONVERT(datetime, @Month, 101) 
				and ReferringSite = @ReferringSite)
	BEGIN
	  UPDATE dbo.WebTrafficStaging2
		SET Visits =@Visits
		where WebNumber = @WebNumber and Month = CONVERT(datetime, @Month, 101) and ReferringSite = @ReferringSite
	END
	ELSE
	BEGIN
		Insert dbo.WebTrafficStaging2 (WebNumber, Month, ReferringSite, Visits)
		Values (@WebNumber, CONVERT(datetime, @Month, 101), @ReferringSite, @Visits)
	END


	select @intReturnCode = @@error
	return @intReturnCode
END

GO
