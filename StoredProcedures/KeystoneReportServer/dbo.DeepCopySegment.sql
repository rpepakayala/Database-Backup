/****** Object:  StoredProcedure [dbo].[DeepCopySegment]    Script Date: 5/15/2018 12:09:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

create proc [dbo].[DeepCopySegment]
	@ChunkId		uniqueidentifier,
	@IsPermanent	bit,
	@SegmentId		uniqueidentifier,
	@NewSegmentId	uniqueidentifier out
as
begin
	select @NewSegmentId = newid() ;
	if (@IsPermanent = 1) begin
		insert Segment(SegmentId, Content)
		select @NewSegmentId, seg.Content
		from Segment seg
		where seg.SegmentId = @SegmentId ;
				
		update ChunkSegmentMapping
		set SegmentId = @NewSegmentId
		where ChunkId = @ChunkId and SegmentId = @SegmentId ;
	end
	else begin
		insert [KeystoneReportServerTempDB].dbo.Segment(SegmentId, Content)
		select @NewSegmentId, seg.Content
		from [KeystoneReportServerTempDB].dbo.Segment seg
		where seg.SegmentId = @SegmentId ;
		
		update [KeystoneReportServerTempDB].dbo.ChunkSegmentMapping
		set SegmentId = @NewSegmentId
		where ChunkId = @ChunkId and SegmentId = @SegmentId ; 
	end
end

GO
