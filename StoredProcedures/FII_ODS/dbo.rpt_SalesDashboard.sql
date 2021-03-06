/****** Object:  StoredProcedure [dbo].[rpt_SalesDashboard]    Script Date: 5/15/2018 12:09:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[rpt_SalesDashboard]   /* was z360core_Rep_SalesDashboard */
(
@dateto datetime, 
@franchise varchar(7),
@OpenDate datetime,
@flip BIT
)
AS
BEGIN


--DECLARE @dateto DATETIME
--declare @franchise varchar(7)
--DECLARE @OpenDate DATETIME
--DECLARE @flip BIT
--SET @flip = 0
--SET @dateto = GETDATE()
--SET @franchise = 'fsi0096'   /* '10/15/1990' */

SET NOCOUNT ON;

 print 'begin: ' 
print convert(varchar(30),getdate()) + ':' +  convert(varchar(30),datepart(ss,getdate())) + + ':' +  convert(varchar(30),datepart(ms,getdate()))

declare @lastFinished datetime
declare @difference float
SET @lastFinished = getdate()

DECLARE @dailyCloseoutEnd DATETIME
DECLARE @dailyCloseoutStart  DATETIME
DECLARE @monthlyCloseout DATETIME
DECLARE @preMonthlyCloseout DATETIME
DECLARE @yearlyCloseout DATETIME
DECLARE @rolling12Start DATETIME
DECLARE @dailyCloseoutEndLY DATETIME
DECLARE @dailyCloseoutStartLY  DATETIME
DECLARE @monthlyCloseoutLY DATETIME
DECLARE @yearlyCloseoutLY DATETIME
DECLARE @rolling12StartLY DATETIME

DECLARE	@DaysInMonth FLOAT /* Float needed for currency division */

DECLARE @maxYear smallint
DECLARE @RollingTwelveDate DATETIME
declare @beginningOfMonth DATETIME
DECLARE @FractionOfMonth FLOAT
DECLARE @date DATETIME
DECLARE @dateLY datetime
DECLARE @datePLY DATETIME
DECLARE @loc VARCHAR(50)
DECLARE @Currency VARCHAR(5)




SELECT   @OpenDate=sf.[StoreOpenDate]
      , @loc=cd.CountryName
      , @Currency = CASE WHEN [CountryCode] = 'AU' THEN 'AUD $'
             WHEN [CountryCode] = 'BR' THEN 'BR'
             WHEN [CountryCode] = 'CA' THEN 'CA $'
             WHEN [CountryCode] = 'CO' THEN '$'
             WHEN [CountryCode] = 'MX' THEN 'MX'
             WHEN [CountryCode] = 'US' THEN '$'
             WHEN [CountryCode] = 'KY' THEN '$'
             WHEN [CountryCode] = 'SA' THEN '$'
             WHEN [CountryCode] = 'IN' THEN '$'
             WHEN [CountryCode] = 'GB' THEN 'GB £'
             ELSE '$'
        END  
FROM    [Store].[StoreFact] sf (NOLOCK)
        JOIN Store.CountryDim  (NOLOCK) AS cd ON cd.CountryKey = sf.CountryKey
WHERE [ZW_Franchise_ID] = @franchise

SET @date = dateadd(hh,-13, @dateto)

/*******/



/*****/

IF @flip = 0
BEGIN

 print 'begin: ' 
