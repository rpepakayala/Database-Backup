/****** Object:  StoredProcedure [dbo].[UpdateSnapshotPaginationInfo]    Script Date: 5/15/2018 12:11:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[UpdateSnapshotPaginationInfo]
@SnapshotDataID as uniqueidentifier, 
@IsPermanentSnapshot as bit, 
@PageCount as int,
@PaginationMode as smallint
AS
IF @IsPermanentSnapshot = 1
BEGIN
   UPDATE SnapshotData SET 
	PageCount = @PageCount, 	
	PaginationMode = @PaginationMode
   WHERE SnapshotDataID = @SnapshotDataID
END ELSE BEGIN
   UPDATE [ReportServerTempDB].dbo.SnapshotData SET 
	PageCount = @PageCount, 	
	PaginationMode = @PaginationMode
   WHERE SnapshotDataID = @SnapshotDataID
END      

GO
