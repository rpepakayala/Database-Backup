/****** Object:  StoredProcedure [dbo].[TempChunkExists]    Script Date: 5/15/2018 12:10:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROC [dbo].[TempChunkExists]
	@ChunkId uniqueidentifier
AS
BEGIN
	SELECT COUNT(1) FROM [KeystoneReportServerTempDB].dbo.SegmentedChunk
	WHERE ChunkId = @ChunkId
END

GO
