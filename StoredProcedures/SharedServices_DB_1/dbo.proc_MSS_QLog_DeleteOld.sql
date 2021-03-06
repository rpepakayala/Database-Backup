/****** Object:  StoredProcedure [dbo].[proc_MSS_QLog_DeleteOld]    Script Date: 5/15/2018 12:11:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_QLog_DeleteOld
AS

DECLARE @TooOld datetime

SET @TooOld = DATEADD(day, -397, GETDATE())

DELETE FROM MSSQLogHistorical WHERE searchDate < @TooOld 

SET @TooOld = DATEADD(day, -366, GETDATE())

DELETE FROM MSSQLogNonClicked WHERE clickId IN 
    (SELECT clickId FROM MSSQLog WHERE searchTime < @TooOld)

DELETE FROM MSSQLog WHERE searchTime < @TooOld 
DELETE FROM MSSQLogUrl WHERE lastReference < @TooOld 
DELETE FROM MSSQLogScope WHERE lastReference < @TooOld 
DELETE FROM MSSQLogQueryString WHERE lastReference < @TooOld 
DELETE FROM MSSQLogBestBet WHERE lastReference < @TooOld 
DELETE FROM MSSQLogQueryServer WHERE lastReference < @TooOld 
DELETE FROM MSSQLogSiteGuid WHERE lastReference < @TooOld 
DELETE FROM MSSQLogContextualScopeName WHERE lastReference < @TooOld
DELETE FROM MSSQLogContextualScope WHERE lastReference < @TooOld
DELETE FROM MSSQLogLocation WHERE lastReference < @TooOld

SET @TooOld = DATEADD(day, -31, GETDATE())

DELETE FROM MSSQLogQuerySummary WHERE searchDate < @TooOld 
DELETE FROM MSSQLogScopeSummary WHERE searchDate < @TooOld 
DELETE FROM MSSQLogClickedUrlSummary WHERE searchDate < @TooOld 
DELETE FROM MSSQLogBestBetSummary WHERE searchDate < @TooOld 
DELETE FROM MSSQLogResultsUrlSummary WHERE searchDate < @TooOld 
DELETE FROM MSSQLogLocationSummary WHERE searchDate < @TooOld 


GO
