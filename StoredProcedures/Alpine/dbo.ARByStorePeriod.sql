/****** Object:  StoredProcedure [dbo].[ARByStorePeriod]    Script Date: 5/15/2018 12:09:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ARByStorePeriod](@storenumber varchar(40),@delinquent varchar(1), @storerange1 varchar(40), @storerange2 varchar(40),
@director varchar(400), @fbc varchar(400),@date1 varchar(40), @date2 varchar(40), @country varchar(100))
as
BEGIN
	--BACKUP LOG storeadditionalinfo WITH TRUNCATE_ONLY

--declare @storenumber varchar(40)
--declare @delinquent bit
--declare @storerange1 varchar(40)
--declare @storerange2 varchar(40)
--declare @director varchar(400)
--declare @fbc varchar(400)
--declare @date1 datetime
--declare @date2 datetime
--declare @country varchar(100)
--
--select @country = 'USA'
--select @director =  'All'
--select @fbc = 'All'
--select @delinquent = 1
--Set @date1 = '6/1/2007'
--Set @date2 = '7/1/2007'

if @storenumber = ''
   select @storenumber = null
if @storerange1 = ''
   select @storerange1 = null
if @storerange2 = ''
   select @storerange2 = null
if @date1 = ''
   select @date1 = null
if @date2 = ''
   select @date2 = null

if object_id('tempdb..#table1') is not null
	drop table #table1
if object_id('tempdb..#table2') is not null
	drop table #table2
if object_id('tempdb..#table3') is not null
	drop table #table3
if object_id('tempdb..#table4') is not null
	drop table #table4
if object_id('tempdb..#table5') is not null
	drop table #table5
/*
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#table1]') AND type in (N'U'))
drop table #table1
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#table2]') AND type in (N'U'))
drop table #table2
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[#table3]') AND type in (N'U'))
drop table #table3
*/

--don't care
if @director = 'All' and @fbc = 'All'
begin
	select @director = '%'
    select @fbc = '%'
end
else
--picked fbc
if @director = 'All' and @fbc != 'All'
begin
    select @director = 'nope'
	--select @fbc = '%'
end
else
--picked director
if @director != 'All' and @fbc = 'All'
begin
    --select @director = '%'
	select @fbc = 'nope'
end
print @director
print @fbc


declare @curDateFirst datetime,@curDateLast datetime

set @curDateLast = dateadd(m, datediff(m, 0, dateadd(m, 1, GetDate())), -1)
--print @curDateLast
set @curDateFirst =  dateadd(m, datediff(m, 0, GetDate()), 0)
--print @curDateFirst
create table #table1 (	groupnumber int,
						royaltyperiodid int,
						royaltyreportid int,
						storeNumber int,
						owner varchar(255),
                        director varchar(255),
                        fbc varchar(255),
						endDate datetime,
						reportNumber varchar(255),
						totalSales float,
						FIIDue float,
						NACDue float,
						FIIRoyalty float,
						NACRoyalty float,
                        AllAmt float,
						City varchar(128),
						State varchar(50),
						openDate DateTime,
						resaleDate DateTime,
						twoYearsAgoSales float,
						lastYearSales float,
						lastYearYearToDate float,
						thisYearYearToDate float)

create table #table2 (	royaltyperiodid int,
						royaltyreportid int,
						FIIReduction float,
						NACReduction float)

create table #table3 (	royaltyperiodid int,
						royaltyreportid int,
						FIIPaid float,
						NACPaid float)
					
create table #table5 (	royaltyperiodid int,
						PMT_DATE datetime,
						CHK varchar(25),
						AMT float,
						Company varchar(255),
						Name varchar(255))

insert into #table1(groupnumber,royaltyperiodid,endDate,
					royaltyreportid,reportNumber,totalSales,FIIDue,NACDue,
					storeNumber,owner,fbc,director,
					FIIRoyalty,NACRoyalty,AllAmt,City,State,openDate,resaleDate,twoYearsAgoSales,
					lastYearSales,lastYearYearToDate,thisYearYearToDate)
