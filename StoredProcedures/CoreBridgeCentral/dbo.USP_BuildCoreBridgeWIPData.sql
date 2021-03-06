/****** Object:  StoredProcedure [dbo].[USP_BuildCoreBridgeWIPData]    Script Date: 5/15/2018 12:09:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE Procedure dbo.USP_BuildCoreBridgeWIPData (@LastDayOfMonth as datetime)

AS

BEGIN


IF OBJECT_ID('tempdb.dbo.#CorebridgeWIPStaging', 'U') IS NOT NULL
DROP TABLE #CorebridgeWIPStaging

IF OBJECT_ID('tempdb.dbo.#Pivot', 'U') IS NOT NULL
DROP TABLE #pivot

Select distinct Label as StoreNumber, ZW_Franchise_ID as FranchiseId , CompanyLocationId, Reporttype,ReportItem, CurrentAmount as amount,LastUpdate,Substring(replace(convert(varchar,LastUpdate, 112),'-',''),0,7) LastUpdate_yyyymm
into #Pivot
  from 
  (Select distinct CompanyLocationId, Reporttype,ReportItem, CurrentAmount,cast(LastUpdate  as date) LastUpdate
   ,CL.Value,CL.Label,CL.ZW_Franchise_ID
   FROM [CoreBridgeCentral].[dbo].[DailyAmounts] DA WITH (NOLOCK)
   inner join [CoreBridgeCentral].[dbo].[CompaniesLocations] CL  WITH (NOLOCK)
    on  DA.CompanyLocationId = cl.Value
	inner join [FII_ODS].[System].[StoreControl] Sc  WITH (NOLOCK)  -- ONLY FOR COREBRIDGE
	on CL.ZW_Franchise_ID = Sc.ZW_Franchise_ID
   and cast(LastUpdate  as date) in  (@LastDayOfMonth)
  and  Reporttype in (230,220,270,260,60,160,240,280)
  and CL.ZW_Franchise_ID <> 'FSI000' 
  )a
  order by storenumber 
 

Select * 
into #CorebridgeWIPStaging
  from (Select StoreNumber,FranchiseId,CompanyLocationId,ReportItem,amount,LastUpdate,LastUpdate_yyyymm from #Pivot) FR
  PIVOT(
        sum(amount) 
		  for ReportItem in ([# of Orders in BUILT],[# of Orders in Receivables],[# of Orders in WIP],[# of Voided (Pre-Completed)],[$ in Orders in BUILT],[$ in Orders in WIP],[$ in Voided (Pre-Completed)],[Total $ in Receivables])
	)PVT; 

		
--CREATE TABLE [STAGING].[dbo].[CoreBridgeWIPStaging]
--		(
--	[StoreNumber]						[varchar](200) NULL,
--	[FranchiseId]						[varchar](7) NULL,
--	[CompanyLocationId]					[char](8) NOT NULL,
--	[LastUpdate]						[date] NULL,
--	[LastUpdate_yyyymm]					[varchar](7) NULL,
--	[# of Orders in BUILT]				[decimal](38, 6) NULL,
--	[# of Orders in Receivables]		[decimal](38, 6) NULL,
--	[# of Orders in WIP]				[decimal](38, 6) NULL,
--	[# of Voided (Pre-Completed)]		[decimal](38, 6) NULL,
--	[$ in Orders in BUILT]				[decimal](38, 6) NULL,
--	[$ in Orders in WIP]				[decimal](38, 6) NULL,
--	[$ in Voided (Pre-Completed)]		[decimal](38, 6) NULL,
--	[Total $ in Receivables]			[decimal](38, 6) NULL
--) ON [PRIMARY]

INSERT INTO [STAGING].[dbo].[CoreBridgeWIPStaging]
(
		[StoreNumber]					
		,[FranchiseId]					
		,[CompanyLocationId]				
		,[LastUpdate]					
		,[LastUpdate_yyyymm]				
		,[# of Orders in BUILT]			
		,[# of Orders in Receivables]	
		,[# of Orders in WIP]			
		,[# of Voided (Pre-Completed)]	
		,[$ in Orders in BUILT]			
		,[$ in Orders in WIP]			
		,[$ in Voided (Pre-Completed)]	
		,[Total $ in Receivables]
)

Select 
		[StoreNumber]					
		,[FranchiseId]					
		,[CompanyLocationId]				
		,[LastUpdate]					
		,[LastUpdate_yyyymm]				
		,[# of Orders in BUILT]			
		,[# of Orders in Receivables]	
		,[# of Orders in WIP]			
		,[# of Voided (Pre-Completed)]	
		,[$ in Orders in BUILT]			
		,[$ in Orders in WIP]			
		,[$ in Voided (Pre-Completed)]	
		,[Total $ in Receivables]
				
from #CorebridgeWIPStaging
		 


END

GO
