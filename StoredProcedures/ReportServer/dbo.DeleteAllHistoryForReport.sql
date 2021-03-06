/****** Object:  StoredProcedure [dbo].[DeleteAllHistoryForReport]    Script Date: 5/15/2018 12:11:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- delete all snapshots for a report
CREATE PROCEDURE [dbo].[DeleteAllHistoryForReport]
@ReportID uniqueidentifier
AS
SET NOCOUNT OFF
DELETE
FROM History
WHERE HistoryID in
   (SELECT HistoryID
    FROM History JOIN Catalog on ItemID = ReportID
    WHERE ReportID = @ReportID
   )

GO