SELECT	ROW_NUMBER() OVER (ORDER BY cs.StoreNumber, srp.royaltyperiodid, srr.TotalSales),
		srp.royaltyperiodid,
		srp.EndDate,
		srr.royaltyreportid,
		srr.ReportNumber, 
		srr.TotalSales,
		srr.FIIDue,
		srr.NACDue,
		cs.StoreNumber,
                     
		
		(select top 1 cp2.firstName + ' ' + cp2.lastName  from cor_stores cs2 (NOLOCK)
             inner join cor_stores_persons_link cpl2 (NOLOCK) on cs2.storeid = cpl2.storeid
             inner join cor_persons cp2 (NOLOCK) on cpl2.personid = cp2.personid
             where cs.storeNumber = cs2.storeNumber and cpl2.goldmineplacement = 0) as Owner,

		(select top 1 FirstName + ' ' + LastName 
         from cor_stores_persons_link cs2 (NOLOCK)
         inner join cor_stores css (NOLOCK) on cs2.StoreId = css.StoreId 
         inner join cor_persons cp (NOLOCK) on cs2.PersonID = cp.PersonID 
         where css.StoreNumber = cs.StoreNumber
		 and cp.PersonType = 2005) as FBC,

		(select top 1 FirstName + ' ' + LastName 
         from cor_stores_persons_link cs2 (NOLOCK)
         inner join cor_stores css (NOLOCK) on cs2.StoreId = css.StoreId 
         inner join cor_persons cp (NOLOCK) on cs2.PersonID = cp.PersonID 
         where css.StoreNumber = cs.StoreNumber
		 and cp.PersonType = 2006) as Director,
		
		(sra.AllocationAmount*sra.FIIPercent) AS FIIROYALTY,
				
		(sra.AllocationAmount*sra.NACPercent) AS NACROYALTY,
                                sra.AllocationAmount as AllAmt,
		ca.City,
		cpd.ShortName AS State,
		cs.StoreOpenDate as [openDate],
		(select top 1 csd.begindate
		FROM	COR_STORES AS cs  (NOLOCK)
		INNER JOIN COR_STORE_DATES as csd (NOLOCK) on cs.StoreID = csd.StoreID
		where cs.StoreID = @storeNumber and csd.beginstatus = 3004
		order by csd.begindate desc) as [resaleDate],

		(select sum(srr.TotalSales)
		FROM	COR_STORES AS cs  (NOLOCK)
		INNER JOIN SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID 
		INNER JOIN SLS_ROYALTY_REPORT AS srr (NOLOCK) ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID 
		WHERE	cs.StoreNumber = @storeNumber and year(srp.startdate) = (year(getdate()) - 2)) as  'twoYearsAgoSales',

		(select sum(srr.TotalSales)
		FROM	COR_STORES AS cs  (NOLOCK)
		INNER JOIN SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID 
		INNER JOIN SLS_ROYALTY_REPORT AS srr (NOLOCK) ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID 		
		WHERE cs.StoreNumber = @storeNumber and  year(srp.startdate) = (year(getdate()) - 1)) as  'lastYearSales',

		(select sum(srr.TotalSales)
		FROM	COR_STORES AS cs  (NOLOCK)
		INNER JOIN SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID 
		INNER JOIN SLS_ROYALTY_REPORT AS srr (NOLOCK) ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID 		
		WHERE cs.StoreNumber = @storeNumber and  year(srp.startdate) = year(getdate()) - 1 and month(srp.startdate) < month(getdate())) as 'lastYearYearToDate',

		(select sum(srr.TotalSales)
		FROM	COR_STORES AS cs (NOLOCK)
		INNER JOIN SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID
		INNER JOIN SLS_ROYALTY_REPORT AS srr (NOLOCK) ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID
		WHERE cs.StoreNumber = @storeNumber and  year(srp.startdate) = year(getdate()) and month(srp.startdate) < month(getdate())) as 'thisYearYearToDate'
		
FROM	COR_STORES AS cs (NOLOCK) INNER JOIN
        SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID INNER JOIN
        SLS_ROYALTY_REPORT AS srr (NOLOCK) ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID INNER JOIN
        SLS_ROYALTY_ALLOCATION AS sra (NOLOCK) ON srr.RoyaltyReportID = sra.RoyaltyReportID inner join
		COR_STORES_ADDRESSES_LINK AS cral (NOLOCK) on cs.storeid = cral.storeid inner join
		COR_ADDRESSES ca (NOLOCK) on cral.addressid = ca.addressid inner join
		COR_POLITICAL_DIVISION cpd (NOLOCK) on ca.politicaldivisionid = cpd.politicaldivisionid inner join
		COR_COUNTRIES cc (NOLOCK) on cpd.Countryid = cc.countryid inner join
		COR_INTERNATIONAL_REGIONS cr (NOLOCK) on cc.internationalregionid = cr.internationalregionid

