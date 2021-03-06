/****** Object:  StoredProcedure [dbo].[usp_DisableShippingForStore]    Script Date: 5/15/2018 12:11:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:           Alex, Montminy
-- Create date: 6/22/2016
-- Description: Disables Shipping for all products in the Store
-- =============================================
CREATE PROCEDURE [dbo].[usp_DisableShippingForStore]
       -- Add the parameters for the stored procedure here
       @StoreID int
       
AS
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;

    -- Insert statements for procedure here
update ProductVariant
set IsShipEnabled =0
--  FROM [MyCatalog].[dbo].[Store]
  where StoreId = @StoreID

END
GO
