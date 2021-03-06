/****** Object:  StoredProcedure [dbo].[usp_CorebridgeDW_update]    Script Date: 5/15/2018 12:09:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_CorebridgeDW_update] 
AS
BEGIN
--EXECUTE usp_CorebridgeDW_update 
------------------------------------------------------------------------------------------------
-- Stored Procedure is use to create he Star Schema DW for corebridge
-------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- The following Section is utilized for troubleshooting the data model
------------------------------------------------------------------------------------------------------------------

 DROP TABLE Dim_Region
 --Go
 DROP TABLE Dim_Location	
 --Go	
 DROP TABLE Dim_Franchise	
 --Go
 DROP TABLE Dim_Store
 --Go
  DROP TABLE Dim_Director
 --Go
 DROP TABLE Fact_Corebridge
  --Go
 DROP TABLE DimDate
 -- Go
 ------------------------------------------------------------------------------------------------------------------------
 EXECUTE sproc_CorebridgeStagingUpdate
 --Stored Procedure above is used to pull the necessary data to staging environment table [CoreBridgeStaging]
 
 ------------------------------------------------------------------------------------------------------------------------

If OBJECT_ID('tempdb..#Denormalized') IS NOT NULL BEGIN DROP TABLE #Denormalized END 	

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	   [CorebridgeRowID]
	  ,[ZW_Franchise_ID]
      ,[LastUpdate]
      ,[WebNumber]
      ,[StoreNumber]
      ,[VanityName]
      ,[OpenStatus]
      ,[Address]
      ,[CityName]
      ,[StateName]
      ,[Zip]
      ,[CountryCode]
      ,[Region]
      ,[RegionName]
      ,[RoyaltyFIIpercent]
      ,[RoyaltyNACpercent]
      ,[StoreOpenDate]
      ,[OperationalName]
      ,[StoreTypeName]
      ,[Email]
      ,[FBC]
      ,[Director]
	  ,[ResaleOpenDate]
	  ,[CurrentStoreOpenDate]
      ,[# of Voided (Post-Completed)]
      ,[# of Orders in BUILT]
      ,[$ in New Orders]
      ,[$ Collected]
      ,[$ in Orders in BUILT]
      ,[$ in Cancelled Estimates]
      ,[$ in Net Completed Orders]
      ,[# of Converted Estimates]
      ,[# of Orders in WIP]
      ,[$ in Total Estimates]
      ,[$ in New Estimates]
      ,[$ in Orders in WIP]
      ,[# of New Customers]
      ,[# of Total New Orders]
      ,[# of New Estimates]
      ,[# of Total Estimates]
      ,[$ in Voided (Post-Completed)]
      ,[# of Orders in Receivables]
      ,[# of Completed Orders]
      ,[$ in Converted Estimates]
      ,[# of Net Completed Orders]
      ,[# of Voided (Pre-Completed)]
      ,[# of Cancelled Estimates]
      ,[$ in Voided (Pre-Completed)]
      ,[$ in Completed Orders]
      ,[$ in Total New Orders]
      ,[Total $ in Receivables]
      ,[# of New Orders]
	  ,BINARY_CHECKSUM ([CountryCode], [RegionName],[Region])								AS DimRegionID
	  ,BINARY_CHECKSUM (StateName,CityName)													AS DimLocationID
	  ,BINARY_CHECKSUM (ZW_Franchise_ID, WebNumber, StoreNumber, VanityName, email)			AS DimFranchiseID
	  ,BINARY_CHECKSUM (StoreNumber, [Address], Zip,StoreTypeName)							AS DimStoreID									 
	  ,BINARY_CHECKSUM (FBC)																AS DimFBCID
	  ,BINARY_CHECKSUM  (Director)															AS DimDirectorID

  INTO		#Denormalized		
  FROM		[dbo].[CoreBridgeStaging]
  ORDER BY	 CorebridgeRowID 
  
  --SELECT		*
  --FROM			#Denormalized
  --ORDER BY		StoreNumber
  ----------------------------------------------------------------------------------------------------------------
  --Creating Region Dimension
  ----------------------------------------------------------------------------------------------------------------
  IF NOT EXISTS (SELECT * FROM	SYSOBJECTS WHERE Name = 'Dim_Region' AND xtype = 'U')


		BEGIN
				CREATE TABLE	Dim_Region 
										 (
											Region_Key					INT IDENTITY (1,1) PRIMARY KEY		,
											DimRegionID					INT									,
											Region						VARCHAR(255)						,
											RegionName					VARCHAR(255)						,
											CountryCode					VARCHAR(2)							,
											RegionCurrentRecord			VARCHAR(20)							,
											RegionCheckSum				INT	
										)																															 
		END
------------------------------------------------------------------------------------------------------------------
--Creating Dim_Region through utilization of SCD Type 2
------------------------------------------------------------------------------------------------------------------
INSERT INTO dbo.Dim_Region
						(	
							DimRegionID			,
							Region				,
							RegionName			,
							CountryCode			,
							RegionCurrentRecord	,
							RegionCheckSum							
						)

SELECT				DimRegionID					,
					Region						,
					RegionName					,
					CountryCode					,
					RegionCurrentRecord			,
					RegionChecksum
FROM 
	(
		MERGE Dim_Region AS TARGET
		USING	
				(	
					SELECT DISTINCT		DimRegionID			,
										Region				,
										RegionName			,
										CountryCode			,
										BINARY_CHECKSUM(DimRegionID				,
														Region					,
														RegionName				,
														CountryCode
														) AS 'RegionChecksum'
					FROM	#Denormalized	

				)SOURCE

ON TARGET.DimRegionID = SOURCE.DimRegionID

-----------------------------------------------------------------------------------------------------------------------
--When Values are MATCHED
-----------------------------------------------------------------------------------------------------------------------
WHEN MATCHED AND TARGET.RegionChecksum <> SOURCE.RegionChecksum
	THEN
			UPDATE
			SET TARGET.RegionCurrentRecord = 'Record Not Active'				
-----------------------------------------------------------------------------------------------------------------------
--When Values are Not Matched
-----------------------------------------------------------------------------------------------------------------------
WHEN NOT MATCHED THEN 
		INSERT (	DimRegionID				,
					Region					, 
					RegionName				, 
					CountryCode				,
					RegionCurrentRecord		,
					RegionChecksum
				)
		VALUES(SOURCE.DimRegionID		, 
			   SOURCE.Region			,
			   SOURCE.RegionName		,
			   SOURCE.CountryCode		,
			   'Active_Record'			,
			   BINARY_CHECKSUM (SOURCE.DimRegionID		, 
								SOURCE.Region			,
								SOURCE.RegionName		,
								SOURCE.CountryCode
								)
				)
------------------------------------------------------------------------------------------------------------------
--MERGE OUTPUT
--------------------------------------------------------------------------------------------------------------------
OUTPUT		$Action					, 
			SOURCE.DimRegionID		, 
			SOURCE.Region			,
			SOURCE.RegionName		,
			SOURCE.CountryCode		,
			'Active Record'			,
			SOURCE.RegionChecksum	
			) Changes	

			(
				Action					,
				DimRegionID				,
				Region					, 
				RegionName				, 
				CountryCode				,
				RegionCurrentRecord		,
				RegionChecksum
			)

WHERE Action = 'Update';

--SELECT		*
--FROM		Dim_Region

------------------------------------------------------------------------------------------------------------------------
--Creating Location Dimension
-----------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT  * FROM SYSOBJECTS  WHERE name = 'Dim_location' AND xtype = 'U')

	BEGIN 
			CREATE TABLE	Dim_Location
									(
										Location_Key			INT IDENTITY (1,1) PRIMARY KEY		,
										DimLocationID			INT									,
										CityName				VARCHAR(255)						,
										StateName				VARCHAR(255)						,
										LocationCheckSum		INT									,
										LocationCurrentRecord	VARCHAR(50)							
									)
	END	
---------------------------------------------------------------------------------------------------------------------------
--Create Dim_Location through the utilization of SCD Type 2
---------------------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.Dim_Location
						(	DimLocationID			,
							CityName				,
							StateName				,
							LocationCurrentRecord	,
							LocationCheckSum	
						)	

SELECT	DimLocationID			,
		CityName				,
		StateName				,
		LocationCurrentRecord	,
		LocationCheckSum
FROM
	(
		MERGE Dim_Location AS TARGET
		USING
				(
					SELECT	DISTINCT DimLocationID			,
									 CityName				,
									 StateName				,
									 BINARY_CHECKSUM	(	DimLocationID			,
															CityName				,
															StateName				
														) AS 'LocationCheckSum'
					FROM #Denormalized

				)SOURCE

ON TARGET.DimLocationID = SOURCE.DimLocationID	
------------------------------------------------------------------------------------------
--When Values are MATCHED
-----------------------------------------------------------------------------------------
WHEN MATCHED AND TARGET.LocationCheckSum <> SOURCE.LocationCheckSum
	 THEN 
			UPDATE
				SET	LocationCurrentRecord = 'Record Not Active'


-------------------------------------------------------------------------------------------
--When Values are MATCHED
-------------------------------------------------------------------------------------------
WHEN NOT MATCHED THEN 
		INSERT  (DimLocationID			,
				 CityName				,
				 StateName				,
				 LocationCurrentRecord	,
				 LocationCheckSum		
				 )
		VALUES(SOURCE.DimLocationID		, 
			   SOURCE.CityName			,
			   SOURCE.StateName			,
			   'Active_Record'			,
			   BINARY_CHECKSUM	(SOURCE.DimLocationID		, 
								 SOURCE.CityName			,
								 SOURCE.StateName			
								 )
				)
--------------------------------------------------------------------------------------------
--MERGE OUTPUT
---------------------------------------------------------------------------------------------
OUTPUT		$Action,
			SOURCE.DimLocationID		, 
			SOURCE.CityName				,
			SOURCE.StateName			,							 					 
			'Active_Record'				,								 
			SOURCE.LocationCheckSum		
		)Changes

	(
		Action					, 
		DimLocationID			,
		Cityname				,
		StateName				,
		LocationCurrentRecord	,
		LocationCheckSum
	)

WHERE Action = 'Update';

--SELECT		*
--FROM		Dim_Location
----------------------------------------------------------------------------------------------------
--Creating the Franchise Dimension
----------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE Name = 'Dim_Franchise' AND xtype = 'U')

		BEGIN 
				CREATE TABLE Dim_Franchise
							(
									Franchise_Key			INT IDENTITY (1,1) PRIMARY KEY		,
									DimFranchiseID			INT									,
									ZW_Franchise_ID			VARCHAR(255)						,
									WebNumber				INT									,
									VanityName				VARCHAR(255)						,
									Email					VARCHAR(50)							,
									OpenStatus				VARCHAR(255)						,
									RoyaltyFIIPercent		FLOAT								,
									RoyaltyNACPercent		FLOAT								,
									FranchiseCurrentRecord	VARCHAR(50)							,
									FranchiseIsActiveDate	DATE								,
									FranchiseCheckSum		INT			
							)
		END
-----------------------------------------------------------------------------------------------------
--Creating Dim_Franchise through the utilization of SCD Type 2
-----------------------------------------------------------------------------------------------------
INSERT INTO	Dim_Franchise
				(	 
					
					 DimFranchiseID			,
					 ZW_Franchise_ID		,
					 WebNumber				,
					 VanityName				,
					 Email					,
					 OpenStatus				,
					 RoyaltyFIIPercent		,
					 RoyaltyNACPercent		,
					 FranchiseCurrentRecord ,
					 FranchiseIsActiveDate	,
					 FranchiseCheckSum			
				 ) 

SELECT				 DimFranchiseID			,
					 ZW_Franchise_ID		,
					 WebNumber				,
					 VanityName				,
					 Email					,
					 OpenStatus				,
					 RoyaltyFIIPercent		,
					 RoyaltyNACPercent		,
					 FranchiseCurrentRecord ,
					 FranchiseIsActiveDate	,
					 FranchiseCheckSum		

FROM	--#Denormalized
	(	
			MERGE Dim_Franchise AS TARGET
			USING 
					(
						SELECT	DISTINCT DimFranchiseID			,
										 ZW_Franchise_ID		,
										 WebNumber				,
										 VanityName				,
										 Email					,
										 OpenStatus				,
										 RoyaltyFIIPercent		,
										 RoyaltyNACPercent		,	
										 BINARY_CHECKSUM(	 DimFranchiseID			,
															 ZW_Franchise_ID		,
															 WebNumber				,
															 VanityName				,
															 Email					,
															 OpenStatus				,
															 RoyaltyFIIPercent		,
															 RoyaltyNACPercent				
														 ) AS 'FranchiseCheckSum'
						  FROM #Denormalized
						
						) SOURCE

ON TARGET.DimFranchiseID = SOURCE.DimFranchiseID
------------------------------------------------------------------------------------------------
--When Values are MATCHED
-------------------------------------------------------------------------------------------------
WHEN MATCHED AND TARGET.FranchiseCheckSum <> SOURCE.FranchiseCheckSum
		THEN 
				UPDATE
				SET	
					TARGET.FranchiseCurrentRecord	=	'Record Not Active',
					TARGET.FranchiseIsActiveDate	=	 GETDATE()
				



-------------------------------------------------------------------------------------------------
--When Values are Not MATCHED
-------------------------------------------------------------------------------------------------
WHEN NOT MATCHED THEN
		INSERT (	 DimFranchiseID			,
					 ZW_Franchise_ID		,
					 WebNumber				,
					 VanityName				,
					 Email					,
					 OpenStatus				,
					 RoyaltyFIIPercent		,
					 RoyaltyNACPercent		,
					 FranchiseCurrentRecord ,
					 FranchiseIsActiveDate	,
					 FranchiseCheckSum			
				
				)
		VALUES  (SOURCE.DimFranchiseID		,
				 SOURCE.ZW_Franchise_ID		,
				 SOURCE.Webnumber			,
				 SOURCE.VanityName			,
				 SOURCE.Email				,
				 SOURCE.OpenStatus			,
				 SOURCE.RoyaltyFIIPercent	,
				 SOURCE.RoyaltyNACPercent	,
				 'Active_Record'			,
				 GETDATE()					,
				 BINARY_CHECKSUM (	 SOURCE.DimFranchiseID		,
									 SOURCE.ZW_Franchise_ID		,	
									 SOURCE.Webnumber			,
									 SOURCE.VanityName			,
									 SOURCE.Email				,
									 SOURCE.OpenStatus			,
									 SOURCE.RoyaltyFIIPercent	,
									 SOURCE.RoyaltyNACPercent
								 )
				)

------------------------------------------------------------------------------------
--MERGE OUTPUT
------------------------------------------------------------------------------------
OUTPUT
			$Action						, 
			SOURCE.DimFranchiseID		,
			SOURCE.ZW_Franchise_ID		,
			SOURCE.Webnumber			,
			SOURCE.VanityName			,
			SOURCE.Email				,
			SOURCE.OpenStatus			,
			SOURCE.RoyaltyFIIPercent	,
			SOURCE.RoyaltyNACPercent	,
			'Active_Record'				,
			GETDATE()					,
			SOURCE.FranchiseCheckSum						
		)Changes

		(
			Action					,
			DimFranchiseID			,
			ZW_Franchise_ID			,
			WebNumber				,
			VanityName				,
			Email					,
			OpenStatus				,
			RoyaltyFIIPercent		,
			RoyaltyNACPercent		,
			FranchiseCurrentRecord  ,
			FranchiseIsActiveDate	,
			FranchiseCheckSum			
			
		)

WHERE	Action = 'Update';

--SELECT		*
--FROM		Dim_Franchise

-----------------------------------------------------------------------------------------
--Creating the Dim_Store
-----------------------------------------------------------------------------------------
IF NOT EXISTS ( SELECT * FROM SYSOBJECTS WHERE Name = 'Dim_Store' AND xtype = 'U')

		BEGIN
			CREATE TABLE Dim_Store
							(
								Store_Key					INT IDENTITY (1,1) PRIMARY KEY		, 
								DimStoreID					INT									,
								StoreNumber					INT									,
								[Address]					VARCHAR (255)						,
								Zip							VARCHAR(50)							,
								StoreTypeName				VARCHAR(50)							,
								CurrentStoreOpenDate		DATE								, 
								--StoreCurrentRecord			VARCHAR(50)							,
								StoreCheckSum				INT
							)
		END
-------------------------------------------------------------------------------------------------
--Creating Dim_Store through the utilization of SCD Type 2
-------------------------------------------------------------------------------------------------
INSERT INTO	 dbo.Dim_Store
					(	DimStoreID				,
						StoreNumber				,
						Address					,
						Zip						,
						StoreTypeName			,
						CurrentStoreOpenDate	,
						--StoreCurrentRecord		,
						StoreCheckSum
					)

SELECT	DimStoreID				,
		StoreNumber				,
		Address					,
		Zip						,
		StoreTypeName			,
		CurrentStoreOpenDate	,
		--StoreCurrentRecord		,
		StoreCheckSum

FROM	
	--(
	--	MERGE Dim_Store AS TARGET
	--	USING
				(
					SELECT DISTINCT		DimStoreID				,
										StoreNumber				, 
										Address					,
										Zip						,
										StoreTypeName			,
										CurrentStoreOpenDate	,
										BINARY_CHECKSUM (	DimStoreID			,
															StoreNumber			, 
															Address				,															
															CurrentStoreOpenDate
														) AS 'StoreCheckSum' 
						FROM	#Denormalized
						--ORDER BY	StoreNumber
					)SOURCE

--ON TARGET.DimStoreID = SOURCE.DimStoreID
												
--------------------------------------------------------------------------------------------
----When Values are MATCHED
--------------------------------------------------------------------------------------------
--WHEN MATCHED AND TARGET.StoreCheckSum <> SOURCE.StoreCheckSum
--		THEN 
--				UPDATE	
--					SET TARGET.StoreCurrentRecord = 'Record_Not_Active'
--------------------------------------------------------------------------------------------
----When Values are Not Matched
--------------------------------------------------------------------------------------------
--WHEN NOT MATCHED THEN	
--		INSERT (	DimStoreID				, 
--					StoreNumber				, 
--					Address					,
--					Zip						,
--					StoreTypeName			,
--					CurrentStoreOpenDate	,
--					StoreCurrentRecord		,
--					StoreCheckSum
--				)
--			VALUES (SOURCE.DimStoreID			, 
--					SOURCE.StoreNumber			,
--					SOURCE.Address				,
--					SOURCE.Zip					,
--					SOURCE.StoreTypeName		,
--					SOURCE.CurrentStoreOpenDate ,
--					'Active_Record',
--					BINARY_CHECKSUM(	SOURCE.DimStoreID			, 
--										SOURCE.StoreNumber			,
--										SOURCE.Address				,
--										SOURCE.CurrentStoreOpenDate 
--									)

--					)

--------------------------------------------------------------------------------------
----MERGE OUTPUT
---------------------------------------------------------------------------------------														 
--OUTPUT		$Action,
--			SOURCE.DimStoreID			, 
--			SOURCE.StoreNumber			,
--			SOURCE.Address				,
--			SOURCE.Zip					,
--			SOURCE.StoreTypeName		,
--			SOURCE.CurrentStoreOpenDate ,
--			'Active_Record'				,
--			SOURCE.StoreCheckSum		
--			) Changes								
							
--			(
--				Action,
--				DimStoreID				,
--				StoreNumber				,
--				Address					,
--				Zip						,
--				StoretypeName			,
--				CurrentStoreOpenDate	,
--				StoreCurrentRecord		,
--				StoreCheckSum
--			)	

--SELECT		*
--FROM		Dim_Store		


-----------------------------------------------------------------------------------------
--Creating Dim_Director											
-----------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE Name = 'Dim_Director' AND xtype = 'U')

		BEGIN	
				CREATE TABLE Dim_Director
								(
									Director_Key			INT IDENTITY (1,1) PRIMARY KEY,
									DimDirectorID			INT,
									Director				VARCHAR(255),
									DirectorCurrentRecord	VARCHAR(50),
									DirectorCheckSum		INT
								)	
		END
------------------------------------------------------------------------------------------
--Creating Dim_Director through utilization of SCD Type 2
------------------------------------------------------------------------------------------
INSERT INTO dbo.Dim_Director
					(	DimDirectorID				,
						Director					,
						DirectorCurrentRecord		,
						DirectorCheckSum
					)
SELECT DimDirectorID				,
	   Director						,
	   DirectorCurrentRecord		,
	   DirectorCheckSum
FROM	
	(
		MERGE Dim_Director AS TARGET
		USING
				(
					SELECT	DISTINCT DimDirectorID		,
									 Director			,
									 BINARY_CHECKSUM (DimDirectorID		,
													  Director
													  ) AS 'DirectorCheckSum'
					FROM #Denormalized
				)SOURCE

ON  TARGET.DimDirectorID = SOURCE.DimDirectorID

-----------------------------------------------------------------------------------------------
--When Values are MATCHED
-----------------------------------------------------------------------------------------------
WHEN MATCHED AND TARGET.DirectorCheckSum <> SOURCE.DirectorCheckSum
	THEN 
			UPDATE
			SET TARGET.DirectorCurrentRecord = 'Record Not Active' 
------------------------------------------------------------------------------------------------
--When Values are Not MATCHED
------------------------------------------------------------------------------------------------
WHEN NOT MATCHED THEN 
		INSERT (	DimDirectorID			,
					Director				,
					DirectorCurrentRecord	,
					DirectorCheckSum
				)

		 VALUES (SOURCE.DimDirectorID		,
				 SOURCE.Director			,
				 'Active_Record'			,
				 BINARY_CHECKSUM ( SOURCE.DimDirectorID		,
								   SOURCE.Director
								 )
				)

-------------------------------------------------------------------------------------------------
--MERGE OUTPUT
-------------------------------------------------------------------------------------------------
	OUTPUT		$Action					,
				SOURCE.DimDirectorID	,
				SOURCE.Director			,
				'Active_Record'			,
				SOURCE.DirectorCheckSum
				) Changes

				(	
					Action					, 
					DimDirectorID			,
					Director				,
					DirectorCurrentRecord	,
					DirectorCheckSum
				)

WHERE	Action = 'Update';

--SELECT		*
--FROM		Dim_Director


	
-----------------------------------------------------------------------------------------
--Creating Dim_FBC											
-----------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE Name = 'Dim_FBC' AND xtype = 'U')

		BEGIN	
				CREATE TABLE Dim_FBC
								(
									FBC_Key					INT IDENTITY (1,1) PRIMARY KEY,
									DimFBCID				INT,
									FBC						VARCHAR(255),
									FBCCurrentRecord		VARCHAR(50),
									FBCCheckSum				INT
								)	
		END
------------------------------------------------------------------------------------------
--Creating Dim_Director through utilization of SCD Type 2
------------------------------------------------------------------------------------------
INSERT INTO dbo.Dim_FBC
					(	DimFBCID					,
						FBC							,
						FBCCurrentRecord			,
						FBCCheckSum
					)
SELECT DimFBCID						,
	   FBC							,					
	   FBCCurrentRecord				,
	   FBCCheckSum
FROM	
	(
		MERGE Dim_FBC AS TARGET
		USING
				(
					SELECT	DISTINCT DimFBCID			,
									 FBC				,
									 BINARY_CHECKSUM (DimFBCID				,
													  FBC					
													  ) AS 'FBCCheckSum'
					FROM #Denormalized
				)SOURCE

ON  TARGET.DimFBCID = SOURCE.DimFBCID

-----------------------------------------------------------------------------------------------
--When Values are MATCHED
-----------------------------------------------------------------------------------------------
WHEN MATCHED AND TARGET.FBCCheckSum <> SOURCE.FBCCheckSum
	THEN 
			UPDATE
			SET TARGET.FBCCurrentRecord = 'Record Not Active' 
------------------------------------------------------------------------------------------------
--When Values are Not MATCHED
------------------------------------------------------------------------------------------------
WHEN NOT MATCHED THEN 
		INSERT (	DimFBCID				,
					FBC						,
					FBCCurrentRecord		,
					FBCCheckSum
				)

		 VALUES (SOURCE.DimFBCID		,
				 SOURCE.FBC					,
				 'Active_Record'			,
				 BINARY_CHECKSUM ( SOURCE.DimFBCID		,
								   SOURCE.FBC					
								 )
				)

-------------------------------------------------------------------------------------------------
--MERGE OUTPUT
-------------------------------------------------------------------------------------------------
	OUTPUT		$Action					,
				SOURCE.DimFBCID			,
				SOURCE.FBC				,
				'Active_Record'			,
				SOURCE.FBCCheckSum
				) Changes

				(	
					Action					, 
					DimFBCID				,
					FBC						,
					FBCCurrentRecord		,
					FBCCheckSum
				)

WHERE	Action = 'Update';

--SELECT		*
--FROM		Dim_FBC
----------------------------------------------------------------------------------------------
--Create Date Dimension
----------------------------------------------------------------------------------------------
IF NOT EXISTS ( SELECT * FROM SYSOBJECTs WHERE Name = 'DimDate' AND xtype = 'U')

CREATE TABLE	[dbo].[DimDate]
	(	[Date_Key] INT primary key, 
		[Date] DATETIME,
		[FullDateUK] CHAR(10), -- Date in dd-MM-yyyy format
		[FullDateUSA] CHAR(10),-- Date in MM-dd-yyyy format
		[DayOfMonth] VARCHAR(2), -- Field will hold day number of Month
		[DaySuffix] VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc
		[DayName] VARCHAR(9), -- Contains name of the day, Sunday, Monday 
		[DayOfWeekUSA] CHAR(1),-- First Day Sunday=1 and Saturday=7
		[DayOfWeekUK] CHAR(1),-- First Day Monday=1 and Sunday=7
		[DayOfWeekInMonth] VARCHAR(2), --1st Monday or 2nd Monday in Month
		[DayOfWeekInYear] VARCHAR(2),
		[DayOfQuarter] VARCHAR(3),
		[DayOfYear] VARCHAR(3),
		[WeekOfMonth] VARCHAR(1),-- Week Number of Month 
		[WeekOfQuarter] VARCHAR(2), --Week Number of the Quarter
		[WeekOfYear] VARCHAR(2),--Week Number of the Year
		[Month] VARCHAR(2), --Number of the Month 1 to 12
		[MonthName] VARCHAR(9),--January, February etc
		[MonthOfQuarter] VARCHAR(2),-- Month Number belongs to Quarter
		[Quarter] CHAR(1),
		[QuarterName] VARCHAR(9),--First,Second..
		[Year] CHAR(4),-- Year value of Date stored in Row
		[YearName] CHAR(7), --CY 2012,CY 2013
		[MonthYear] CHAR(10), --Jan-2013,Feb-2013
		[MMYYYY] CHAR(6),
		[FirstDayOfMonth] DATE,
		[LastDayOfMonth] DATE,
		[FirstDayOfQuarter] DATE,
		[LastDayOfQuarter] DATE,
		[FirstDayOfYear] DATE,
		[LastDayOfYear] DATE,
		[IsHolidayUSA] BIT,-- Flag 1=National Holiday, 0-No National Holiday
		[IsWeekday] BIT,-- 0=Week End ,1=Week Day
		[HolidayUSA] VARCHAR(50),--Name of Holiday in US
		[IsHolidayUK] BIT Null,-- Flag 1=National Holiday, 0-No National Holiday
		[HolidayUK] VARCHAR(50) Null --Name of Holiday in UK
	)


/*****************************************************/
--Specify Start Date and End date here
--Value of Start Date Must be Less than Your End Date 

