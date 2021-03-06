/****** Object:  StoredProcedure [dbo].[sp_getStoreMTDReferringSites]    Script Date: 5/15/2018 12:10:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE sp_getStoreMTDReferringSites
	@Webnumber int,
	@Year int,
	@Month int,
	@Sites nvarchar(MAX) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	select @Sites = (select referringsite + '|' + cast(sum(visits) as nvarchar(50)) + ','  
	from dbo.webtrafficstaging2 
	where year(month) = @Year  and month(month) = @Month and webnumber = @Webnumber group by referringsite
	having sum(visits) in (select top 10 sum(visits) from dbo.webtrafficstaging2 
			where year(month) = @Year and month(month) = @Month and webnumber = @Webnumber 
	group by referringsite ORDER BY sum(visits) desc)
	ORDER BY sum(visits) desc
	for xml path(''))

END

GO