WHERE	1=case	
			when (@storeNumber is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber = @storeNumber) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange1 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber >= @storeRange1) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange2 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber <= @storeRange2) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@date1 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate >= @date1) 
							then 1
							else 0
					end 
			end
		 
		and
		1=case	
			when (@date2 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate <= @date2) 
							then 1
							else 0
					end 
			end

		and
		1=case when (@storeNumber is not null) 
			then 1 
				else	
					case 
						when (cr.FullName = @country) 
							then 1
							else 0
					end 
			end

		and
		sra.royaltyallocationtype = 2



--select * from #table1
						
insert into #table2(royaltyperiodid,royaltyreportid,FIIReduction,NACReduction)
SELECT	srp.royaltyperiodid,
		srr.royaltyreportid,
		
		sum(CASE 
			WHEN sra.RoyaltyAllocationType != 2 
				THEN 
					sra.FIIAmount					
				ELSE 0 
			END)  as  FIIReduction,
		sum(CASE 
			WHEN sra.RoyaltyAllocationType != 2 
				THEN 
					sra.NACAmount					
				ELSE 0 
			END)  as  NACReduction
		
FROM	COR_STORES AS cs (NOLOCK) INNER JOIN
        SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID INNER JOIN
        SLS_ROYALTY_REPORT AS srr (NOLOCK) ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID INNER JOIN
        SLS_ROYALTY_ALLOCATION AS sra (NOLOCK) ON srr.RoyaltyReportID = sra.RoyaltyReportID INNER JOIN
		COR_STORES_ADDRESSES_LINK AS cral (NOLOCK) on cs.storeid = cral.storeid inner join
		COR_ADDRESSES ca (NOLOCK) on cral.addressid = ca.addressid inner join
		COR_POLITICAL_DIVISION cpd (NOLOCK) on ca.politicaldivisionid = cpd.politicaldivisionid inner join
		COR_COUNTRIES cc (NOLOCK) on cpd.Countryid = cc.countryid inner join
		COR_INTERNATIONAL_REGIONS cr (NOLOCK) on cc.internationalregionid = cr.internationalregionid

WHERE	1=case	
			when (@storeNumber is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber = @storeNumber) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange1 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber >= @storeRange1) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange2 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber <= @storeRange2) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@date1 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate >= @date1) 
							then 1
							else 0
					end 
			end
		 
		and
		1=case	
			when (@date2 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate <= @date2) 
							then 1
							else 0
					end 
			end

		and
		1=case when (@storeNumber is not null) 
			then 1 
				else	
					case 
						when (cr.FullName = @country) 
							then 1
							else 0
					end 
			end

		and
		sra.royaltyallocationtype != 2

group by	srp.royaltyperiodid,
			srr.royaltyreportid

--select * from #table2

insert into #table3(royaltyperiodid,royaltyreportid,FIIPaid,NACPaid)
SELECT	srp.royaltyperiodid,
		srr.royaltyreportid,	
		SUM(CASE WHEN srct.FullName = 'FII' THEN srd.Amount ELSE 0 END) AS FIIPAID,
		SUM(CASE WHEN srct.FullName = 'NAC' THEN srd.Amount ELSE 0 END) AS NACPAID

FROM	COR_STORES AS cs (NOLOCK) INNER JOIN
        SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID INNER JOIN
        SLS_ROYALTY_REPORT AS srr (NOLOCK) ON srp.RoyaltyPeriodID = srr.RoyaltyPeriodID INNER JOIN
        SLS_ROYALTY_DISTRIBUTION AS srd (NOLOCK) ON srp.RoyaltyPeriodID = srd.RoyaltyPeriodID INNER JOIN
        SLS_ROYALTY_PAYMENT AS srpa (NOLOCK) ON srd.RoyaltyPaymentID = srpa.RoyaltyPaymentID INNER JOIN
		SLS_ROYALTY_COMPANY_TYPES AS srct (NOLOCK) ON srd.RoyaltyCompanyType = srct.RoyaltyCompanyType INNER JOIN
		COR_STORES_ADDRESSES_LINK AS cral (NOLOCK) on cs.storeid = cral.storeid inner join
		COR_ADDRESSES ca (NOLOCK) on cral.addressid = ca.addressid inner join
		COR_POLITICAL_DIVISION cpd (NOLOCK) on ca.politicaldivisionid = cpd.politicaldivisionid inner join
		COR_COUNTRIES cc (NOLOCK) on cpd.Countryid = cc.countryid inner join
		COR_INTERNATIONAL_REGIONS cr (NOLOCK) on cc.internationalregionid = cr.internationalregionid

