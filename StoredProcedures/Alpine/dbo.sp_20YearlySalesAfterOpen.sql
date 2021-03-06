/****** Object:  StoredProcedure [dbo].[sp_20YearlySalesAfterOpen]    Script Date: 5/15/2018 12:09:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



/*********************************************
*
* new stored procedure - yearly sales after open
*
**********************************************/

create PROCEDURE [dbo].[sp_20YearlySalesAfterOpen]
@sstatus bit
AS
BEGIN
	
--declare @closed bit, @years smallint
--select @closed = 0


create table #opYears (
StoreId bigint, StoreNumber bigint, OpenDate datetime, yearColumn int,
y1 float, y2 float, y3 float, y4 float, y5 float,y6 float, y7 float, y8 float, y9 float, y10 float,
y11 float, y12 float, y13 float, y14 float, y15 float,y16 float, y17 float, y18 float, y19 float, y20 float)


declare @counter smallint
select @counter = count(*) from cor_stores s
inner join cor_store_dates d on d.storeId = s.storeId
inner join cor_store_status_types t on d.BeginStatus = t.StoreStatusType
where d.BeginStatus = 3002

Declare @StoreId bigint, @StoreNumber bigint, @StoreOpenDate datetime
DECLARE stores CURSOR READ_ONLY FOR
	select s.storeid, s.storeNumber, s.StoreOpenDate from cor_stores s
	inner join cor_store_dates d on d.storeId = s.storeId
	inner join cor_store_status_types t on d.BeginStatus = t.StoreStatusType
	where d.BeginStatus = 3002 
OPEN stores
	FETCH NEXT FROM stores
	INTO @StoreId, @StoreNumber,  @StoreOpenDate
	WHILE @counter > 0
	BEGIN
		
		select @counter = @counter - 1	
		declare @openYear int
		select @openYear = datepart(year,@storeopenDate)
		
		declare @curYear int
		select @curYear = datepart(year,getdate())
		
		declare @yearcolumn int
		select @yearcolumn = @curYear - @openYear + 1
	    
		
--StoreId bigint, StoreNumber bigint, OpenDate datetime,
--y1 float, y2 float, y3 float, y4 float, y5 float)
		insert into #opYears 
		select s.StoreId, s.StoreNumber, @StoreOpenDate as OpenDate, @yearColumn as yearColumn,
		(select sum(r1.TotalSales) from sls_royalty_period p1 
		inner join sls_Royalty_Report r1 on r1.RoyaltyPeriodId = p1.RoyaltyPeriodID and r1.OperatingMonth in (1,2,3,4,5,6,7,8,9,10,11,12) 
		where p1.storeId = @StoreId) as y1,
		(select sum(r2.TotalSales) from sls_royalty_period p2 
		inner join sls_Royalty_Report r2 on r2.RoyaltyPeriodId = p2.RoyaltyPeriodID and r2.OperatingMonth in (13,14,15,16,17,18,19,20,21,22,23,24)
		where p2.storeId = @StoreId) as y2,
		(select sum(r3.TotalSales) from sls_royalty_period p3 
		inner join sls_Royalty_Report r3 on r3.RoyaltyPeriodId = p3.RoyaltyPeriodID and r3.OperatingMonth in (25,26,27,28,29,30,31,32,33,34,35,36)
		where p3.storeId = @StoreId) as y3,
		(select sum(r4.TotalSales) from sls_royalty_period p4 
		inner join sls_Royalty_Report r4 on r4.RoyaltyPeriodId = p4.RoyaltyPeriodID and r4.OperatingMonth in (37,38,39,40,41,42,43,44,45,46,47,48)
		where p4.storeId = @StoreId) as y4,	 
		(select sum(r5.TotalSales) from sls_royalty_period p5 
		inner join sls_Royalty_Report r5 on r5.RoyaltyPeriodId = p5.RoyaltyPeriodID and r5.OperatingMonth in (49,50,51,52,53,54,55,56,57,58,59,60)
		where p5.storeId = @StoreId) as y5,
		(select sum(r6.TotalSales) from sls_royalty_period p6 
		inner join sls_Royalty_Report r6 on r6.RoyaltyPeriodId = p6.RoyaltyPeriodID and r6.OperatingMonth in (61,62,63,64,65,66,67,68,69,70,71,72) 
		where p6.storeId = @StoreId) as y6,
		(select sum(r7.TotalSales) from sls_royalty_period p7 
		inner join sls_Royalty_Report r7 on r7.RoyaltyPeriodId = p7.RoyaltyPeriodID and r7.OperatingMonth in (73,74,75,76,77,78,79,80,81,82,83,84)
		where p7.storeId = @StoreId) as y7,
		(select sum(r8.TotalSales) from sls_royalty_period p8 
		inner join sls_Royalty_Report r8 on r8.RoyaltyPeriodId = p8.RoyaltyPeriodID and r8.OperatingMonth in (85,86,87,88,89,90,91,92,93,94,95,96)
		where p8.storeId = @StoreId) as y8,
		(select sum(r9.TotalSales) from sls_royalty_period p9 
		inner join sls_Royalty_Report r9 on r9.RoyaltyPeriodId = p9.RoyaltyPeriodID and r9.OperatingMonth in (97,98,99,100,101,102,103,104,105,106,107,108)
		where p9.storeId = @StoreId) as y9,	 
		(select sum(r10.TotalSales) from sls_royalty_period p10 
		inner join sls_Royalty_Report r10 on r10.RoyaltyPeriodId = p10.RoyaltyPeriodID and r10.OperatingMonth in (109,110,111,112,113,114,115,116,117,118,119,120)
		where p10.storeId = @StoreId) as y10,
		(select sum(r11.TotalSales) from sls_royalty_period p11 
		inner join sls_Royalty_Report r11 on r11.RoyaltyPeriodId = p11.RoyaltyPeriodID and r11.OperatingMonth in (121,122,123,124,125,126,127,128,129,130,131,132)
		where p11.storeId = @StoreId) as y11,
		(select sum(r12.TotalSales) from sls_royalty_period p12 
		inner join sls_Royalty_Report r12 on r12.RoyaltyPeriodId = p12.RoyaltyPeriodID and r12.OperatingMonth in (133,134,135,136,137,138,139,140,141,142,143,144)
		where p12.storeId = @StoreId) as y12,
		(select sum(r13.TotalSales) from sls_royalty_period p13 
		inner join sls_Royalty_Report r13 on r13.RoyaltyPeriodId = p13.RoyaltyPeriodID and r13.OperatingMonth in (145,146,147,148,149,150,151,152,153,154,155,156)
		where p13.storeId = @StoreId) as y13,
		(select sum(r14.TotalSales) from sls_royalty_period p14 
		inner join sls_Royalty_Report r14 on r14.RoyaltyPeriodId = p14.RoyaltyPeriodID and r14.OperatingMonth in (157,158,159,160,161,162,163,164,165,166,167,168)
		where p14.storeId = @StoreId) as y14,
		(select sum(r15.TotalSales) from sls_royalty_period p15 
		inner join sls_Royalty_Report r15 on r15.RoyaltyPeriodId = p15.RoyaltyPeriodID and r15.OperatingMonth in (169,170,171,172,173,174,175,176,177,178,179,180)
		where p15.storeId = @StoreId) as y15,
		(select sum(r16.TotalSales) from sls_royalty_period p16 
		inner join sls_Royalty_Report r16 on r16.RoyaltyPeriodId = p16.RoyaltyPeriodID and r16.OperatingMonth in (181,182,183,184,185,186,187,188,189,190,191,192)
		where p16.storeId = @StoreId) as y16,
		(select sum(r17.TotalSales) from sls_royalty_period p17 
		inner join sls_Royalty_Report r17 on r17.RoyaltyPeriodId = p17.RoyaltyPeriodID and r17.OperatingMonth in (193,194,195,196,197,198,199,200,201,202,203,204)
		where p17.storeId = @StoreId) as y17,
		(select sum(r18.TotalSales) from sls_royalty_period p18 
		inner join sls_Royalty_Report r18 on r18.RoyaltyPeriodId = p18.RoyaltyPeriodID and r18.OperatingMonth in (205,206,207,208,209,210,211,212,213,214,215,216)
		where p18.storeId = @StoreId) as y18,
		(select sum(r19.TotalSales) from sls_royalty_period p19 
		inner join sls_Royalty_Report r19 on r19.RoyaltyPeriodId = p19.RoyaltyPeriodID and r19.OperatingMonth in (217,218,219,220,221,222,223,224,225,226,227,228)
		where p19.storeId = @StoreId) as y19,
		(select sum(r20.TotalSales) from sls_royalty_period p20 
		inner join sls_Royalty_Report r20 on r20.RoyaltyPeriodId = p20.RoyaltyPeriodID and r20.OperatingMonth in (229,230,231,232,233,234,235,236,237,238,239,240)
		where p20.storeId = @StoreId) as y20

		from cor_stores s
		where s.storeId = @StoreId

		FETCH NEXT FROM stores
		INTO @StoreId, @StoreNumber, @StoreOpenDate
	END
	CLOSE stores
