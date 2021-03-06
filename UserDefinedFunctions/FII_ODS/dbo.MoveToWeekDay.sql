/****** Object:  UserDefinedFunction [dbo].[MoveToWeekDay]    Script Date: 5/15/2018 12:14:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Tim Fleck
-- Create date: 2/12/2016
-- Description:	Pass a date and it will be shifted to weekdays
--   for the moving average graph
-- =============================================
CREATE FUNCTION [dbo].[MoveToWeekDay] ( @MoveDate DATE )
RETURNS DATETIME
AS
BEGIN

        DECLARE @ResultVar DATE
        SELECT
            @ResultVar = CASE WHEN DATEPART(WEEKDAY, @MoveDate) = 7
                              THEN DATEADD(d, -1, @MoveDate)
                              WHEN DATEPART(WEEKDAY, @MoveDate) = 1
                              THEN DATEADD(d, 1, @MoveDate)
                              ELSE @MoveDate
                         END 

        RETURN @ResultVar
END 


GO
