/****** Object:  StoredProcedure [dbo].[SystinoFranchiseSales_Enum]    Script Date: 5/15/2018 12:09:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Description:	Gets sales count and sales value for the last 365
-- =============================================

CREATE  PROCEDURE [dbo].[SystinoFranchiseSales_Enum]
	-- Add the parameters for the stored procedure here
	@ContactID varchar(30),
	@FranchiseID varchar(30)
AS
BEGIN
	DECLARE @Last365 DATETIME
  SET @Last365 =  getdate() - 365 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Count int, @Total Money, @SalesTotal varchar(30), @SalesCount varchar(30)
			
	SELECT	@Count = Count([od].[salesTotal]), @Total = sum([od].[salesTotal])
	
	FROM	[Orders].[OrderHeaderFact] od with (NOLOCK)
				JOIN [Store].[StoreFact] sd with (NOLOCK)
				ON od.CenterKey = sd.CenterKey
	WHERE	--[od].[status] = 'Picked-Up' AND 
				[od].[PickedUpDate] > @Last365
				AND [sd].[Status] = 1
				AND [od].[ContactID] = @ContactID
				AND [od].[ZW_Franchise_ID] = @FranchiseID
				
	-- figure out which bucket this is in for total
	IF @Total > 5000
		BEGIN
			SET @SalesTotal = 'High: $5,000+'
		END
	ELSE IF @Total > 1000 AND @Total < 5000
		BEGIN
			SET @SalesTotal = 'Medium: $1,000 - $5,000'
		END
	ELSE
		BEGIN
			SET @SalesTotal = 'Low: $1 - $1,000'
		END
		
	-- figure out which bucket this in for count
	
	IF @Count >= 4
		BEGIN
			SET @SalesCount = 'High: 4+'
		END
	ELSE IF @Count > 1 AND @Count <= 3
		BEGIN
			SET @SalesCount  = 'Medium: 2-3'
		END
	ELSE
		BEGIN
			SET @SalesCount  = 'Low: 1'
		END
		
	
	SELECT @SalesCount AS SalesCount, @SalesTotal as SalesTotal

	--GRANT EXECUTE ON SystinoFranchiseSales_Enum to [FASTSIGNS\app_systino_prod]

END


GO