print convert(varchar(30),getdate()) + ':' +  convert(varchar(30),datepart(ss,getdate())) + + ':' +  convert(varchar(30),datepart(ms,getdate()))
SET @lastFinished = getdate()
--DECLARE @date datetime, @dateLY datetime, @datePLY datetime
SET @date = dateadd(hh,-13, @dateto)
Select @dailyCloseoutEnd= Coalesce(Max(CloseOutDate), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'D' AND CloseOutDate< @date and zw_franchise_id = @franchise
Select @dailyCloseoutStart = Coalesce(Max(CloseOutDate), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'D' and CloseOutDate< @dailyCloseoutEnd and zw_franchise_id = @franchise
Select @monthlyCloseout = Coalesce(Max(CloseOutDate), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'M' and CloseOutDate< @date and zw_franchise_id = @franchise
If datediff(dd, @monthlyCloseout, @dailyCloseoutEnd) < 1
	BEGIN 
		Select @monthlyCloseout = Coalesce(Max(CloseOutDate), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'M' and CloseOutDate< @monthlyCloseout and zw_franchise_id = @franchise
	END
Select @yearlyCloseout = Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'Y' and CloseOutDate < @date and zw_franchise_id = @franchise
Select @preMonthlyCloseout = Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'M' and CloseOutDate < @monthlyCloseout and zw_franchise_id = @franchise
SET @dateLY =  cast( month(@dailyCloseoutEnd) as varchar(2)) + '/' + cast(day(@dailyCloseoutEnd) as varchar(2)) + '/' + cast((year(@dailyCloseoutEnd)-1) as varchar(4)) + '  10:59:59' 
SET @datePLY =  cast( month(@dailyCloseoutEnd) as varchar(2)) + '/' + cast(day(@dailyCloseoutEnd) as varchar(2)) + '/' + cast((year(@dailyCloseoutEnd)-2) as varchar(4)) + '  10:59:59' 
Select @rolling12Start = Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'D' and CloseOutDate < @dateLY and zw_franchise_id = @franchise
Select @dailyCloseoutEndLY= Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'D' and CloseOutDate < @dateLY and zw_franchise_id = @franchise
Select @dailyCloseoutStartLY = Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'D' and CloseOutDate < @dailyCloseoutEndLY and zw_franchise_id = @franchise
Select @monthlyCloseoutLY = Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'M' and CloseOutDate < @dateLY and zw_franchise_id = @franchise
Select @yearlyCloseoutLY = Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'Y' and CloseOutDate < DATEADD(d, 0, DATEDIFF(d, 0, @yearlyCloseout)) and zw_franchise_id = @franchise
if year(@yearlyCloseoutLY) - year(@yearlyCloseout) =0
begin
set	@yearlyCloseoutLY = DATEADD(yy, -1, DATEDIFF(d, 0, @yearlyCloseout))	
end
Select @rolling12StartLY = Coalesce(Max( CloseOutDate ), '1/1/1900' ) FROM Orders.CloseOutFact  WHERE CloseoutType = 'D' and CloseOutDate < @datePLY  and zw_franchise_id = @franchise
--DECLARE	@DaysInMonth FLOAT /* Float needed for currency division */
SET @DaysInMonth = DAY(DATEADD(d, -DAY(DATEADD(m,1,@date)),DATEADD(m,1,@date)))
SET @RollingTwelveDate = DATEADD(year, -1, @date)
SET @beginningOfMonth = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@dailyCloseoutEnd)-1),@dailyCloseoutEnd),101)
SET @FractionOfMonth = convert(float,datediff(day,@monthlyCloseout,@dailyCloseoutEnd))/convert(float,@DaysInMonth)


end
/*********************/
      ELSE
	begin
	 print 'begin: ' 
print convert(varchar(30),getdate()) + ':' +  convert(varchar(30),datepart(ss,getdate())) + + ':' +  convert(varchar(30),datepart(ms,getdate()))
SET @lastFinished = getdate()
--DECLARE @date datetime, @dateLY datetime, @datePLY datetime
SET @date = dateadd(hh,-13, @dateto)
	
Select @dailyCloseoutEnd= Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact]  WHERE  PickedUpDate < @date and zw_franchise_id = @franchise
SELECT @dailyCloseoutEnd=dateadd(ms, -3, dateadd(day, datediff(day, 0, @dailyCloseoutEnd)+1, 0))


Select @dailyCloseoutStart = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE PickedUpDate  < @dailyCloseoutEnd and zw_franchise_id = @franchise
select @dailyCloseoutStart=dateadd(day, datediff(day, 0, @dailyCloseoutStart),0)


--Select @monthlyCloseout = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE  PickedUpDate  < @date and zw_franchise_id = @franchise
--If datediff(dd, @monthlyCloseout, @dailyCloseoutEnd) < 1
--	BEGIN 
--		Select @monthlyCloseout = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE  PickedUpDate  < @monthlyCloseout and zw_franchise_id = @franchise
--	END

