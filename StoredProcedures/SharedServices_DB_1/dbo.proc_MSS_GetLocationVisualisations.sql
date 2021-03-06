/****** Object:  StoredProcedure [dbo].[proc_MSS_GetLocationVisualisations]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetLocationVisualisations(
    @LocationId int,
    @VisualisationName nvarchar(60) = NULL)
 AS

SET NOCOUNT ON

DECLARE @LastError int

IF (@VisualisationName IS NULL) Or (datalength(@VisualisationName) = 0)
BEGIN
    -- Get all visualisation for a given location
    SELECT LocationId, VisualisationName, Properties, Xsl, SampleData
    FROM dbo.MSSLocationVisualisations
    WHERE LocationId = @LocationId

    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN 
        RETURN @LastError
    END

    RETURN 0
END

--We need to get a particular Visualisation for a given Location
SELECT LocationId, VisualisationName, Properties, Xsl, SampleData
FROM dbo.MSSLocationVisualisations
 WHERE LocationId = @LocationId And VisualisationName = @VisualisationName

SELECT @LastError = @@ERROR
IF @LastError <> 0
BEGIN 
    RETURN @LastError
END

RETURN 0

GO
