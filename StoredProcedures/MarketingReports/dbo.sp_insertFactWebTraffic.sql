/****** Object:  StoredProcedure [dbo].[sp_insertFactWebTraffic]    Script Date: 5/15/2018 12:10:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[sp_insertFactWebTraffic]
AS
BEGIN
	SET NOCOUNT ON;

	Declare @intReturnCode int, @PK_Store int
	select @intReturnCode = 0
	
declare @stores table(webnumber int)
insert into @stores(webnumber )
select distinct webnumber from dbo.WebTrafficStaging1
union
select distinct webnumber  from dbo.WebTrafficStaging2
union
select distinct webnumber  from dbo.WebTrafficStaging3

declare @period table(month datetime)
insert into @period(month )
select distinct month from dbo.WebTrafficStaging1
union
select distinct month  from dbo.WebTrafficStaging2
union
select distinct month  from dbo.WebTrafficStaging3


delete from analysis.FactWebTraffic
where fk_store in (select distinct s.pk_store from analysis.dimstore s inner join @stores a on a.webnumber = s.webnumber and s.dimstore_scd_end_date is null) and fk_date in (select month from @period)

Declare @month datetime
DECLARE c1 CURSOR READ_ONLY
FOR
select month from @period order by month desc

OPEN c1

FETCH NEXT FROM c1
INTO @month

WHILE @@FETCH_STATUS = 0
BEGIN
	insert into analysis.FactWebTraffic 
	(fk_store, fk_date, visits, uniquevisits, pageviews, bouncerate, averagetime, referringsite, sendafile, rfq, mtmfs)
	select e.pk_store, @month, coalesce(a.visits, 0), coalesce(a.uniquevisits, 0),coalesce(a.pageviews,0), 
	coalesce(a.bouncerate,0), coalesce(a.avgtimepervisit, 0), coalesce(b.referringsites, '') as Sites, coalesce(c.sendafile, 0),
	coalesce(c.rfq, 0) , coalesce(c.myfastsignsregistration, 0)   
	from @stores s
	left join dbo.webtrafficstaging1 a on a.webnumber = s.webnumber  and @month = a.month
	left join analysis.Monthlyreferringsite b on s.webnumber = b.webnumber and @month = b.month
	left join dbo.webtrafficstaging3 c on s.webnumber = c.webnumber and @month = c.month
	inner join analysis.dimstore e on s.webnumber = e.webnumber and e.dimstore_scd_end_date is null


	FETCH NEXT FROM c1
	INTO @month
END

CLOSE c1
DEALLOCATE c1



	select @intReturnCode = @@error
	return @intReturnCode
END

GO