WHERE	1=case	
			when (@storeNumber is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber = @storeNumber) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange1 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber >= @storeRange1) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange2 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber <= @storeRange2) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@date1 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate >= @date1) 
							then 1
							else 0
					end 
			end
		 
		and
		1=case	
			when (@date2 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate <= @date2) 
							then 1
							else 0
					end 
			end

		and
		1=case when (@storeNumber is not null) 
			then 1 
				else	
					case 
						when (cr.FullName = @country) 
							then 1
							else 0
					end 
			end

Group BY	srp.royaltyperiodid,
			srr.royaltyreportid
--select * From #table3
--print @curDateFirst 
--print @curDateLast

insert into #table5(royaltyperiodid, PMT_DATE, CHK, AMT, Company, Name)
select    srd.royaltyperiodid, srpa.RoyaltyPaymentReceived as PMT_DATE,
             srpa.ReferenceNo as CHK,
             srd.Amount as AMT,
             cct.fullname as Company,
             srpt.Name

from  COR_STORES AS cs (NOLOCK)
INNER JOIN SLS_ROYALTY_PERIOD AS srp (NOLOCK) ON cs.StoreID = srp.StoreID
INNER JOIN SLS_ROYALTY_DISTRIBUTION AS srd (NOLOCK) ON  srp.RoyaltyPeriodID = srd.RoyaltyPeriodID
INNER JOIN SLS_ROYALTY_PAYMENT AS srpa (NOLOCK) ON srd.RoyaltyPaymentID = srpa.RoyaltyPaymentID
INNER JOIN SLS_ROYALTY_PAYMENT_TYPE as srpt (NOLOCK) on srpa.RoyaltyPaymentType = srpt.RoyaltyPaymentType
INNER JOIN SLS_ROYALTY_COMPANY_TYPES cct (NOLOCK) on srd.royaltycompanytype = cct.royaltycompanytype
INNER JOIN COR_STORES_ADDRESSES_LINK AS cral (NOLOCK) on cs.storeid = cral.storeid
INNER JOIN COR_ADDRESSES ca (NOLOCK) on cral.addressid = ca.addressid
INNER JOIN COR_POLITICAL_DIVISION cpd (NOLOCK) on ca.politicaldivisionid = cpd.politicaldivisionid
INNER JOIN COR_COUNTRIES cc (NOLOCK) on cpd.Countryid = cc.countryid
INNER JOIN COR_INTERNATIONAL_REGIONS cr (NOLOCK) on cc.internationalregionid = cr.internationalregionid
where
	1=case	
			when (@storeNumber is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber = @storeNumber) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange1 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber >= @storeRange1) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@storeRange2 is null) 
				then 1 
				else	
					case 
						when (cs.StoreNumber <= @storeRange2) 
							then 1
							else 0
					end 
			end

		and
		1=case	
			when (@date1 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate >= @date1) 
							then 1
							else 0
					end 
			end
		 
		and
		1=case	
			when (@date2 is null) 
				then 1 
				else	
					case 
						when (srp.EndDate <= @date2) 
							then 1
							else 0
					end 
			end

		and
		1=case when (@storeNumber is not null) 
			then 1 
				else	
					case 
						when (cr.FullName = @country) 
							then 1
							else 0
					end 
			end
order by cct.fullname
--select * from #table5