DECLARE @StartDate DATETIME = (SELECT MIN(LastUpdate) FROM #Denormalized) --Starting value of Date Range
DECLARE @EndDate DATETIME = (SELECT MAX(LastUpdate) FROM #Denormalized) --End Value of Date Range

--Temporary Variables To Hold the Values During Processing of Each Date of Year
DECLARE
	@DayOfWeekInMonth INT,
	@DayOfWeekInYear INT,
	@DayOfQuarter INT,
	@WeekOfMonth INT,
	@CurrentYear INT,
	@CurrentMonth INT,
	@CurrentQuarter INT

/*Table Data type to store the day of week count for the month and year*/
DECLARE @DayOfWeek TABLE (DOW INT, MonthCount INT, QuarterCount INT, YearCount INT)

INSERT INTO @DayOfWeek VALUES (1, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (2, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (3, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (4, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (5, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (6, 0, 0, 0)
INSERT INTO @DayOfWeek VALUES (7, 0, 0, 0)

--Extract and assign various parts of Values from Current Date to Variable

DECLARE @CurrentDate AS DATETIME = @StartDate
SET @CurrentMonth = DATEPART(MM, @CurrentDate)
SET @CurrentYear = DATEPART(YY, @CurrentDate)
SET @CurrentQuarter = DATEPART(QQ, @CurrentDate)

/*************************************************************/
--Proceed only if Start Date(Current date ) is less than End date you specified above

WHILE @CurrentDate < @EndDate
BEGIN
 
/*Begin day of week logic*/

         /*Check for Change in Month of the Current date if Month changed then 
          Change variable value*/
	IF @CurrentMonth != DATEPART(MM, @CurrentDate) 
	BEGIN
		UPDATE @DayOfWeek
		SET MonthCount = 0
		SET @CurrentMonth = DATEPART(MM, @CurrentDate)
	END

        /* Check for Change in Quarter of the Current date if Quarter changed then change 
         Variable value*/

	IF @CurrentQuarter != DATEPART(QQ, @CurrentDate)
	BEGIN
		UPDATE @DayOfWeek
		SET QuarterCount = 0
		SET @CurrentQuarter = DATEPART(QQ, @CurrentDate)
	END
       
        /* Check for Change in Year of the Current date if Year changed then change 
         Variable value*/
	

	IF @CurrentYear != DATEPART(YY, @CurrentDate)
	BEGIN
		UPDATE @DayOfWeek
		SET YearCount = 0
		SET @CurrentYear = DATEPART(YY, @CurrentDate)
	END
	
        -- Set values in table data type created above from variables 

	UPDATE @DayOfWeek
	SET 
		MonthCount = MonthCount + 1,
		QuarterCount = QuarterCount + 1,
		YearCount = YearCount + 1
	WHERE DOW = DATEPART(DW, @CurrentDate)

	SELECT
		@DayOfWeekInMonth = MonthCount,
		@DayOfQuarter = QuarterCount,
		@DayOfWeekInYear = YearCount
	FROM @DayOfWeek
	WHERE DOW = DATEPART(DW, @CurrentDate)
	
/*End day of week logic*/


/* Populate Your Dimension Table with values*/
	
	INSERT INTO [dbo].[DimDate]
	SELECT
		
		CONVERT (char(8),@CurrentDate,112) as DateKey,
		@CurrentDate AS Date,
		CONVERT (char(10),@CurrentDate,103) as FullDateUK,
		CONVERT (char(10),@CurrentDate,101) as FullDateUSA,
		DATEPART(DD, @CurrentDate) AS DayOfMonth,
		--Apply Suffix values like 1st, 2nd 3rd etc..
		CASE 
			WHEN DATEPART(DD,@CurrentDate) IN (11,12,13) 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'th'
			WHEN RIGHT(DATEPART(DD,@CurrentDate),1) = 1 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'st'
			WHEN RIGHT(DATEPART(DD,@CurrentDate),1) = 2 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'nd'
			WHEN RIGHT(DATEPART(DD,@CurrentDate),1) = 3 
			THEN CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'rd'
			ELSE CAST(DATEPART(DD,@CurrentDate) AS VARCHAR) + 'th' 
			END AS DaySuffix,
		
		DATENAME(DW, @CurrentDate) AS DayName,
		DATEPART(DW, @CurrentDate) AS DayOfWeekUSA,

		-- check for day of week as Per US and change it as per UK format 
		CASE DATEPART(DW, @CurrentDate)
			WHEN 1 THEN 7
			WHEN 2 THEN 1
			WHEN 3 THEN 2
			WHEN 4 THEN 3
			WHEN 5 THEN 4
			WHEN 6 THEN 5
			WHEN 7 THEN 6
			END 
			AS DayOfWeekUK,
		
		@DayOfWeekInMonth AS DayOfWeekInMonth,
		@DayOfWeekInYear AS DayOfWeekInYear,
		@DayOfQuarter AS DayOfQuarter,
		DATEPART(DY, @CurrentDate) AS DayOfYear,
		DATEPART(WW, @CurrentDate) + 1 - DATEPART(WW, CONVERT(VARCHAR, 
		DATEPART(MM, @CurrentDate)) + '/1/' + CONVERT(VARCHAR, 
		DATEPART(YY, @CurrentDate))) AS WeekOfMonth,
		(DATEDIFF(DD, DATEADD(QQ, DATEDIFF(QQ, 0, @CurrentDate), 0), 
		@CurrentDate) / 7) + 1 AS WeekOfQuarter,
		DATEPART(WW, @CurrentDate) AS WeekOfYear,
		DATEPART(MM, @CurrentDate) AS Month,
		DATENAME(MM, @CurrentDate) AS MonthName,
		CASE
			WHEN DATEPART(MM, @CurrentDate) IN (1, 4, 7, 10) THEN 1
			WHEN DATEPART(MM, @CurrentDate) IN (2, 5, 8, 11) THEN 2
			WHEN DATEPART(MM, @CurrentDate) IN (3, 6, 9, 12) THEN 3
			END AS MonthOfQuarter,
		DATEPART(QQ, @CurrentDate) AS Quarter,
		CASE DATEPART(QQ, @CurrentDate)
			WHEN 1 THEN 'First'
			WHEN 2 THEN 'Second'
			WHEN 3 THEN 'Third'
			WHEN 4 THEN 'Fourth'
			END AS QuarterName,
		DATEPART(YEAR, @CurrentDate) AS Year,
		'CY ' + CONVERT(VARCHAR, DATEPART(YEAR, @CurrentDate)) AS YearName,
		LEFT(DATENAME(MM, @CurrentDate), 3) + '-' + CONVERT(VARCHAR, 
		DATEPART(YY, @CurrentDate)) AS MonthYear,
		RIGHT('0' + CONVERT(VARCHAR, DATEPART(MM, @CurrentDate)),2) + 
		CONVERT(VARCHAR, DATEPART(YY, @CurrentDate)) AS MMYYYY,
		CONVERT(DATETIME, CONVERT(DATE, DATEADD(DD, - (DATEPART(DD, 
		@CurrentDate) - 1), @CurrentDate))) AS FirstDayOfMonth,
		CONVERT(DATETIME, CONVERT(DATE, DATEADD(DD, - (DATEPART(DD, 
		(DATEADD(MM, 1, @CurrentDate)))), DATEADD(MM, 1, 
		@CurrentDate)))) AS LastDayOfMonth,
		DATEADD(QQ, DATEDIFF(QQ, 0, @CurrentDate), 0) AS FirstDayOfQuarter,
		DATEADD(QQ, DATEDIFF(QQ, -1, @CurrentDate), -1) AS LastDayOfQuarter,
		CONVERT(DATETIME, '01/01/' + CONVERT(VARCHAR, DATEPART(YY, 
		@CurrentDate))) AS FirstDayOfYear,
		CONVERT(DATETIME, '12/31/' + CONVERT(VARCHAR, DATEPART(YY, 
		@CurrentDate))) AS LastDayOfYear,
		NULL AS IsHolidayUSA,
		CASE DATEPART(DW, @CurrentDate)
			WHEN 1 THEN 0
			WHEN 2 THEN 1
			WHEN 3 THEN 1
			WHEN 4 THEN 1
			WHEN 5 THEN 1
			WHEN 6 THEN 1
			WHEN 7 THEN 0
			END AS IsWeekday,
		NULL AS HolidayUSA, Null, Null

	SET @CurrentDate = DATEADD(DD, 1, @CurrentDate)
END





----------------------------------------------------------------------------------------------
--Corebridge Fact Table
----------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE name = 'Fact_Corebridge' AND xtype = 'U')

	BEGIN 
			CREATE TABLE Fact_Corebridge
							(
								CorebrideFact_Key						INT IDENTITY (1,1) PRIMARY KEY		,
								CorebridgeRowID							INT									,
								Franchise_Key							INT									,
								Region_Key								INT									,
								Location_Key							INT									,
								Store_Key								INT									,
								Director_Key							INT									,
								FBC_Key									INT									,
								Date_Key								INT									,
								
								[# of Voided (Post-Completed)]			INT									, 
								[# of Orders in BUILT]					INT									,
								[$ in New Orders]						Decimal(18,6)						,
								[$ Collected]							Decimal(18,6)						,
								[$ in Orders in BUILT]					Decimal(18,6)						,
								[$ in Cancelled Estimates]				Decimal(18,6)						,
								[$ in Net Completed Orders]				Decimal(18,6)						,
								[# of Converted Estimates]				INT									,
								[# of Orders in WIP]					INT									,
								[$ in Total Estimates]					Decimal(18,6)						,
								[$ in New Estimates]					Decimal(18,6)						,
								[$ in Orders in WIP]					Decimal(18,6)						,
								[# of New Customers]					INT									,
								[# of Total New Orders]					INT									, 
								[# of New Estimates]					INT									,
								[# of Total Estimates]					INT									,
								[$ in Voided (Post-Completed)]			Decimal(18,6)						,
								[# of Orders in Receivables]			INT									,
								[# of Completed Orders]					INT									,
								[$ in Converted Estimates]				Decimal(18,6)						,
								[# of Net Completed Orders]				INT									,
								[# of Voided (Pre-Completed)]			INT									,
								[# of Cancelled Estimates]				INT									,
								[$ in Voided (Pre-Completed)]			Decimal(18,6)						,
								[$ in Completed Orders]					Decimal(18,6)						,
								[$ in Total New Orders]					Decimal(18,6)						,
								[Total $ in Receivables]				Decimal(18,6)						,
								[# of New Orders]						INT									,
								FactCheckSum							INT
							)
		END

		MERGE Fact_Corebridge AS TARGET
		USING
				(
					SELECT DISTINCT		A.CorebridgeRowID			, 
										B.Franchise_Key				,
										C.Region_Key				, 
										D.Location_Key				,
										E.Store_Key					,
										F.Director_Key				,

										G.Date_Key					,
										H.FBC_Key					,

										A.[# of Voided (Post-Completed)]			, 
										A.[# of Orders in BUILT]					,
										A.[$ in New Orders]							,
										A.[$ Collected]								,
										A.[$ in Orders in BUILT]					,
										A.[$ in Cancelled Estimates]				,
										A.[$ in Net Completed Orders]				,
										A.[# of Converted Estimates]				,
										A.[# of Orders in WIP]						,
										A.[$ in Total Estimates]					,
										A.[$ in New Estimates]						,
										A.[$ in Orders in WIP]						,
										A.[# of New Customers]						,
										A.[# of Total New Orders]					, 
										A.[# of New Estimates]						,
										A.[# of Total Estimates]					,
										A.[$ in Voided (Post-Completed)]			,
										A.[# of Orders in Receivables]				,
										A.[# of Completed Orders]					,
										A.[$ in Converted Estimates]				,
										A.[# of Net Completed Orders]				,
										A.[# of Voided (Pre-Completed)]				,
										A.[# of Cancelled Estimates]				,
										A.[$ in Voided (Pre-Completed)]				,
										A.[$ in Completed Orders]					,
										A.[$ in Total New Orders]					,
										A.[Total $ in Receivables]					,
										A.[# of New Orders]							,					
										BINARY_CHECKSUM	(			
																B.Franchise_Key				,
																C.Region_Key				, 
																D.Location_Key				,
																E.Store_Key					,
																F.Director_Key				,
																G.Date_Key					,
																H.FBC_Key					,
										
																A.[# of Voided (Post-Completed)]			, 
																A.[# of Orders in BUILT]					,
																A.[$ in New Orders]							,
																A.[$ Collected]								,
																A.[$ in Orders in BUILT]					,
																A.[$ in Cancelled Estimates]				,
																A.[$ in Net Completed Orders]				,
																A.[# of Converted Estimates]				,
																A.[# of Orders in WIP]						,
																A.[$ in Total Estimates]					,
																A.[$ in New Estimates]						,
																A.[$ in Orders in WIP]						,
																A.[# of New Customers]						,
																A.[# of Total New Orders]					, 
																A.[# of New Estimates]						,
																A.[# of Total Estimates]					,
																A.[$ in Voided (Post-Completed)]			,
																A.[# of Orders in Receivables]				,
																A.[# of Completed Orders]					,
																A.[$ in Converted Estimates]				,
																A.[# of Net Completed Orders]				,
																A.[# of Voided (Pre-Completed)]				,
																A.[# of Cancelled Estimates]				,
																A.[$ in Voided (Pre-Completed)]				,
																A.[$ in Completed Orders]					,
																A.[$ in Total New Orders]					,
																A.[Total $ in Receivables]					,
																A.[# of New Orders]						
															) AS 'FactCheckSum'


					FROM	#Denormalized A
					LEFT OUTER JOIN		 Dim_Franchise		B	ON	A.DimFranchiseID =	B.DimFranchiseID
					LEFT OUTER JOIN		 Dim_Region			C	ON	A.DimRegionID =		C.DimRegionID
					LEFT OUTER JOIN		 Dim_Location		D	ON	A.DimLocationID =	D.DimLocationID
					LEFT OUTER JOIN		 Dim_Store			E	ON	A.DimStoreID =		E.DimStoreID		
					LEFT OUTER JOIN		 Dim_Director		F	ON	A.DimDirectorID =	F.DimDirectorID
					LEFT OUTER JOIN		 DimDate			G	ON	A.[LastUpdate]=		G.[Date]
					LEFT OUTER JOIN		 Dim_FBC			H	ON	A.DimFBCID =		H.DimFBCID		

				)SOURCE

ON	TARGET.CorebridgeRowID	= SOURCE.CorebridgeRowID
---------------------------------------------------------------------------------------------------------------------
-- When Values are MATCHED
--------------------------------------------------------------------------------------------------------------------
WHEN MATCHED AND TARGET.FactChecksum <> SOURCE.FactChecksum
	THEN		
			UPDATE
			SET							TARGET.CorebridgeRowID	= SOURCE.CorebridgeRowID	, 
										TARGET.Franchise_Key	= SOURCE.Franchise_Key		,
										TARGET.Region_Key		= SOURCE.Region_Key			, 
										TARGET.Location_Key		= SOURCE.Location_Key		,
										TARGET.Store_Key		= SOURCE.Store_Key			,
										TARGET.Director_Key		= SOURCE.Director_Key		,
										TARGET.FBC_Key			= SOURCE.FBC_Key			,

										TARGET.Date_Key			= SOURCE.Date_Key			,
										
										TARGET.[# of Voided (Post-Completed)]	= SOURCE.[# of Voided (Post-Completed)]			, 
										TARGET.[# of Orders in BUILT]			= SOURCE.[# of Orders in BUILT]					,
										TARGET.[$ in New Orders]				= SOURCE.[$ in New Orders]						,
										TARGET.[$ Collected]					= SOURCE.[$ Collected]							,
										TARGET.[$ in Orders in BUILT]			= SOURCE.[$ in Orders in BUILT]					,
										TARGET.[$ in Cancelled Estimates]		= SOURCE.[$ in Cancelled Estimates]				,
										TARGET.[$ in Net Completed Orders]		= SOURCE.[$ in Net Completed Orders]			,
										TARGET.[# of Converted Estimates]		= SOURCE.[# of Converted Estimates]				,
										TARGET.[# of Orders in WIP]				= SOURCE.[# of Orders in WIP]					,
										TARGET.[$ in Total Estimates]			= SOURCE.[$ in Total Estimates]					,
										TARGET.[$ in New Estimates]				= SOURCE.[$ in New Estimates]					,
										TARGET.[$ in Orders in WIP]				= SOURCE.[$ in Orders in WIP]					,
										TARGET.[# of New Customers]				= SOURCE.[# of New Customers]					,
										TARGET.[# of Total New Orders]			= SOURCE.[# of Total New Orders]				, 
										TARGET.[# of New Estimates]				= SOURCE.[# of New Estimates]					,
										TARGET.[# of Total Estimates]			= SOURCE.[# of Total Estimates]					,
										TARGET.[$ in Voided (Post-Completed)]	= SOURCE.[$ in Voided (Post-Completed)]			,
										TARGET.[# of Orders in Receivables]		= SOURCE.[# of Orders in Receivables]			,
										TARGET.[# of Completed Orders]			= SOURCE.[# of Completed Orders]				,
										TARGET.[$ in Converted Estimates]		= SOURCE.[$ in Converted Estimates]				,
										TARGET.[# of Net Completed Orders]		= SOURCE.[# of Net Completed Orders]	 		,
										TARGET.[# of Voided (Pre-Completed)]	= SOURCE.[# of Voided (Pre-Completed)]			,
										TARGET.[# of Cancelled Estimates]		= SOURCE.[# of Cancelled Estimates]				,
										TARGET.[$ in Voided (Pre-Completed)]	= SOURCE.[$ in Voided (Pre-Completed)]			,
										TARGET.[$ in Completed Orders]			= SOURCE.[$ in Completed Orders]				,
										TARGET.[$ in Total New Orders]			= SOURCE.[$ in Total New Orders]				,
										TARGET.[Total $ in Receivables]			= SOURCE.[Total $ in Receivables]				,
										TARGET.[# of New Orders]				= SOURCE.[# of New Orders]						,
										TARGET.FactCheckSum						= SOURCE.FactCheckSum

----------------------------------------------------------------------------------------------------------------------------------------
-- When Values Are NOT MATCHED
----------------------------------------------------------------------------------------------------------------------------------------

WHEN NOT MATCHED THEN
		INSERT (				
								CorebridgeRowID							,
								Franchise_Key							,
								Region_Key								,
								Location_Key							,
								Store_Key								,
								Director_Key							,
								FBC_Key									,

								Date_Key								,
								
								[# of Voided (Post-Completed)]			, 
								[# of Orders in BUILT]					,
								[$ in New Orders]						,
								[$ Collected]							,
								[$ in Orders in BUILT]					,
								[$ in Cancelled Estimates]				,
								[$ in Net Completed Orders]				,
								[# of Converted Estimates]				,
								[# of Orders in WIP]					,
								[$ in Total Estimates]					,
								[$ in New Estimates]					,
								[$ in Orders in WIP]					,
								[# of New Customers]					,
								[# of Total New Orders]					, 
								[# of New Estimates]					,
								[# of Total Estimates]					,
								[$ in Voided (Post-Completed)]			,
								[# of Orders in Receivables]			,
								[# of Completed Orders]					,
								[$ in Converted Estimates]				,
								[# of Net Completed Orders]				,
								[# of Voided (Pre-Completed)]			,
								[# of Cancelled Estimates]				,
								[$ in Voided (Pre-Completed)]			,
								[$ in Completed Orders]					,
								[$ in Total New Orders]					,
								[Total $ in Receivables]				,
								[# of New Orders]						,
								FactCheckSum							
					)
		VALUES (
					SOURCE.CorebridgeRowID						,
					SOURCE.Franchise_Key						,
					SOURCE.Region_Key							,
					SOURCE.Location_Key							,
					SOURCE.Store_Key							,
					SOURCE.Director_Key							,
					SOURCE.FBC_Key								,
					SOURCE.Date_Key								,
					SOURCE.[# of Voided (Post-Completed)]		,
					SOURCE.[# of Orders in BUILT]				,
					SOURCE.[$ in New Orders]					,
					SOURCE.[$ Collected]						,
					SOURCE.[$ in Orders in BUILT]				,
					SOURCE.[$ in Cancelled Estimates]			,
					SOURCE.[$ in Net Completed Orders]			,
					SOURCE.[# of Converted Estimates]			,
					SOURCE.[# of Orders in WIP]					,
					SOURCE.[$ in Total Estimates]				,
					SOURCE.[$ in New Estimates]					,
					SOURCE.[$ in Orders in WIP]					,
					SOURCE.[# of New Customers]					,
					SOURCE.[# of Total New Orders]				,
					SOURCE.[# of New Estimates]					,
					SOURCE.[# of Total Estimates]				,
					SOURCE.[$ in Voided (Post-Completed)]		,
					SOURCE.[# of Orders in Receivables]			,
					SOURCE.[# of Completed Orders]				,
					SOURCE.[$ in Converted Estimates]			,
					SOURCE.[# of Net Completed Orders]			,
					SOURCE.[# of Voided (Pre-Completed)]		,
					SOURCE.[# of Cancelled Estimates]			,
					SOURCE.[$ in Voided (Pre-Completed)]		,
					SOURCE.[$ in Completed Orders]				,
					SOURCE.[$ in Total New Orders]				,
					SOURCE.[Total $ in Receivables]				,
					SOURCE.[# of New Orders]					,
					BINARY_CHECKSUM (	SOURCE.Franchise_Key						,
										SOURCE.Region_Key							,
										SOURCE.Location_Key							,
										SOURCE.Store_Key							,
										SOURCE.Director_Key							,
										SOURCE.FBC_Key								,
										SOURCE.Date_Key								,
										SOURCE.[# of Voided (Post-Completed)]		,
										SOURCE.[# of Orders in BUILT]				,
										SOURCE.[$ in New Orders]					,
										SOURCE.[$ Collected]						,
										SOURCE.[$ in Orders in BUILT]				,
										SOURCE.[$ in Cancelled Estimates]			,
										SOURCE.[$ in Net Completed Orders]			,
										SOURCE.[# of Converted Estimates]			,
										SOURCE.[# of Orders in WIP]					,
										SOURCE.[$ in Total Estimates]				,
										SOURCE.[$ in New Estimates]					,
										SOURCE.[$ in Orders in WIP]					,
										SOURCE.[# of New Customers]					,
										SOURCE.[# of Total New Orders]				,
										SOURCE.[# of New Estimates]					,
										SOURCE.[# of Total Estimates]				,
										SOURCE.[$ in Voided (Post-Completed)]		,
										SOURCE.[# of Orders in Receivables]			,
										SOURCE.[# of Completed Orders]				,
										SOURCE.[$ in Converted Estimates]			,
										SOURCE.[# of Net Completed Orders]			,
										SOURCE.[# of Voided (Pre-Completed)]		,
										SOURCE.[# of Cancelled Estimates]			,
										SOURCE.[$ in Voided (Pre-Completed)]		,
										SOURCE.[$ in Completed Orders]				,
										SOURCE.[$ in Total New Orders]				,
										SOURCE.[Total $ in Receivables]				,
										SOURCE.[# of New Orders]					,
										SOURCE.FactCheckSum
									 )
				 );

 --SELECT		*
 --FROM		Fact_Corebridge


END
-------------------------------------------------------------------------------------------------------------------------------------------

								
GO