--Select @yearlyCloseout = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE  PickedUpDate  < @date and zw_franchise_id = @franchise

--Select @preMonthlyCloseout = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE  PickedUpDate  < @monthlyCloseout and zw_franchise_id = @franchise

 SET @yearlyCloseout=DATEADD(MILLISECOND, -3, DATEADD(YEAR,
            DATEDIFF(YEAR, 0, DATEADD(YEAR, -1, @dateto)) + 1, 0))

SET @monthlyCloseout =DATEADD(MILLISECOND, -3, DATEADD(month,
            DATEDIFF(month, 0, DATEADD(month, -1, @dateto)) + 1, 0))    
SET @preMonthlyCloseout =DATEADD(MILLISECOND, -3, DATEADD(month,
            DATEDIFF(month, 0, DATEADD(month, -2, @dateto)) + 1, 0))   

 
SET @dateLY =  DATEADD(YEAR,-1,@dailyCloseoutEnd)
SET @datePLY =    DATEADD(YEAR,-2,@dailyCloseoutEnd)  
Select @rolling12Start = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE  PickedUpDate  < @dateLY and zw_franchise_id = @franchise


SELECT @dailyCloseoutEndLY=dateadd(year, -1, @dailyCloseoutEnd)
Select @dailyCloseoutStartLY=DATEADD(year, -1, @dailyCloseoutStart)

Select @monthlyCloseoutLY = DATEADD(year, -1, @monthlyCloseout)

Select @yearlyCloseoutLY = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE  PickedUpDate  < DATEADD(d, 0, DATEDIFF(d, 0, @yearlyCloseout)) and zw_franchise_id = @franchise
if year(@yearlyCloseoutLY) - year(@yearlyCloseout) =0
begin
set	@yearlyCloseoutLY = DATEADD(yy, -1, DATEDIFF(d, 0, @yearlyCloseout))	
end
Select @rolling12StartLY = Coalesce(Max( PickedUpDate ), '1/1/1900' ) FROM [Orders].[OrderHeaderFact] WHERE PickedUpDate  < @datePLY  and zw_franchise_id = @franchise
SET @DaysInMonth = DAY(DATEADD(d, -DAY(DATEADD(m,1,@date)),DATEADD(m,1,@date)))
SET @RollingTwelveDate = DATEADD(year, -1, @date)
set @beginningOfMonth = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@dailyCloseoutEnd)-1),@dailyCloseoutEnd),101)
SET @FractionOfMonth = convert(float,datediff(day,@monthlyCloseout,@dailyCloseoutEnd))/convert(float,@DaysInMonth)    

end
	/******/  

/***************/


--SET @DaysInMonth = DAY(DATEADD(d, -DAY(DATEADD(m,1,@date)),DATEADD(m,1,@date)))

--SET @RollingTwelveDate = DATEADD(year, -1, @date)

--set @beginningOfMonth = CONVERT(VARCHAR(25),DATEADD(dd,-(DAY(@dailyCloseoutEnd)-1),@dailyCloseoutEnd),101)

--SET @FractionOfMonth = convert(float,datediff(day,@monthlyCloseout,@dailyCloseoutEnd))/convert(float,@DaysInMonth)

/**************************************/

SELECT @maxYear = max(year) FROM Store.SalesGoalsFact AS sgf WHERE zw_franchise_id = @franchise and Year <= DATEPART(yy, getdate())



