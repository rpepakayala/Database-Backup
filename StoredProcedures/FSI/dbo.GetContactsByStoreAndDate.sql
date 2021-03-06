/****** Object:  StoredProcedure [dbo].[GetContactsByStoreAndDate]    Script Date: 5/15/2018 12:09:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        <QUYNH TRAN>
-- Create date: <08/14/2009>
-- Description:   <GET CONTACT INFO FROM ALL ORDERS 
--               BY STOREID AND DATE RANGE>
-- =============================================
CREATE PROCEDURE [dbo].[GetContactsByStoreAndDate]
(     -- Add the parameters for the stored procedure here
      @FranchiseeID VARCHAR(7), 
      @StartDate DATETIME,
      @EndDate DATETIME
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

      SELECT DISTINCT c.ContactID, c.StoreID, c.CustomerID, c.FirstName, c.LastName, c.EmailAddress, o.zw_franchise_id
        FROM [order database] o (NOLOCK)
       INNER JOIN [contact database] c (NOLOCK) ON c.contactid = o.contactid AND o.zw_franchise_id = c.zw_franchise_id
       WHERE o.zw_franchise_id = @FranchiseeID 
         AND o.pickedupdate BETWEEN @StartDate AND @EndDate
END

GO
