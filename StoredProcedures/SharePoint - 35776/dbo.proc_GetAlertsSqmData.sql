/****** Object:  StoredProcedure [dbo].[proc_GetAlertsSqmData]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetAlertsSqmData
AS
    SET NOCOUNT ON
    DECLARE @NumImmedAlerts int
    DECLARE @NumSchedAlerts int
    DECLARE @NumImmedAlertsItem int
    DECLARE @NumSchedAlertsItem int
    DECLARE @NumImmedAlertsList int
    DECLARE @NumSchedAlertsList int
    DECLARE @NumImmedAlertsCustom int
    DECLARE @NumSchedAlertsCustom int
    SELECT
        @NumImmedAlerts = COUNT(*)
    FROM
        ImmedSubscriptions
    SELECT
        @NumSchedAlerts = COUNT(*)
    FROM
        SchedSubscriptions
    SELECT
        @NumImmedAlertsItem = COUNT(*)
    FROM
        ImmedSubscriptions
    WHERE
        AlertType & 15 = 1
    SELECT
        @NumSchedAlertsItem = COUNT(*)
    FROM
        SchedSubscriptions
    WHERE
        AlertType & 15 = 1
    SELECT
        @NumImmedAlertsList = COUNT(*)
    FROM
        ImmedSubscriptions
    WHERE
        AlertType & 15 = 0
    SELECT
        @NumSchedAlertsList = COUNT(*)
    FROM
        SchedSubscriptions
    WHERE
        AlertType & 15 = 0
    SELECT
        @NumImmedAlertsCustom = COUNT(*)
    FROM
        ImmedSubscriptions
    WHERE
        AlertType & 15 = 2
    SELECT
        @NumSchedAlertsCustom = COUNT(*)
    FROM
        SchedSubscriptions
    WHERE
        AlertType & 15 = 2
    SELECT
        @NumImmedAlerts,
        @NumSchedAlerts,
        @NumImmedAlertsItem + @NumSchedAlertsItem,
        @NumImmedAlertsList + @NumSchedAlertsList,
        @NumImmedAlertsCustom + @NumSchedAlertsCustom

GO
