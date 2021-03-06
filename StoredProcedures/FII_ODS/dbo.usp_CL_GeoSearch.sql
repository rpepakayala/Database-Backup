/****** Object:  StoredProcedure [dbo].[usp_CL_GeoSearch]    Script Date: 5/15/2018 12:09:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        Alex, Montminy
-- Create date: 12/17/2014
-- Description:   Finds closest centers for center locater search
-- =============================================
CREATE PROCEDURE [dbo].[usp_CL_GeoSearch]
      -- Add the parameters for the stored procedure here
    @lat NVARCHAR(MAX) ,
    @long NVARCHAR(MAX) ,
    @miles NVARCHAR(MAX)
AS 
    BEGIN
     IF @lat IS NULL 
            BEGIN
                SET @lat = 1;
                SET @long = 1;
                Set @miles =2000;
            END
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
        SET NOCOUNT ON;

    -- Insert statements for procedure here

        DECLARE @location GEOGRAPHY;

        SET @location = GEOGRAPHY::Point(@lat, @long, 4326);
        SELECT
            [GeoCode].STDistance(@location) AS Distance ,
            [GeoCode].STDistance(@location) / 1609.344 AS Miles ,
            Store.GEO.GeoCode ,
            Store.StoreFact.StoreNumber ,
			Store.StoreFact.ZW_Franchise_ID,
            Store.StoreFact.Address ,
            Store.StoreFact.Region ,
            Store.StoreFact.Phone ,
            Store.StoreFact.Zip ,
            Store.StoreFact.OpenStatus ,
            Store.CityDim.CityName ,
            Store.CountryDim.CountryName ,
            Store.StateDim.StateName ,
            Store.GEO.Long ,
            Store.GEO.Lat
        FROM
            Store.StoreFact WITH (NOLOCK)
            INNER JOIN Store.GEO WITH (NOLOCK) ON Store.StoreFact.StoreNumber = Store.GEO.StoreNumber
            INNER JOIN Store.StateDim WITH (NOLOCK) ON Store.StoreFact.StateKey = Store.StateDim.StateKey
            INNER JOIN Store.CountryDim WITH (NOLOCK) ON Store.StoreFact.CountryKey = Store.CountryDim.CountryKey
            INNER JOIN Store.CityDim WITH (NOLOCK) ON Store.StoreFact.CityKey = Store.CityDim.CityKey
        WHERE
            Store.GEO.GeoCode IS NOT NULL
            AND Store.StoreFact.OpenStatus = 'Open'
            AND [GeoCode].STDistance(@location) / 1609.344 < @miles
        ORDER BY
            Miles ASC
    END

--GRANT EXEC ON [dbo].usp_CL_GeoSearch TO [FASTSIGNS\IS-AppDev]



GO
