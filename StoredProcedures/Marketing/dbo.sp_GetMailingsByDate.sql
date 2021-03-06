/****** Object:  StoredProcedure [dbo].[sp_GetMailingsByDate]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

Create PROCEDURE [dbo].[sp_GetMailingsByDate]
	-- input date format: mm/dd/yyyy	
	@mDate varchar(50) -- Mailing date
AS

BEGIN
	SET NOCOUNT ON;

	declare @mailingDate datetime

	set @mailingDate = convert(datetime, @mDate, 101)
	declare @StoreMailing table (webnum int, mailing int)
	declare @StoreCountry table (webnum int, countrycode varchar(10))

	insert into @StoreCountry (webnum, countrycode)
	SELECT a.[WebNumber], e.countryisocode
	FROM [01DALSVMSQL001].[Alpine].[dbo].[COR_STORES] a
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_STORES_addresses_link] b on a.storeid = b.storeid
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_addresses] c on b.addressid = c.addressid
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_POLITICAL_DIVISION] d on c.PoliticalDivisionID = d.PoliticalDivisionID
	left join [01DALSVMSQL001].[Alpine].[dbo].[COR_COUNTRIES] e on d.countryid = e.countryid
	where a.webnumber > 0

		insert into @StoreMailing (webnum, mailing)
		select cast(webid as int), count(*) from dmmailings
		where year(Mailingdate) = year(@mailingDate) and month(mailingdate) = month(@mailingDate)
		 and webid is not null
		group by webid

	select  a.*, c.countrycode as country  from  @Storemailing a
	left join @StoreCountry c on a.webnum = c.webnum
	where a.webnum !=0
	order by a.webnum


END


GO
