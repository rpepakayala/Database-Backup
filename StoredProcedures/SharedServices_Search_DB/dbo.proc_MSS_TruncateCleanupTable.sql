/****** Object:  StoredProcedure [dbo].[proc_MSS_TruncateCleanupTable]    Script Date: 5/15/2018 12:11:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_TruncateCleanupTable
AS
   truncate table dbo.MSScrawledPropSamplesCleanup

GO
