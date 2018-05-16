/****** Object:  StoredProcedure [dbo].[proc_MSS_QLog_DeleteAll]    Script Date: 5/15/2018 12:11:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_QLog_DeleteAll
AS

truncate table MSSQLog
truncate table MSSQLogUrl
truncate table MSSQLogTemp
truncate table MSSQLogScope
truncate table MSSQLogBestBet
truncate table MSSQLogLocation
truncate table MSSQLogSiteGuid
truncate table MSSQLogHistorical
truncate table MSSQLogHistoricalTemp
truncate table MSSQLogQueryServer
truncate table MSSQLogQueryString
truncate table MSSQLogNonClicked
truncate table MSSQLogNonClickedTemp
truncate table MSSQLogQuerySummary 
truncate table MSSQLogQuerySummaryTemp
truncate table MSSQLogScopeSummary 
truncate table MSSQLogScopeSummaryTemp
truncate table MSSQLogClickedUrlSummary 
truncate table MSSQLogClickedUrlSummaryTemp
truncate table MSSQLogBestBetSummary 
truncate table MSSQLogLocationSummary
truncate table MSSQLogLocationSummaryTemp
truncate table MSSQLogResultsUrlSummaryTemp
truncate table MSSQLogContextualScope
truncate table MSSQLogContextualScopeName


GO
