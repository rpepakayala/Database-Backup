/****** Object:  View [dbo].[MaterialsGet]    Script Date: 5/15/2018 12:14:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW dbo.MaterialsGet
AS
SELECT     M.MatId AS MaterialID, M.MatVendorSku AS [Material Vendor SKU], M.MatName AS [Material Name], M.MatDesc AS Description, 
                      M.MatDisabled AS Disabled, M.MatHidden AS Hidden, V.VndDesc AS [Fullfillment Company], M.MatMinOrderQty AS [Material Minimum Order Amount], 
                      M.MatOrderInc AS [Material Order Amount Increments], S.Status AS Status, CONVERT(varchar, M.MatAvailFrom, 101) + ' to ' + CONVERT(varchar, 
                      M.MatAvailThru, 101) AS [Availability Date Range], M.MatRePrintable AS [Re-Printable?], M.MatReOrderSignUpDate AS [Preorder Sign-Up Date], 
                      'Min: ' + CONVERT(varchar, M.MatMinQtyLevel, 101) + ' Max: ' + CONVERT(varchar, M.MatMaxQtyLevel, 101) AS [Min/Max Inventory Levels], 
                      M.MatQtyAvailEstShipDays AS [Print and Pack Ship Days (Available Qty > 0)], 
                      M.MatQtyNotAvailEstShipDays AS [Pick and Pack Ship Days (Available Qty < 0 and reordered], 
                      M.MatQtyNotOrdEstShipDays AS [Pick and Pack Ship Days (Available Qty < 0 and not reordered], M.MatImprintShipDays AS [Imprint Ship Days], 
                      P.PrfSName AS [Proof Set], M.MatAvailMailOnDemand AS [Available for Mail on Demand], 'First Class: ' + CAST(M.MatFirstClassPostageFee AS varchar)
                       + ' Standard: ' + CAST(M.MatStndPostageFee AS varchar) AS [Mail type Options/Fee], dbo.fn_MaterialCategoriesGet(M.MatId) AS Categories, 
                      M.MatImage AS [Catalog Image], M.MatProofImage AS [Proof Image], R.Style AS [Display Shape], dbo.fn_MaterialSubsidiesGet(M.MatId) AS Subsidies, 
                      dbo.fn_MaterialAltsGet(M.MatId) AS [Alternate Materials]
FROM         dbo.Material M LEFT OUTER JOIN
                      dbo.Vendor V ON M.MatVendorId = V.VndId LEFT OUTER JOIN
                      dbo.Status S ON M.MatStatus = S.ID LEFT OUTER JOIN
                      dbo.ProofSet P ON M.MatProofSetId = P.PrfSId LEFT OUTER JOIN
                      dbo.PresentationStyle R ON M.MatPresentationStyle = R.ID

GO
