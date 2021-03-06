/****** Object:  StoredProcedure [dbo].[rpt_Mapping]    Script Date: 5/15/2018 12:09:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC rpt_Mapping (@CenterNumber INT)
as
DECLARE
    @Longitude FLOAT =1 ,
    @Latitude FLOAT =1
SET @Latitude = (SELECT
    VendorLocation.Lat
FROM
    [System].[CenterGEO]
WHERE
    CenterNumber = @CenterNumber)
SET @Longitude = (SELECT
    VendorLocation.Long 
FROM
    [System].[CenterGEO]
WHERE
    CenterNumber = @CenterNumber)

DECLARE @point GEOGRAPHY 
set @point = geography::Point(@Latitude, @Longitude, 4326);
DECLARE @dist INT = 80467.2;

SELECT
    *
FROM
    [System].[CenterGEO]
WHERE
    @point.STDistance(VendorLocation) <= @dist
GO
