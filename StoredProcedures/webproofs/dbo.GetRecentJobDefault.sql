/****** Object:  StoredProcedure [dbo].[GetRecentJobDefault]    Script Date: 5/15/2018 12:13:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Quynh Tran
-- Create date: 5/12/10
-- Description:	Get Jobs for proofing application 
-- on default page
-- =============================================
CREATE PROCEDURE [dbo].[GetRecentJobDefault]
	@WebNumber INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DateToKeep DATETIME
	--DECLARE @WebNumber INT
	--SET @WebNumber = 900
	SET @DateToKeep = (SELECT TOP 1 DATEADD(dd,-COALESCE(daystokeepjobs, 90),GETDATE())
						FROM CenterSetting
						WHERE WebNumber = @WebNumber)

	SELECT  j.JobId,j.PGUID,j.Company,js.Label,j.DateCreated,j.LastUpdated,
		DATEADD(dd,COALESCE(daystokeepjobs, 90),j.LastUpdated) AS ExpirationDate,j.InvoiceNumber
	FROM job j (nolock) 
	INNER JOIN CenterSetting cs (nolock) on j.[CenterSettingId] = cs.[CenterSettingId]
	INNER JOIN JobState (NOLOCK) AS js ON js.[JobStateId] = j.[JobStateId]
	WHERE cs.webnumber = @WebNumber 
	AND j.JobStateId != 7
	AND LastUpdated > @DateToKeep
	ORDER BY LastUpdated DESC, j.JobId
END

GO
