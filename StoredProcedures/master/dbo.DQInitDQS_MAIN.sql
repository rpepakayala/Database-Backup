/****** Object:  StoredProcedure [dbo].[DQInitDQS_MAIN]    Script Date: 5/15/2018 12:10:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[DQInitDQS_MAIN] AS BEGIN     EXEC [##MS_DQS_CURRENT_SERVER##].[DQS_MAIN].[internal_core].[RefreshAssemblies];    EXEC [DQS_MAIN].[internal_core].[InitServer] 1;END
EXEC sp_procoption N'[dbo].[DQInitDQS_MAIN]', 'startup', '1'

GO