DEALLOCATE stores


select p.FirstName, p.LastName,
(
select top 1 (p.FirstName + ' ' + p.LastName) from cor_persons p
inner join cor_stores_persons_link l on l.PersonID = p.PersonId
where l.StoreId = op.StoreId and p.PersonType = 2006
) 
as director,
(
select top 1 (p.FirstName + ' ' + p.LastName) from cor_persons p
inner join cor_stores_persons_link l on l.PersonID = p.PersonId
where l.StoreId = op.StoreId and p.PersonType = 2005
) 
as fbc,--(isnull(m1,0)+isnull(m2,0)+isnull(m3,0)+isnull(m4,0)+isnull(m5,0)+isnull(m6,0)+isnull(m7,0)+isnull(m8,0)+isnull(m9,0)+isnull(m10,0)+isnull(m11,0)+isnull(m12,0)+isnull(m13,0)+isnull(m14,0)+isnull(m15,0)+isnull(m16,0)+isnull(m17,0)+isnull(m18,0)+isnull(m19,0)+isnull(m20,0)+isnull(m21,0)+isnull(m22,0)+isnull(m23,0)+isnull(m24,0)),
op.*,c.* from #opYears op
left outer join cor_stores_persons_link l on op.StoreId = l.StoreId
left outer join cor_persons p on l.personId = p.personId
inner join cor_stores c on c.StoreId = op.StoreId
where l.GoldMinePlacement = 0
and (c.status = 1 or c.status = @sstatus)
and (isnull(y1,0)+isnull(y2,0)+isnull(y3,0)+isnull(y4,0)+isnull(y5,0)+isnull(y6,0)+isnull(y7,0)+isnull(y8,0)+isnull(y9,0)+isnull(y10,0)
	 +isnull(y11,0)+isnull(y12,0)+isnull(y13,0)+isnull(y14,0)+isnull(y15,0)+isnull(y16,0)+isnull(y17,0)+isnull(y18,0)+isnull(y19,0)+isnull(y20,0)>0)
order by op.StoreNumber

drop table #opYears

--end procedure 
END



GO
