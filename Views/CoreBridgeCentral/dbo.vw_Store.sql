/****** Object:  View [dbo].[vw_Store]    Script Date: 5/15/2018 12:13:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[vw_Store] AS
Select
  fii_ods.dbo.vw_Store.ZW_Franchise_ID,
  fii_ods.dbo.vw_Store.WebNumber,
  fii_ods.dbo.vw_Store.StoreNumber,
  fii_ods.dbo.vw_Store.VanityName,
  fii_ods.dbo.vw_Store.OpenStatus,
  fii_ods.dbo.vw_Store.Status,
  fii_ods.dbo.vw_Store.Address,
  fii_ods.dbo.vw_Store.CityName,
  fii_ods.dbo.vw_Store.StateName,
  fii_ods.dbo.vw_Store.Zip,
  fii_ods.dbo.vw_Store.CountryName,
  fii_ods.dbo.vw_Store.CountryCode,
  fii_ods.dbo.vw_Store.Country,
  fii_ods.dbo.vw_Store.Region,
  fii_ods.dbo.vw_Store.RegionName,
  fii_ods.dbo.vw_Store.Phone,
  fii_ods.dbo.vw_Store.FAX,
  fii_ods.dbo.vw_Store.FBC,
  fii_ods.dbo.vw_Store.GoldmineId,
  fii_ods.dbo.vw_Store.RoyaltyFIIpercent,
  fii_ods.dbo.vw_Store.RoyaltyNACpercent,
  fii_ods.dbo.vw_Store.Alert,
  fii_ods.dbo.vw_Store.LimitedServices,
  fii_ods.dbo.vw_Store.COD,
  fii_ods.dbo.vw_Store.Pacesetter,
  fii_ods.dbo.vw_Store.StoreOpenDate,
  fii_ods.dbo.vw_Store.Email,
  fii_ods.dbo.vw_Store.Reportable,
  fii_ods.dbo.vw_Store.ASI,
  fii_ods.dbo.vw_Store.EquipmentPackage,
  fii_ods.dbo.vw_Store.Router,
  fii_ods.dbo.vw_Store.LastConvention,
  fii_ods.dbo.vw_Store.OutsideSalesRep,
  fii_ods.dbo.vw_Store.Luminate,
  fii_ods.dbo.vw_Store.TrafficCount,
  fii_ods.dbo.vw_Store.SingleOwner,
  fii_ods.dbo.vw_Store.OwnerCount,
  fii_ods.dbo.vw_Store.Landlord,
  fii_ods.dbo.vw_Store.FAC,
  fii_ods.dbo.vw_Store.NAC,
  fii_ods.dbo.vw_Store.TAC,
  fii_ods.dbo.vw_Store.SquareFeet,
  fii_ods.dbo.vw_Store.StoreTypeName,
  fii_ods.dbo.vw_Store.STBLevelName,
  fii_ods.dbo.vw_Store.LocationTypeName,
  fii_ods.dbo.vw_Store.OperationalName,
  fii_ods.dbo.vw_Store.CenterKey,
  fii_ods.dbo.vw_Store.ResaleOpenDate,
  fii_ODS.System.StoreControl.DataSource,
  fii_ODS.System.StoreControl.AsOfDate,
  fii_ODS.System.StoreControl.CoreDate
From
  fii_ods.dbo.vw_Store
  Left Join fii_ODS.System.StoreControl
    On fii_ODS.System.StoreControl.ZW_Franchise_ID =
    fii_ods.dbo.vw_Store.ZW_Franchise_ID

GO
