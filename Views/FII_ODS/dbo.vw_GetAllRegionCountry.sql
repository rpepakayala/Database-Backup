/****** Object:  View [dbo].[vw_GetAllRegionCountry]    Script Date: 5/15/2018 12:13:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[vw_GetAllRegionCountry]
AS
-- View to show the Current Region / Country List
-- TAF 1/29/2013
SELECT
    Store.RegionDim.RegionName ,
    Store.CountryDim.CountryName
FROM
    Store.RegionDim   WITH ( NOLOCK ) 
    JOIN store.CountryRegion   WITH ( NOLOCK ) ON RegionDim.RegionKey = CountryRegion.RegionKey
    JOIN store.CountryDim   WITH ( NOLOCK )  ON CountryRegion.CountryKey = CountryDim.CountryKey


GO
