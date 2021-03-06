/****** Object:  StoredProcedure [dbo].[sp_5YearlySalesAfterOpen]    Script Date: 5/15/2018 12:09:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


/*********************************************
*
* new stored procedure - yearly sales after open
*
**********************************************/

create PROCEDURE [dbo].[sp_5YearlySalesAfterOpen]
@sstatus bit
AS
BEGIN
	
--declare @closed bit, @years smallint
--select @closed = 0


create table #opYears (
StoreId bigint, StoreNumber bigint, OpenDate datetime, yearColumn int,
y1 float, y2 float, y3 float, y4 float, y5 float,y6 float, y7 float, y8 float, y9 float, y10 float)


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
		where p10.storeId = @StoreId) as y10

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
and (isnull(y1,0)+isnull(y2,0)+isnull(y3,0)+isnull(y4,0)+isnull(y5,0)+isnull(y6,0)+isnull(y7,0)+isnull(y8,0)+isnull(y9,0)+isnull(y10,0)>0)
order by op.StoreNumber

drop table #opYears

--end procedure 
END


GO
