/****** Object:  StoredProcedure [dbo].[usp_UniqueStoreOwner]    Script Date: 5/15/2018 12:09:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_UniqueStoreOwner]
----------------------------------------------
--SPROC is created to pull distinct owners and storenumbers 
---------------------------------------------
AS 

BEGIN

DECLARE @OwnerContact TABLE (StoreNumber INT, Owner VARCHAR(100), Interest VARCHAR(50))
INSERT INTO @OwnerContact(StoreNumber, Owner, Interest)

Select
  OwnerList.StoreNumber,
  OwnerList.Owner,
  OwnerList.Interest
From
  (Select
    vw_GoldminetoAlpine.StoreNumber,
    vw_GoldminetoAlpine.Shareholder1 As Owner,
    vw_GoldminetoAlpine.Interest1_A As Interest
  From
    vw_GoldminetoAlpine
  Union
  Select
    vw_GoldminetoAlpine.StoreNumber,
    vw_GoldminetoAlpine.Shareholder2 As Owner,
    vw_GoldminetoAlpine.Interest2_A
  From
    vw_GoldminetoAlpine
  Where
    vw_GoldminetoAlpine.Interest2_A > 0
  Union
  Select
    vw_GoldminetoAlpine.StoreNumber,
    vw_GoldminetoAlpine.Shareholder3 As Owner,
    vw_GoldminetoAlpine.Interest3_A As Interest
  From
    vw_GoldminetoAlpine
  Where
    vw_GoldminetoAlpine.Interest3_A > 0
  Union
  Select
    vw_GoldminetoAlpine.StoreNumber,
    vw_GoldminetoAlpine.Shareholder4 As Owner,
    vw_GoldminetoAlpine.Interest4_A As Interest
  From
    vw_GoldminetoAlpine
  Where
    vw_GoldminetoAlpine.Interest4_A > 0
  Union
  Select
    vw_GoldminetoAlpine.StoreNumber,
    vw_GoldminetoAlpine.Shareholder5 As Owner,
    vw_GoldminetoAlpine.Interest5_A As Interest
  From
   vw_GoldminetoAlpine
  Where
    vw_GoldminetoAlpine.Interest5_A > 0
  Union
  Select
    vw_GoldminetoAlpine.StoreNumber,
    vw_GoldminetoAlpine.Shareholder6 As Owner,
    vw_GoldminetoAlpine.Interest6_A As Interest
  From
    vw_GoldminetoAlpine
  Where
    vw_GoldminetoAlpine.Interest6_A > 0) OwnerList
Where
  OwnerList.Owner Not Like '%None%' And
  OwnerList.Interest > 0

  SELECT DISTINCT  StoreNumber,Owner,Interest
  FROM		@OwnerContact
  ORDER BY	StoreNumber	

END
GO
