/****** Object:  StoredProcedure [dbo].[sp_getYTDReferringSitesByStores]    Script Date: 5/15/2018 12:10:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE sp_getYTDReferringSitesByStores
	@Webnumbers nvarchar(MAX),
	@Year int,
	@Sites nvarchar(MAX) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	select @Sites = (select ltrim(rtrim(referringsite)) + '|' + cast(sum(visits) as nvarchar(50)) + ','  
	from dbo.webtrafficstaging2 
	where year(month) = @Year 
	and webnumber in (select webnumber from dbo.fn_getWebNumbersFromString(@Webnumbers))
	group by ltrim(rtrim(referringsite))
	having sum(visits) in (select top 10 sum(visits) from dbo.webtrafficstaging2 
			where year(month) = @Year 
			and webnumber in (select webnumber from dbo.fn_getWebNumbersFromString(@Webnumbers))
	group by ltrim(rtrim(referringsite)) ORDER BY sum(visits) desc)
	ORDER BY sum(visits) desc
	for xml path(''))

END

GO