--IF year(@yearlyCloseoutLY)< (Year(@dateto)-2) and (year(@openDate) not in (Year(@date), Year(@date)-1) or year(@openDate) is null)
--    BEGIN
--			Select ('Through Date of Last Closeouts: ' + Convert(varchar(20),dateadd(hh, 13, @dailyCloseoutEnd)) + '(D) --- ' 
--			+ Convert(varchar(20),dateadd(hh, 13,@monthlyCloseout)) + '(M) --- '
--			+ Convert(varchar(20),dateadd(hh, 13, @yearlyCloseout)) + '(Y)') as DateUsed,
--			'1/1/1900' dateto, 
--			@dailyCloseoutStart dailyCloseoutStart, 
--			@dailyCloseoutEnd dailyCloseoutEnd, 
--			@monthlyCloseout monthlyCloseout,
--			@yearlyCloseoutLY
--        RETURN
--    END
IF year(@yearlyCloseoutLY)< (Year(@dateto)-2)  and Year(@openDate) in (Year(@date), Year(@date)-1)
	BEGIN
		IF year(@openDate) = Year(@date)
			BEGIN
				set @yearlyCloseout = DateAdd(dd, datename(dy,@Date)* -1, @date)
				set @yearlyCloseoutLY = DateAdd(yy, -1, @yearlyCloseout)
			END
		IF year(@openDate) = (Year(@date) - 1)
			BEGIN
				set @yearlyCloseoutLY = DateAdd(yy, -1, @yearlyCloseout)
			END
	END


/* CREATE TEMP TABLE FOR HOLDING CUSTOMER FIRST ORDER DATE*/
DECLARE @tFirstTimeCustomersYTD TABLE ( CustomerID int, FirstOrderDate datetime )
INSERT into @tFirstTimeCustomersYTD
SELECT customerID, COALESCE( min(OrderDate), '1900-01-01' )
FROM Orders.OrderHeaderFact AS ohf
WHERE zw_franchise_id = @franchise and statusKey <> 11 /*'voided'*/
GROUP BY customerID
HAVING COALESCE( min(OrderDate), '1900-01-01' ) >= @yearlyCloseoutLY

print 'end create temp'
PRINT ''

SET @difference = DATEDIFF(ms, @lastFinished, getdate() )
print CAST(@difference as varchar(7)) + ' milliseconds'
SET @lastFinished = getdate()

/* Use Temp Table to get count of YTD First Time Customers and Previous YTD too */
DECLARE @CustYTD int, @CustYTDLY int
SELECT 
	 @CustYTD = COUNT(CASE WHEN FirstOrderDate BETWEEN @yearlyCloseout AND @dailyCloseoutEnd THEN CustomerID END),
	@CustYTDLY = COUNT(CASE WHEN FirstOrderDate BETWEEN @yearlyCloseoutLY AND @dailyCloseoutEndLY THEN CustomerID END)
FROM @tFirstTimeCustomersYTD

-----------------------------------------------------------------

DECLARE @customercount TABLE ( CustomerID int, OrderID int)
declare @NoInvoicesYTD int, @NoInvoicesYTDLY int, @FirstOrderDate datetime, @SalesSubtotal money
DEclare @TotalInvoicesYTD money, @TotalInvoicesYTDLY money
DECLARE @overridesYTD int, @overridesYTDLY int, @orderOverrides int

SET @NoInvoicesYTD = 0
SET @NoInvoicesYTDLY = 0
SET @TotalInvoicesYTD = 0
SET @TotalInvoicesYTDLY = 0
SET @overridesYTD = 0
SET @overridesYTDLY = 0

DECLARE @OrderID INT
declare @customerID int

DECLARE ordercur CURSOR LOCAL  FAST_FORWARD FOR
select o.OrderId, o.CustomerId, o.SalesSubtotal
from Orders.OrderHeaderFact AS o
where  o.orderDate >= @yearlyCloseoutLY
and o.zw_franchise_id = @franchise

OPEN ordercur

FETCH NEXT FROM ordercur
INTO @OrderID, @customerID, @SalesSubtotal

