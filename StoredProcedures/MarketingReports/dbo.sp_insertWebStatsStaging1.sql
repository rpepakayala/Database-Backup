/****** Object:  StoredProcedure [dbo].[sp_insertWebStatsStaging1]    Script Date: 5/15/2018 12:10:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE sp_insertWebStatsStaging1
	@WebNumber int,
	@Month nvarchar(30),
	@Visits int,
	@PageViews int,
	@UniqueVisits int,
	@AvgTimePerVisit decimal(18,4),
	@BounceRate decimal(18,4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @intReturnCode int
	select @intReturnCode = 0

	if EXISTS (select * from dbo.WebTrafficStaging1 where webnumber = @WebNumber and Month = CONVERT(datetime, @Month, 101))
	BEGIN
	  UPDATE dbo.WebTrafficStaging1
		SET Visits=@Visits, PageViews=@PageViews, UniqueVisits = @UniqueVisits, AvgTimePerVisit = @AvgTimePerVisit, BounceRate = @BounceRate
		WHERE webnumber = @WebNumber and Month = CONVERT(datetime, @Month, 101)
	END
	ELSE
	BEGIN
		Insert dbo.WebTrafficStaging1 (WebNumber, Month, Visits, PageViews, UniqueVisits, AvgTimePerVisit, BounceRate)
		Values (@WebNumber, CONVERT(datetime, @Month, 101), @Visits, @PageViews, @UniqueVisits, @AvgTimePerVisit, @BounceRate)
	END


	select @intReturnCode = @@error
	return @intReturnCode
END

GO
