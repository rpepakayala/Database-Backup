/****** Object:  StoredProcedure [dbo].[proc_MSS_PurgePastCrawlLog]    Script Date: 5/15/2018 12:13:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_PurgePastCrawlLog
AS
BEGIN TRANSACTION
DELETE MSSCrawlUrlLog
COMMIT TRANSACTION

GO