WHILE @@FETCH_STATUS = 0
BEGIN
	/* must 'reset' this as the SELECT assignment doesn't seem to clear it out on its own */
	SET @FirstOrderDate = '1900-01-01'

	SELECT @FirstOrderDate = COALESCE(FirstOrderDate, '1900-01-01')
	FROM @tFirstTimeCustomersYTD
	WHERE customerID = @customerID

	SET @orderOverrides = 0
		
	IF( @FirstOrderDate BETWEEN @yearlyCloseoutLY AND @dailyCloseoutEnd ) 
	BEGIN
			SELECT @orderOverrides =
				SUM( CAST(BasePriceOverriden as tinyint) + CAST(OverRidden as tinyint) + CAST(AVOverridden as tinyint) )
			FROM Orders.OrderDetailFact AS odf 
			WHERE OrderID = @OrderID
			AND zw_franchise_id = @franchise
			GROUP BY OrderID OPTION (Fast 5)

			IF( @orderOverrides > 0)
				SET @orderOverrides = 1
	END

	IF( @FirstOrderDate BETWEEN @yearlyCloseout AND @dailyCloseoutEnd ) 
		BEGIN
			SET @NoInvoicesYTD = @NoInvoicesYTD + 1
			SET @TotalInvoicesYTD = @TotalInvoicesYTD + @SalesSubtotal
			SET @overridesYTD = @overridesYTD + @orderOverrides
		END
	ELSE IF( @FirstOrderDate BETWEEN @yearlyCloseoutLY AND @dailyCloseoutEndLY ) 
		BEGIN
			SET @NoInvoicesYTDLY = @NoInvoicesYTDLY + 1
			SET @TotalInvoicesYTDLY = @TotalInvoicesYTDLY + @SalesSubtotal
			SET @overridesYTDLY = @overridesYTDLY + @orderOverrides
		END

FETCH NEXT FROM ordercur
INTO @OrderID, @customerId, @SalesSubtotal
END

CLOSE ordercur

DEALLOCATE ordercur

PRINT ''
print 'finish order cursor'
SET @difference = DATEDIFF(ms, @lastFinished, getdate() )
print CAST(@difference as varchar(7)) + ' milliseconds'
SET @lastFinished = getdate()
PRINT ''


/*-----------------------------------------------------------------------------------------------------------------*/


SELECT * FROM
(
SELECT 
--('Through Date of Last Closeouts: ' + Convert(varchar(20),dateadd(hh, 12, @dailyCloseoutEnd)) + '(D) --- ' 
--+ Convert(varchar(20),dateadd(hh, 13,@monthlyCloseout)) + '(M) --- '
--+ Convert(varchar(20),dateadd(hh, 13, @yearlyCloseout)) + '(Y)') as DateUsed,

('Through Date of Last Closeouts: ' + Convert(varchar(20), @dailyCloseoutEnd) + '(D) --- ' 
+ Convert(varchar(20),@monthlyCloseout) + '(M) --- '
+ Convert(varchar(20), @yearlyCloseout) + '(Y)') as DateUsed,

@date dateto, 
@dailyCloseoutStart dailyCloseoutStart, 
@dailyCloseoutEnd dailyCloseoutEnd, 
@monthlyCloseout monthlyCloseout,
isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120)  and  TransactionDateTime between @dailyCloseoutStart and @dailyCloseoutEnd
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between @dailyCloseoutStart and @dailyCloseoutEnd
THEN Amount 
ELSE 0 END ),0) DailyPlacedAmount,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @monthlyCloseout and @dailyCloseoutEnd 
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between @monthlyCloseout and @dailyCloseoutEnd
	THEN Amount
ELSE 0 END ),0) TotalAmountPlacedMTD,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd 
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd
	THEN Amount
ELSE 0 END ),0) CurrentYTD,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between  @rolling12Start and @dailyCloseoutEnd 
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between  @rolling12Start and @dailyCloseoutEnd
	THEN Amount
ELSE 0 END ),0) CurrentRollingTwelve,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120)  and  TransactionDateTime between @dailyCloseoutStartLY and @dailyCloseoutEndLY
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between @dailyCloseoutStartLY and @dailyCloseoutEndLY
THEN Amount 
ELSE 0 END ),0) PreviousYearYesterday,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @monthlyCloseoutLY and @dailyCloseoutEndLY 
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between @monthlyCloseoutLY and @dailyCloseoutEndLY
	THEN Amount
ELSE 0 END ),0) PreviousYearMTD,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @yearlyCloseoutLY and @dailyCloseoutEndLY 
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between @yearlyCloseoutLY and @dailyCloseoutEndLY
	THEN Amount
