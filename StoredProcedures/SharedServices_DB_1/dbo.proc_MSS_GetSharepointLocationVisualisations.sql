/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSharepointLocationVisualisations]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetSharepointLocationVisualisations(
    @LocationId int,
    @FullVisualisationName nvarchar(60) = 'full',
    @SummaryVisualisationName nvarchar(60) = 'summary',
    @TopAnswerVisualisationName nvarchar(60) = 'topanswer')
 AS

SET NOCOUNT ON

DECLARE @LastError int

Exec @LastError = dbo.proc_MSS_GetLocationVisualisations @LocationId, @FullVisualisationName
IF @LastError <> 0
BEGIN 
   RETURN @LastError
END

Exec @LastError = dbo.proc_MSS_GetLocationVisualisations @LocationId, @SummaryVisualisationName
IF @LastError <> 0
BEGIN 
   RETURN @LastError
END

Exec @LastError = dbo.proc_MSS_GetLocationVisualisations @LocationId, @TopAnswerVisualisationName
IF @LastError <> 0
BEGIN 
   RETURN @LastError
END

RETURN 0

GO
