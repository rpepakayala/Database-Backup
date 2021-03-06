/****** Object:  StoredProcedure [dbo].[sp_insertFactPPC]    Script Date: 5/15/2018 12:10:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[sp_insertFactPPC]
	@WebNumber int,
	@Month nvarchar(30),
	@Clicks int,
	@Impressions int,
	@ClickThroughRate decimal(18,4),
	@APICPC money,
	@APICost money,
	@MyFastsignsLeads int,
	@SendAFile int,
	@QuoteLeads int,
	@LocateNow int,
	@GetDirections int
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
		if EXISTS (select * from Analysis.FactPPC where FK_Store = @PK_Store and FK_Date = CONVERT(datetime, @Month, 101))
		BEGIN
		  UPDATE Analysis.FactPPC
			SET Clicks=@Clicks,Impressions=@Impressions, ClickThroughRate = @ClickThroughRate ,APICPC =@APICPC, APICost=@APICost,
				MyFastsignsLeads=@MyFastsignsLeads, SendAFile=@SendAFile, QuoteLeads=@QuoteLeads, LocateNow=@LocateNow,
				GetDirections = @GetDirections
			where FK_Store = @PK_Store and FK_Date = CONVERT(datetime, @Month, 101)
		END
		ELSE
		BEGIN
			Insert Analysis.FactPPC (FK_Store, FK_Date, Clicks,Impressions,ClickThroughRate,APICPC,APICost,
					MyFastsignsLeads, SendAFile, QuoteLeads,LocateNow, GetDirections  )
			Values (@PK_Store, CONVERT(datetime, @Month, 101), @Clicks,@Impressions,@ClickThroughRate,@APICPC,@APICost,
					@MyFastsignsLeads, @SendAFile, @QuoteLeads, @LocateNow, @GetDirections)
		END
	END

	select @intReturnCode = @@error
	return @intReturnCode
END
GO
