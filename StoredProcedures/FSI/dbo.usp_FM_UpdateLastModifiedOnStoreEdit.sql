/****** Object:  StoredProcedure [dbo].[usp_FM_UpdateLastModifiedOnStoreEdit]    Script Date: 5/15/2018 12:09:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        Alex, Montminy
-- Create date: 1/28/2013
-- Description:   Updates Customers LstSync2 to latest of customer / store
-- =============================================
Create PROCEDURE [dbo].[usp_FM_UpdateLastModifiedOnStoreEdit]
AS 
    BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
        SET NOCOUNT ON;

    -- Insert statements for procedure here
      --FSI
        UPDATE
            dbo._ExactTarget_Integration_Contacts
        SET 
            Last_Modified = GMSL.LastDate
        FROM
            [BigNuget].[GoldMine_Sales_And_Marketing].[dbo].[vwStoreList] GMSL
            INNER JOIN [FSI].[dbo].[_ExactTarget_Integration_Stores] EIS ON GMSL.key1 = EIS.[StoreNumber]
            INNER JOIN dbo._ExactTarget_Integration_Contacts EIC ON EIC.zw_franchise_id = EIS.zw_franchise_id
        WHERE
            EIC.Last_Modified < GMSL.LastDate


    END

GO
