/****** Object:  StoredProcedure [dbo].[SearchJobDefaultCompany]    Script Date: 5/15/2018 12:13:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Quynh Tran
-- Create date: 5/12/10
-- Description:	Get Jobs for proofing application 
-- on default page
-- =============================================
CREATE PROCEDURE [dbo].[SearchJobDefaultCompany]
	@WebNumber INT,
	@SearchString VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  j.JobId,j.PGUID,j.Company,'' AS Label,j.DateCreated,j.LastUpdated,
		DATEADD(dd,COALESCE(daystokeepjobs, 90),j.LastUpdated) AS ExpirationDate,j.InvoiceNumber
	FROM job j (nolock) 
	INNER JOIN CenterSetting cs (nolock) on j.[CenterSettingId] = cs.[CenterSettingId]
	WHERE cs.webnumber = @WebNumber 
	AND j.Company LIKE @SearchString
	ORDER BY LastUpdated DESC, j.JobId
END

GO
