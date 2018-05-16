/****** Object:  UserDefinedFunction [dbo].[fn_ANL_GetNumDetailedReportingDays]    Script Date: 5/15/2018 12:15:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------
-- Create Functions
-------------------------------------------------------------------------------

CREATE FUNCTION dbo.fn_ANL_GetNumDetailedReportingDays()
RETURNS INT
AS
BEGIN

DECLARE @days AS INT
SELECT @days = COUNT(DISTINCT dayid) FROM ANLDay WHERE IsHistorical = 0
RETURN @days

END


GO