select	t1.groupnumber as GroupNumber,
		t1.royaltyperiodid as royaltyperiodid,
		t1.storeNumber as STORE,
		t1.owner,
		t1.city,
		t1.state,
		t1.openDate,
		t1.resaleDate,
		t1.twoYearsAgoSales,
		t1.lastYearSales,
		t1.lastYearYearToDate,
		t1.thisYearYearToDate,
		t1.director,
        t1.fbc,
		t1.endDate as DATE,
		t1.reportNumber as REP,
		t1.totalSales as ACTUAL,
		t1.FIIRoyalty as FIIROYALTY,
		(case when t2.FIIReduction is null then 0 else t2.FIIReduction end) as FIIREDUCTION,
		(t1.FIIRoyalty + (case when t2.FIIReduction is null then 0 else t2.FIIReduction end)) as FIIDUE,
		(case when t3.FIIPaid is null then 0 else t3.FIIPaid end)  as FIIPAID,
		(case when t1.FIIDue is null then 0 else t1.FIIDue end) as FIIBALANCE,
		t1.NACRoyalty as NACROYALTY,
		(case when t2.NACReduction is null then 0 else t2.NACReduction end) as NACREDUCTION,
		(t1.NACRoyalty + (case when t2.NACReduction is null then 0 else t2.NACReduction end)) as NACDUE,
		(case when t3.NACPaid is null then 0 else t3.NACPaid end)  as NACPAID,
		(case when t1.NACDue is null then 0 else t1.NACDue end) as NACBALANCE,
		t5.PMT_DATE,
		CHK,
		AMT,
		Company,
		Name
into #table4 from #table1 t1
left outer join #table2 t2 on t1.royaltyreportid = t2.royaltyreportid
left outer join #table3 t3 on t1.royaltyreportid = t3.royaltyreportid
left outer join #table5 t5 on t1.royaltyperiodid = t5.royaltyperiodid
where 
1=case when (@delinquent = 0) then 1 else
			case when (@delinquent = 1) 
					and 
					(
							(t1.FIIDue) != 0
	 					or 	(t1.NACDue) != 0
						or 	(t3.NACPaid is null and (t1.NACRoyalty + (case when t2.NACReduction is null then 0 else t2.NACReduction end)) != 0)
						or 	(t3.FIIPaid is null and (t1.FIIRoyalty + (case when t2.FIIReduction is null then 0 else t2.FIIReduction end)) != 0) 
	 					or  (t1.TotalSales = 0)
	 					or 	(t1.TotalSales is null)
                                                                                                
					)
					and (t1.endDate not between @curDateFirst and @curDateLast) 
					and ((isnull(t1.reportNumber,'') != 'N/A') and (isnull(t1.reportNumber,'') != 'NEW'))
				then 1 else 0 end
			end
and (t1.director like @director or t1.fbc like @fbc) 
order by t1.storeNumber,t1.royaltyperiodid

--Cursor logic to clean up the data we need

DECLARE @PreviousGroupNumber int
Set @PreviousGroupNumber = 0
DECLARE Royalty_Cursor Cursor 
FOR 
	WITH [table4 ordered by GroupNumber] AS
		(SELECT ROW_NUMBER() OVER (ORDER BY store, actual, PMT_DATE) AS ROWID, * FROM #table4)
		Select ROWID, GroupNumber from [table4 ordered by GroupNumber]
Open Royalty_Cursor
Declare @RowId int,@GroupNumber int
Fetch NEXT FROM Royalty_Cursor INTO @RowId, @GroupNumber
While (@@FETCH_STATUS <> -1)
BEGIN
	--Perform the update
	IF (@PreviousGroupNumber = @GroupNumber) 
	BEGIN
		--Already have one, do the update for this record
		WITH [table4 ordered by GroupNumber] AS
			(SELECT ROW_NUMBER() OVER (ORDER BY store, actual, PMT_DATE) AS ROWID, * FROM #table4)
			Update [table4 ordered by GroupNumber]
				Set owner = null, city=null, state=null,
					director=null, fbc=null,DATE = null,
					ACTUAL = 0, FIIROYALTY=0, FIIREDUCTION=0,
					FIIDUE=0, FIIPAID=0, FIIBALANCE=0, NACROYALTY=0,
					NACREDUCTION=0, NACDUE=0, NACPAID=0, NACBALANCE=0
				Where ROWID=@RowId
	END
	Set @PreviousGroupNumber = @GroupNumber
	FETCH NEXT FROM Royalty_Cursor INTO @RowId, @GroupNumber 
END
CLOSE Royalty_Cursor
DEALLOCATE Royalty_Cursor

select * from #table4 order by GroupNumber, Actual Desc




drop table #table1
drop table #table2
drop table #table3
drop table #table4
drop table #table5


END




GO
