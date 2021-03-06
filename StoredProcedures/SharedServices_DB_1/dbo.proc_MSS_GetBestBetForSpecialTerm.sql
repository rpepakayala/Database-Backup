/****** Object:  StoredProcedure [dbo].[proc_MSS_GetBestBetForSpecialTerm]    Script Date: 5/15/2018 12:11:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetBestBetForSpecialTerm
@ConsumerGpId NVARCHAR(50),
@Url NVARCHAR(2048),
@SpecialTermId int  AS

SELECT a.BestBetId, Title, Url, Description FROM MSSBestBets a, MSSBBConsumerGpLink b, MSSBestBetsLink c
where a.BestBetId = b.BestBetID and a.BestBetId = c.BestBetId and 
ConsumerGpId = @ConsumerGpId and c.SpecialTermId = @SpecialTermId
and a.Url = @Url


GO
