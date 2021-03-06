/****** Object:  StoredProcedure [dbo].[ARByStorePeriod2]    Script Date: 5/15/2018 12:09:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ARByStorePeriod2](@storenumber varchar(40),@delinquent varchar(1), @storerange1 varchar(40), @storerange2 varchar(40),
@director varchar(400), @fbc varchar(400),@date1 varchar(40), @date2 varchar(40), @country varchar(100))
as
BEGIN
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
--Set @storenumber='510501'
--select @country = 'Canada'
--select @director =  'All'
--select @fbc = 'All'
--select @delinquent = 1
--Set @date1 = '1/1/2007'
--Set @date2 = '12/31/2007'

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

--picked fbc
if @fbc = 'All'
begin
   set @fbc = '%'
end
--picked director
if @director = 'All'
begin
    set @director = '%'
end
print 'director: ' + @director
print 'fbc: ' + @fbc


declare @curDateFirst datetime,@curDateLast datetime

set @curDateLast = dateadd(m, datediff(m, 0, dateadd(m, 1, GetDate())), -1)
print @curDateLast
set @curDateFirst =  dateadd(m, datediff(m, 0, GetDate()), 0)
print @curDateFirst

DECLARE @OriginalQuery TABLE
(	
	GroupNumber int,
	RoyaltyPeriodID int,
	STORE int,
	[Owner] varchar(100),
    Director varchar(100),
    FBC varchar(100),
	DATE datetime,
	REP varchar(20),
	ACTUAL float,
	FIIROYALTY float,
	FIIREDUCTION float,
	FIIDUE float,
	FIIPAID float,
	FIIBALANCE float,
	NACROYALTY float,
	NACREDUCTION float,
	NACDUE float,
	NACPAID float,
	NACBALANCE float,
	PMT_DATE datetime,
	CHK varchar(50),
	AMT float,
	Company varchar(3)
)

Insert Into @OriginalQuery
select  
		header.GroupNumber,
		header.RoyaltyPeriodID,
		header.storeNumber,
		header.Owner,
		header.Director,
        header.FBC,
		header.endDate as DATE,
		header.reportNumber as REP,
		header.totalSales as ACTUAL,
		header.FIIRoyalty as FIIROYALTY,
		isnull(header.FIIReduction,0) as FIIREDUCTION,
		(header.FIIRoyalty + isnull(header.FIIReduction,0)) as FIIDUE,
		isnull(header.FIIPaid,0) as FIIPAID,
		isnull(header.FIIDue,0) as FIIBALANCE,
		header.NACRoyalty as NACROYALTY,
		isnull(header.NACReduction,0) as NACREDUCTION,
		(header.NACRoyalty + isnull(header.NACReduction,0)) as NACDUE,
		isnull(header.NACPaid,0)  as NACPAID,
		isnull(header.NACDue,0) as NACBALANCE,
		payment.RoyaltyPaymentReceived as PMT_DATE,
		isnull(payment.ReferenceNo, paymenttype.name) as CHK,
		distribution.Amount as AMT,
		paymentCompany.fullname as Company
	From
	(
		Select	ROW_NUMBER() OVER (ORDER BY innerHeader.StoreNumber, innerHeader.royaltyperiodid, innerHeader.TotalSales) as GroupNumber,
				innerHeader.StoreNumber,
				innerHeader.WebNumber,
				innerHeader.Owner,
				innerHeader.FBC,
				innerHeader.Director,
				innerHeader.RoyaltyPeriodID,
				innerHeader.EndDate,
				innerHeader.RoyaltyReportID,
				innerHeader.TotalSales,
				innerHeader.ReportNumber,
				innerHeader.DateReceived,
				innerHeader.FIIDue,
				innerHeader.NACDue,
				innerHeader.FIIRoyalty,
				innerHeader.NACRoyalty,
				innerHeader.FIIReduction,
				innerHeader.NACReduction,
				SUM(CASE WHEN paymentCompany.FullName = 'FII' THEN paid.Amount ELSE 0 END) AS FIIPAID,
				SUM(CASE WHEN paymentCompany.FullName = 'NAC' THEN paid.Amount ELSE 0 END) AS NACPAID
			From 
			(
				Select
					cs.StoreNumber, 
					cs.WebNumber, 
					dbo.GetStoreOwner(cs.StoreID) as [Owner],
					dbo.GetStoreFBC(cs.StoreID) as [FBC],
					dbo.GetStoreDirector(cs.StoreID) as [Director],
					srp.RoyaltyPeriodID,
					srp.EndDate,
					srr.RoyaltyReportID,
					srr.TotalSales,
					srr.ReportNumber,
					srr.DateReceived,
					srr.FIIDue,
					srr.NACDue,
					(royalty.AllocationAmount*royalty.FIIPercent) AS FIIROYALTY,				
					(royalty.AllocationAmount*royalty.NACPercent) AS NACROYALTY,
					Sum(reduction.FIIAmount) as FIIReduction,
					Sum(reduction.NACAmount) as NACReduction	
				From COR_STORES cs
					inner join SLS_ROYALTY_PERIOD srp
						on cs.StoreID = srp.StoreID
							and ((@date1 is null) or (srp.EndDate >= @date1))
							and ((@date2 is null) or (srp.EndDate <= @date2))
					inner join SLS_ROYALTY_REPORT srr
						on srp.RoyaltyPeriodID = srr.RoyaltyPeriodID
					inner join SLS_ROYALTY_ALLOCATION royalty
						on srr.RoyaltyReportID = royalty.RoyaltyReportID
						and royalty.RoyaltyAllocationType = 2
					left outer join SLS_ROYALTY_ALLOCATION reduction
						on srr.RoyaltyReportID = reduction.RoyaltyReportID
						and reduction.RoyaltyAllocationType != 2
					Where ((@storenumber is null) or (cs.storeNumber=@storenumber))
						and ((@storeRange1 is null) or (cs.storeNumber>=@storeRange1))
						and ((@storeRange2 is null) or (cs.storeNumber<=@storeRange2))
						and ((@date1 is null) or (srp.EndDate >= @date1))
						and ((@date2 is null) or (srp.EndDate <= @date2))
						and ((@country is null) or (dbo.GetStoreInternationalRegion(cs.StoreID) = @country) or (@storenumber is not null))
					Group By
						cs.StoreID,
						cs.StoreNumber, 
						cs.WebNumber, 
						srp.RoyaltyPeriodID,
						srp.EndDate,
						srr.RoyaltyReportID,
						srr.TotalSales,
						srr.ReportNumber,
						srr.DateReceived,
						srr.FIIDue,
						srr.NACDue,
						royalty.AllocationAmount,
						royalty.FIIPercent,
						royalty.NACPercent
				) innerHeader
				left outer join SLS_ROYALTY_DISTRIBUTION paid
					on innerHeader.RoyaltyPeriodID = paid.RoyaltyPeriodID
				left outer join SLS_ROYALTY_COMPANY_TYPES paymentCompany
					on paid.RoyaltyCompanyType = paymentCompany.RoyaltyCompanyType
			Group By
				innerHeader.StoreNumber, 
				innerHeader.WebNumber,
				innerHeader.Owner,
				innerHeader.FBC,
				innerHeader.Director, 
				innerHeader.RoyaltyPeriodID,
				innerHeader.EndDate,
				innerHeader.RoyaltyReportID,
				innerHeader.TotalSales,
				innerHeader.ReportNumber,
				innerHeader.DateReceived,
				innerHeader.FIIDue,
				innerHeader.NACDue,
				innerHeader.FIIRoyalty,
				innerHeader.NACRoyalty,
				innerHeader.FIIReduction,
				innerHeader.NACReduction
	) header
	left outer join SLS_ROYALTY_DISTRIBUTION distribution
		on header.RoyaltyPeriodID = distribution.RoyaltyPeriodID
	left outer join SLS_ROYALTY_PAYMENT payment
		ON distribution.RoyaltyPaymentID = payment.RoyaltyPaymentID
	left outer join SLS_ROYALTY_PAYMENT_Type paymenttype
		ON paymenttype.RoyaltyPaymentType = payment.RoyaltyPaymentType
	left outer join SLS_ROYALTY_COMPANY_TYPES paymentCompany
		on distribution.RoyaltyCompanyType = paymentCompany.RoyaltyCompanyType
	where 
		(
			(@delinquent = 0) or 
			(
				((FIIDue != 0) or (NACDue != 0)
					or (NACPAID is null and (NACROYALTY + (case when NACReduction is null then 0 else NACReduction end)) != 0)
					or (FIIPAID is null and (FIIROYALTY + (case when FIIReduction is null then 0 else FIIReduction end)) != 0) 
	 				or (TotalSales = 0) or (TotalSales is null))
				and (EndDate not between @curDateFirst and @curDateLast) 
				and (isnull(ReportNumber,'') != 'N/A') 
				and (isnull(ReportNumber,'') != 'NEW')
			)
		)
		and FBC like @fbc
		and Director Like @Director
order by GroupNumber, payment.RoyaltyPaymentReceived

Update @OriginalQuery
	Set ACTUAL = null, FIIROYALTY=null, FIIREDUCTION=null,
					FIIDUE=null, FIIPAID=null, FIIBALANCE=null, NACROYALTY=null,
					NACREDUCTION=null, NACDUE=null, NACPAID=null, NACBALANCE=null
	Where REP is null;

--Cursor logic to clean up the data we need

DECLARE @PreviousGroupNumber int
Set @PreviousGroupNumber = 0
DECLARE Royalty_Cursor Cursor 
FOR 
	WITH [ORIGINAL_GROUPNUMBER] AS
		(SELECT ROW_NUMBER() OVER (ORDER BY STORE, ACTUAL, PMT_DATE) AS ROWID, * FROM @OriginalQuery)
		Select ROWID, GroupNumber from [ORIGINAL_GROUPNUMBER]
Open Royalty_Cursor
Declare @RowId int,@GroupNumber int
Fetch NEXT FROM Royalty_Cursor INTO @RowId, @GroupNumber
While (@@FETCH_STATUS <> -1)
BEGIN
	--Perform the update
	IF (@PreviousGroupNumber = @GroupNumber) 
	BEGIN
		--Already have one, do the update for this record
		WITH [ORIGINAL_GROUPNUMBER] AS
			(SELECT ROW_NUMBER() OVER (ORDER BY store, actual, PMT_DATE) AS ROWID, * FROM @OriginalQuery)
			Update [ORIGINAL_GROUPNUMBER]
				Set [Owner] = null, REP=null,
					Director=null, FBC=null, DATE = null,
					ACTUAL = null, FIIROYALTY=null, FIIREDUCTION=null,
					FIIDUE=null, FIIPAID=null, FIIBALANCE=null, NACROYALTY=null,
					NACREDUCTION=null, NACDUE=null, NACPAID=null, NACBALANCE=null
				Where ROWID=@RowId
	END
	Set @PreviousGroupNumber = @GroupNumber
	FETCH NEXT FROM Royalty_Cursor INTO @RowId, @GroupNumber 
END
CLOSE Royalty_Cursor
DEALLOCATE Royalty_Cursor

select * from @OriginalQuery order by GroupNumber, [Owner] desc,  PMT_DATE

END


GO
