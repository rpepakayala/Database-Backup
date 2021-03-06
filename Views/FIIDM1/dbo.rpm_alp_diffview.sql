/****** Object:  View [dbo].[rpm_alp_diffview]    Script Date: 5/15/2018 12:13:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE view rpm_alp_diffview
as
select top 1000 T_webnumber as webnumber, T_storenumber as storenumber, sum(royaltyamt) as RPM_royalty, ALP_royalty from gl_fact as gl
inner join storedim as sd
on gl.storekey = sd.storekey
inner join [01dalsvmsql001].alpine.dbo.royaltyreportview1 as rrv
on rrv.storenumber=sd.T_storenumber
where gl.datekey > 20090731 and gl.datekey < 20090901
group by T_webnumber, T_storenumber, ALP_royalty
order by T_webnumber
GO
