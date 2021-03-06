/****** Object:  StoredProcedure [dbo].[DeleteHistoriesWithNoPolicy]    Script Date: 5/15/2018 12:11:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- delete all snapshots for all reports that inherit system History policy
CREATE PROCEDURE [dbo].[DeleteHistoriesWithNoPolicy]
AS
SET NOCOUNT OFF
DELETE
FROM History
WHERE HistoryID in
   (SELECT HistoryID
    FROM History JOIN Catalog on ItemID = ReportID
    WHERE SnapshotLimit is null
   )

GO
