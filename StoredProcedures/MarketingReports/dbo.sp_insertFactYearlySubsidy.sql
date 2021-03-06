/****** Object:  StoredProcedure [dbo].[sp_insertFactYearlySubsidy]    Script Date: 5/15/2018 12:10:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[sp_insertFactYearlySubsidy]
AS
BEGIN
      SET NOCOUNT ON;

declare @subsidy table 
(
      year datetime,
      baseamount money,
      subtype varchar(100),
      country varchar(20),
      category varchar(100)
)

insert into @subsidy (year, baseamount, subtype, country, category)
select cast(cast(a.year as char) as datetime),a.baseamount, 'Single Store Subsidy', c.name, d.categoryname
from [01DALSPRODSQL1].Marketing.dbo.sub_subsidies a, [01DALSPRODSQL1].Marketing.dbo.sub_subsidytocountry b, [01DALSPRODSQL1].Marketing.dbo.sub_countries c, [01DALSPRODSQL1].Marketing.dbo.sub_categories d
where a.subsidyid = b.subsidyid and b.countryid = c.countryid and a.categoryid = d.categoryid and a.active = 1 
and subsidytypeenum like 'SS%'

insert into @subsidy (year, baseamount, subtype, country, category)
select cast(cast(a.year as char) as datetime),a.baseamount, 'Coop Subisdy', c.name, d.categoryname
from [01DALSPRODSQL1].Marketing.dbo.sub_subsidies a, [01DALSPRODSQL1].Marketing.dbo.sub_subsidytocountry b, [01DALSPRODSQL1].Marketing.dbo.sub_countries c, [01DALSPRODSQL1].Marketing.dbo.sub_categories d
where a.subsidyid = b.subsidyid and b.countryid = c.countryid and a.categoryid = d.categoryid and a.active = 1 
and subsidytypeenum like '%Coop%'

declare @storeRemaining table 
(
      webnumber int,
      year datetime,
      remainingamount money,
      subtype varchar(100),
      category varchar(100)
)
insert into @storeRemaining (webnumber, remainingamount, year, subtype, category)
select e.sourceid  , e.amountavailable, cast(cast(a.year as char) as datetime),'Coop Subisdy'  , d.categoryname
from [01DALSPRODSQL1].Marketing.dbo.sub_subsidies a, [01DALSPRODSQL1].Marketing.dbo.sub_categories d, [01DALSPRODSQL1].Marketing.dbo.sub_totals e
where  a.categoryid = d.categoryid and a.active = 1 
and e.subsidyid = a.subsidyid and e.subsidytypeid= 2 and subsidytypeenum like '%Coop%'

insert into @storeRemaining (webnumber, remainingamount, year, subtype, category)
select e.sourceid, e.amountavailable, cast(cast(a.year as char) as datetime),'Single Store Subsidy'  , d.categoryname
from [01DALSPRODSQL1].Marketing.dbo.sub_subsidies a, [01DALSPRODSQL1].Marketing.dbo.sub_categories d, [01DALSPRODSQL1].Marketing.dbo.sub_totals e
where  a.categoryid = d.categoryid and a.active = 1 
and e.subsidyid = a.subsidyid and e.subsidytypeid= 1 and subsidytypeenum like 'SS%'

delete from marketingreports.analysis.factyearlysubsidy

insert into marketingreports.analysis.factyearlysubsidy
(fk_store, fk_subsidy, fk_year, baseamount, remainingamount)
select s.pk_store,  ds.pk_subsidy, ss.year, ss.baseamount, case when r.remainingamount is null then ss.baseamount else r.remainingamount end as 'RemainingAmount' from marketingreports.analysis.dimstore s 
inner join @subsidy ss on ss.country = s.country 
inner join marketingreports.analysis.dimsubsidy ds on ds.category = ss.category and ds.subsidytype = ss.subtype
left join @storeRemaining r on r.webnumber = s.webnumber and r.year = ss.year and r.category= ss.category and r.subtype = ss.subtype
where s.DimStore_SCD_End_Date is null


END






GO
