/****** Object:  StoredProcedure [dbo].[get_rankings_MTD_YTD]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[get_rankings_MTD_YTD]
AS
SET NOCOUNT ON

Declare @Thru_Date datetime
SET @Thru_Date = getdate()


/*
	THE FOLLOWING (#tempFranchiseIDs) IS SIMPLY A TEMPORARY TABLE TO HOLD THE FRANCHISE IDS (FSIXXXX) 
	OF THE STORES THAT COLLECTED THE NIGHT BEFORE
	THIS THEN LIMITS THE RANKINGS TO ONLY THE STORES THAT COLLECTED THE NIGHT BEFORE
	IT IS ONLY USED ONCE BELOW AS A LIMITING CLAUSE IN A QUERY
		and zw_franchise_id in (select zw_franchise_id from #tempFranchiseIDs)

	WE DIRECTLY QUERIED SOME INTERNAL TABLES WITH SOME INTERNAL PROCS AND NONE OF THIS WOULD
	BE OF ANY RELEVANCE SO IT HAS BEEN REMOVED

	SIMPLY REPLACE THE COMMENTED LINE WITH SOMETHING LIKE:
		FROM StoreCollectionInfo WHERE lastCollectedDate >= dateadd(hh,-24,GetDate())
*/

select node_id into #tempFranchiseIDs 
FROM collection_nodes WHERE lastcollected_clienttime >= dateadd(hh,-24,GetDate())

--Clear yesterday's rankings
delete from _zw_Ranking_data

--To handle issue of paradox driver altering cyrious dates by 13hrs
DECLARE @date DATETIME
SET @date = dateadd(hh,-13,GetDate())

DECLARE @monthlyCloseout DATETIME
Select @monthlyCloseout = Coalesce(Max( Date ), '1/1/1900' ) FROM [Closeout Database] WHERE CloseoutType = 'M' and Date < @date and Month(Date) < Month(GetDate())

DECLARE @yearlyCloseout DATETIME
Select @yearlyCloseout = Coalesce(Max( Date ), '1/1/1900' ) FROM [Closeout Database] WHERE CloseoutType = 'Y' and Date < @date and Year(Date) < Year(GetDate())

Insert into _zw_Ranking_data (zw_franchise_id, Thru_Date, MTDRanking, MTDSales, YTDRanking, YTDSales)
Select 
	zw_franchise_id, 
	@Thru_Date, 
	Rank () over (order by MTDSales desc) as MTDRank, 
	MTDSales,
	Rank () over (order by YTDSales desc) as YTDRank, 
	YTDSales
From 
	(
		select 
			isnull(sum(CASE WHEN PickedUpDate between @monthlyCloseout and @date THEN o.SalesTotal ELSE 0 END),0) as MTDSales,
			isnull(sum(CASE WHEN PickedUpDate between @yearlyCloseout and @date THEN o.SalesTotal ELSE 0 END),0) as YTDSales,
			zw_franchise_id
		from  
			[Order Database] o
		where 
			PickedUpDate between @yearlyCloseout and @date
		and 
			zw_franchise_id in (select node_id from #tempFranchiseIDs)
		group by 
			zw_franchise_id
	) tTemp

drop table #tempFranchiseIDs
GO