ELSE 0 END ),0) PreviousYearYTD,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between  @rolling12StartLY and @dailyCloseoutEndLY 
THEN -Amount 
WHEN AccountCode IN (1250, 1260) and TransactionDateTime between  @rolling12StartLY and @dailyCloseoutEndLY
	THEN Amount
ELSE 0 END ),0) PreviousYearRollingTwelve,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120)  and  TransactionDateTime between @dailyCloseoutStart and @dailyCloseoutEnd
THEN -Amount 
ELSE 0 END ),0) DailyPickedUp,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @monthlyCloseout and @dailyCloseoutEnd 
THEN -Amount 
ELSE 0 END ),0) MTDPickedUp,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd 
THEN -Amount 
ELSE 0 END ),0) YTDPickedUp,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between  @rolling12Start and @dailyCloseoutEnd 
THEN -Amount 
ELSE 0 END ),0) R12PickedUp,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120)  and  TransactionDateTime between @dailyCloseoutStartLY and @dailyCloseoutEndLY
THEN -Amount 
ELSE 0 END ),0) DailyPickedUpLY,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @monthlyCloseoutLY and @dailyCloseoutEndLY 
THEN -Amount 
ELSE 0 END ),0) MTDPickedUpLY,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @yearlyCloseoutLY and @dailyCloseoutEndLY 
THEN -Amount 
ELSE 0 END ),0) YTDPickedUpLY,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between  @rolling12StartLY and @dailyCloseoutEndLY 
THEN -Amount 
ELSE 0 END ),0) R12PickedUpLY,


isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @dailyCloseoutStart and @dailyCloseoutEnd
THEN -Amount 
WHEN AccountCode IN (1260) and TransactionDateTime between @dailyCloseoutStart and @dailyCloseoutEnd
	THEN Amount
ELSE 0 END ),0) DailyBuiltAmount,

isnull(Sum( CASE WHEN AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @monthlyCloseout and @dailyCloseoutEnd
THEN -Amount 
WHEN AccountCode IN (1260) and TransactionDateTime between @monthlyCloseout and @dailyCloseoutEnd
	THEN Amount
ELSE 0 END ),0) TotalAmountBuiltMTD,

isnull(Sum(CASE WHEN  AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @dailyCloseoutStart and @dailyCloseoutEnd
THEN -Amount 
ELSE 0 END),0) DailyPickedUpAmount,

isnull(Sum(CASE WHEN  AccountCode IN (4001, 4002, 4003, 4110, 4120) and TransactionDateTime between @monthlyCloseout and @dailyCloseoutEnd
THEN -Amount 
ELSE 0 END),0) TotalAmountPickedUpMTD,

isnull(Sum(CASE WHEN AccountCode IN (1100) and TransactionDateTime between @dailyCloseoutStart and @dailyCloseoutEnd 
THEN Amount
ELSE 0 END ),0) DailyPaymentAmount,

isnull(Sum(CASE WHEN AccountCode IN (1100) and TransactionDateTime between @monthlyCloseout and @dailyCloseoutEnd 
THEN Amount
ELSE 0 END ),0) TotalAmountPaymentMTD,

isnull(Sum(CASE WHEN AccountCode in (4001, 4003, 4110, 4120) and SubAccountCode = 100 AND TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd
THEN -Amount
	ELSE 0
END),0) SignSales,

isnull(Sum(CASE WHEN AccountCode in (4001, 4003, 4110, 4120) and SubAccountCode = 200 and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd
THEN -Amount
	ELSE 0
END),0) ModifierSales,

isnull(Sum(CASE WHEN AccountCode in (4001, 4002, 4003, 4110, 4120) and SubAccountCode = 400 and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd
THEN -Amount
	ELSE 0
END),0) InstallSales,

isnull(Sum(CASE WHEN AccountCode in (4120) and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd
THEN Amount
WHEN AccountCode in (4001, 4003, 4110) and SubAccountCode = 300 and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd
THEN Amount
	ELSE 0
END),0) DiscountSales, 

