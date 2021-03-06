/****** Object:  StoredProcedure [dbo].[DeleteHistoryRecord]    Script Date: 5/15/2018 12:11:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- delete one historical snapshot
CREATE PROCEDURE [dbo].[DeleteHistoryRecord]
@ReportID uniqueidentifier,
@SnapshotDate DateTime
AS
SET NOCOUNT OFF
DELETE
FROM History
WHERE ReportID = @ReportID AND SnapshotDate = @SnapshotDate

GO
