/****** Object:  View [dbo].[vw_OrderDetails]    Script Date: 5/15/2018 12:14:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[vw_OrderDetails]
AS
    SELECT
        Orders.OrderDetailFact.ZW_Franchise_ID ,
        Orders.OrderDetailFact.OrderDetailID ,
        Orders.OrderDetailFact.OrderID ,
        Orders.OrderDetailFact.LineItemNumber ,
        Orders.OrderDetailFact.ProductID ,
        Product.DescriptionDim.DescriptionName AS ProductDecription ,
        Product.ProductCodeDim.ProductCodeName AS ProductCode ,
        Orders.OrderDetailFact.Quantity ,
        Orders.OrderDetailFact.Sides ,
        Orders.OrderDetailFact.Height ,
        Orders.OrderDetailFact.Width ,
        Orders.BackgroundColorDim.BackgroundColorName AS BackgroundColor ,
        Orders.FontDim.FontName AS Font ,
        Orders.OrderDetailFact.BasePrice ,
        Orders.OrderDetailFact.BasePriceOverriden ,
        Orders.OrderDetailFact.BasePriceCalculated ,
        Orders.OrderDetailFact.AVTotal ,
        Orders.OrderDetailFact.InstallAmount ,
        Orders.OrderDetailFact.DiscountAmount ,
        Orders.OrderDetailFact.DiscountPercentage ,
        Orders.OrderDetailFact.ItemTotal ,
        Orders.OrderDetailFact.UnitPriceOverridden ,
        Orders.OrderDetailFact.OverRidden ,
        Orders.OrderDetailFact.ItemTotalCalculated ,
        Orders.OrderDetailFact.Taxable ,
        Orders.OrderDetailFact.AllInstallation ,
        DescriptionDim1.DescriptionName AS OrderDetailDescription ,
        Orders.SignTextDim.SignTextName AS SignText ,
        Orders.OrderDetailFact.AVAdditionalAmt ,
        Orders.AVAdditionalDescriptionDim.AVAdditionalDescriptionName AS AVIAdditionalDescription ,
        Orders.OrderDetailFact.AVOverridden ,
        Orders.OrderDetailFact.AVCalculated ,
        Orders.OrderDetailFact.ProductionLocation ,
        Orders.OrderDetailFact.ShopTime ,
        Orders.OrderDetailFact.FieldTime ,
        Orders.OrderDetailFact.FieldCrewSize ,
        Orders.OrderDetailFact.MaterialCost ,
        Orders.OrderDetailFact.HeightAboveGround ,
        Orders.OrderDetailFact.ProductionCat3Sales ,
        Orders.OrderDetailFact.OtherInstallConsideration ,
        Orders.OrderDetailFact.SpecialEquipment1 ,
        Orders.OrderDetailFact.SpecialEquipment2 ,
        Orders.OrderDetailFact.SpecialEquipment3 ,
        Orders.OrderDetailFact.SpecialEquipmentOther ,
        Orders.OrderDetailFact.SpecialEquipmentOtherAmou ,
        Orders.OrderDetailFact.EstimatedInstallCharge ,
        Orders.OrderDetailFact.AccountCode ,
        Orders.OrderDetailFact.Hidden ,
        Orders.OrderDetailFact.PMsAnswered ,
        Orders.OrderDetailFact.ParentItemNumber ,
        Orders.OrderDetailFact.StateSalesTax ,
        Orders.OrderDetailFact.StateSalesTaxRate ,
        Orders.OrderDetailFact.BaseCost ,
        Orders.ProductionNotesDim.ProductionNotesName AS ProductionNotes
    FROM
        Orders.OrderDetailFact
        LEFT JOIN Product.ProductFact ON Orders.OrderDetailFact.ProductKey = Product.ProductFact.ProductKey
        LEFT JOIN Product.DescriptionDim ON Product.ProductFact.DescriptionKey = Product.DescriptionDim.DescriptionKey
        LEFT JOIN Product.ProductCodeDim ON Orders.OrderDetailFact.ProductCodeKey = Product.ProductCodeDim.ProductCodeKey
        LEFT JOIN Orders.BackgroundColorDim ON Orders.OrderDetailFact.BackgroundColorKey = Orders.BackgroundColorDim.BackgroundColorKey
        LEFT JOIN Orders.FontDim ON Orders.OrderDetailFact.FontKey = Orders.FontDim.FontKey
        LEFT JOIN Orders.DescriptionDim DescriptionDim1 ON Orders.OrderDetailFact.DescriptionKey = DescriptionDim1.DescriptionKey
        LEFT JOIN Orders.SignTextDim ON Orders.OrderDetailFact.SignTextKey = Orders.SignTextDim.SignTextKey
        LEFT JOIN Orders.AVAdditionalDescriptionDim ON Orders.OrderDetailFact.AVAdditionalDescriptionKey = Orders.AVAdditionalDescriptionDim.AVAdditionalDescriptionKey
        LEFT JOIN Orders.ProductionNotesDim ON Orders.OrderDetailFact.ProductionNotesKey = Orders.ProductionNotesDim.ProductionNotesKey

GO