isnull(Sum(CASE WHEN AccountCode in (4002) and SubAccountCode <> 400 and TransactionDateTime between @yearlyCloseout and @dailyCloseoutEnd
THEN -Amount
	ELSE 0
END),0) SubcontractSales
FROM GL.GLFact
WHERE	TransactionDateTime between  @rolling12StartLY and @dailyCloseoutEnd
		AND zw_franchise_id = @franchise
) tGL

Inner join 

( 
SELECT 
isnull(Sum(CASE WHEN  ClosedDate between @dailyCloseoutStart and @dailyCloseoutEnd 
THEN SalesSubTotal
ELSE 0 END),0) DailyClosedAmount,

isnull(Sum(CASE WHEN  ClosedDate between @monthlyCloseout and @dailyCloseoutEnd 
THEN SalesSubTotal
ELSE 0 END),0) TotalAmountClosedMTD,

--isnull (Sum(CASE WHEN  PickedUpDate between @yearlyCloseout and @dailyCloseoutEnd
--	THEN ProductionCat2Sales
--ELSE 0 END),0) SubcontractSales,

isnull (Avg(CASE WHEN OrderDate BETWEEN @yearlyCloseout AND @dailyCloseoutEnd
	THEN SalesSubTotal
END),0) YTDAvg,

isnull (Avg(CASE WHEN OrderDate BETWEEN @yearlyCloseoutLY AND @dailyCloseoutEndLY
	THEN SalesSubTotal
END),0) LYYTDAvg,

isnull (Avg(CASE WHEN OrderDate BETWEEN @rolling12Start AND @dailyCloseoutEnd
	THEN SalesSubTotal
END),0) LastTwelveMonths,

isnull (Avg(CASE WHEN OrderDate BETWEEN @rolling12StartLY AND @rolling12Start
	THEN SalesSubTotal
END),0) PreviousTwelveMonths,

ISNULL(SUM(CASE WHEN OrderDate < @monthlyCloseout AND OrderDate > @preMonthlyCloseout
    THEN SalesSubtotal
ELSE 0 END),0) AS LastMonthSales
FROM Orders.OrderHeaderFact AS ohf
WHERE (ClosedDate between @monthlyCloseout and @dailyCloseoutEnd AND ohf.zw_franchise_id = @franchise)
  or (PickedUpDate between @yearlyCloseout and @dailyCloseoutEnd
		AND ohf.zw_franchise_id = @franchise)
or (OrderDate BETWEEN @rolling12StartLY AND @dailyCloseoutEnd AND ohf.zw_franchise_id = @franchise)
) tOrder on 1 = 1

INNER JOIN

(Select
ISNULL(SUM(Amount),0) as WIP
FROM Orders.OrderHeaderFact AS o
inner join GL.GLFact g on g.orderID = o.orderId and g.zw_franchise_id = o.zw_franchise_id and g.accountcode in (1250,1260)
INNER JOIN [Orders].[StatusDim] sd  ON sd.StatusKey = o.StatusKey
WHERE OrderDate < @dailyCloseoutEnd AND sd.[StatusName] IN ('wip','built')
and o.zw_franchise_id = @franchise) tWIP on 1=1

INNER JOIN 

(
SELECT ISNULL(SUM(CASE WHEN Month = DATEPART(mm, @dailyCloseoutEnd)
	THEN SalesTotal
ELSE 0 END), 0) AS MonthlySalesGoal,
ISNULL(SUM(CASE WHEN Month = DATEPART(mm, @dailyCloseoutEnd)
	THEN SalesTotal
ELSE 0 END), 0)/@DaysInMonth AS TYForecastYesterday,
ISNULL(SUM(CASE WHEN Month = DATEPART(mm, @dailyCloseoutEnd)
	THEN SalesTotal
ELSE 0 END),0) * @FractionOfMonth AS TYForecastMTD,
ISNULL(SUM(CASE WHEN Month < DATEPART(mm, @dailyCloseoutEnd)
	THEN SalesTotal
ELSE 0 END), 0) AS TYForecastToLastMonth,
ISNULL (SUM(SalesTotal),0) AS TYForecastRolling12
   FROM Store.SalesGoalsFact
     WHERE zw_franchise_id = @franchise and Year = @maxYear
) tSalesGoal on 1=1




