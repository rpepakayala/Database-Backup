/****** Object:  View [dbo].[royaltyreportview1]    Script Date: 5/15/2018 12:13:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
create view [dbo].[royaltyreportview1]
as
select top 600 webnumber, storenumber,sum(totalsales)as ALP_Royalty from cor_stores as cs
inner join sls_royalty_period as srp
on cs.storeid=srp.storeid
inner join sls_royalty_report as srr
on srp.royaltyperiodid=srr.royaltyperiodid
where srp.royaltyperiodid >148230 and srp.royaltyperiodid < 148788
group by webnumber, storenumber
order by webnumber

GO
