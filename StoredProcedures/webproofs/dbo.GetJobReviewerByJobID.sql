/****** Object:  StoredProcedure [dbo].[GetJobReviewerByJobID]    Script Date: 5/15/2018 12:13:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[GetJobReviewerByJobID]
      @JobID BIGINT
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

      SELECT *
      FROM JobReviewer (NOLOCK)
      WHERE JobId = @JobID
END

GO
