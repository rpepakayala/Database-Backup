/****** Object:  StoredProcedure [dbo].[ClearScheduleConsistancyFlags]    Script Date: 5/15/2018 12:11:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[ClearScheduleConsistancyFlags]
AS
update [Schedule] with (tablock, xlock) set [ConsistancyCheck] = NULL

GO