INNER JOIN 

(
select 
@CustYTD as FirstTimeCustomerYTD, 
@CustYTDLY as FirstTimeCustomerLYYTD,
@NoInvoicesYTD as NoOfInvoicesYTD,
(CASE WHEN  @NoInvoicesYTD=0 THEN 0.00 ELSE (@TotalInvoicesYTD / @NoInvoicesYTD) END) as InvoiceAvgYTD
)tCustomer on 1=1

INNER JOIN 

(
select 
@NoInvoicesYTDLY as NoOfInvoicesLYYTD,
(CASE WHEN @NoInvoicesYTDLY = 0 THEN 0.00 ELSE ( @TotalInvoicesYTDLY/@NoInvoicesYTDLY) END) as InvoiceAvgLYYTD
)tLYCustomer on 1=1

INNER JOIN 

(
select 
@overridesYTDLY as OverRidesLYYTD
)tLYOverride on 1=1

INNER JOIN 

(

SELECT @overridesYTD as OverRidesYTD

)tOverride on 1=1

INNER JOIN (SELECT @Loc AS Loc,@OpenDate AS OpenDate,@Currency AS Currency) Sto ON 1=1

INNER JOIN

(
SELECT
COUNT(Distinct CASE WHEN Prospect = 1
	THEN CF.CustomerID
END) AS YTDProspects,
COUNT(Distinct CASE WHEN ActiveCustomer = 1 AND Prospect = 0
    THEN CF.CustomerID
END) AS YTDCustomers
FROM [Contact].[CustomerFact] as CF
WHERE CF.zw_franchise_id = @franchise and customerID > 0
) tProspect on 1 = 1

INNER JOIN

(
Select
COUNT(DISTINCT CASE WHEN ActiveCustomer = 1 AND Prospect = 0 and orderdate BETWEEN @rolling12Start AND @dailyCloseoutEnd
	THEN C.CustomerID
END) AS R12Customers,

COUNT(CASE WHEN ActiveCustomer = 1 AND Prospect = 0 and orderdate BETWEEN @rolling12Start AND @dailyCloseoutEnd
	THEN OrderID
END) AS R12Orders,

COUNT(DISTINCT CASE WHEN ActiveCustomer = 1 AND Prospect = 0 and orderdate BETWEEN @rolling12StartLY AND @dailyCloseoutEndLY
	THEN C.CustomerID
END) AS LR12Customers,

COUNT(CASE WHEN ActiveCustomer = 1 AND Prospect = 0 and orderdate BETWEEN @rolling12StartLY AND @dailyCloseoutEndLY
	THEN OrderID
END) AS LR12Orders

FROM[Contact].[CustomerFact] as C
Left Outer JOIN  Orders.OrderHeaderFact AS ohf on C.customerid = ohf.customerid and C.zw_franchise_id = ohf.zw_franchise_id
WHERE C.zw_franchise_id = @franchise and orderdate BETWEEN @rolling12StartLY and @dailyCloseoutEnd
) tCustomerProspect on 1=1

INNER JOIN 

(
SELECT ISNULL(SUM(PaymentAmount),0) AS Deposits
FROM Orders.PaymentFact AS pf 
INNER JOIN  Orders.OrderHeaderFact AS ohf on ohf.OrderID = pf.OrderID and ohf.zw_franchise_id = pf.zw_franchise_id
WHERE pf.[zw_franchise_id] = @franchise
AND  ohf.StatusKey IN (2,7,12) /*add status key tbl */
) tPayment on 1=1

--Left Outer Join

--(
--SELECT MTDRanking, YTDRanking
--FROM _zw_Ranking_data where zw_franchise_id = @franchise
--)tRankings on 1=1

--INNER JOIN 

--(
--SELECT Max(MTDRanking) as MTDoutof, Max(YTDRanking) as YTDoutof, Count(MTDRanking) as Outof
--FROM _zw_Ranking_data
--)tOutof on 1=1
END




GO
