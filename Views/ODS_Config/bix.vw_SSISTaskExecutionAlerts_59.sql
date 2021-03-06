/****** Object:  View [bix].[vw_SSISTaskExecutionAlerts_59]    Script Date: 5/15/2018 12:14:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [bix].[vw_SSISTaskExecutionAlerts_59]
AS
(
    SELECT 
        [LogID],
        [ExecutionID],
        [SourceID],
        [SourceName],
        [SourceType],
        [LogDate],
        [EventType],
        [MessageCode],
        [MessageDescription]
    FROM [dbo].[SSISTaskExecutionAlerts]
)
GO
