/****** Object:  View [dbo].[SSIS_StoreFact_StageLoad]    Script Date: 5/15/2018 12:13:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE VIEW [dbo].[SSIS_StoreFact_StageLoad]
AS
SELECT        Staging.dbo.StoreFact.ZW_Franchise_ID, Staging.dbo.StoreFact.StoreID, Staging.dbo.StoreFact.StoreNumber, Staging.dbo.StoreFact.WebNumber, 
                         Staging.dbo.StoreFact.GoldmineId, Staging.dbo.StoreFact.WebsiteUrl, Staging.dbo.StoreFact.AuditID, Staging.dbo.StoreFact.Status, 
                         Staging.dbo.StoreFact.RoyaltyFIIpercent, Staging.dbo.StoreFact.RoyaltyNACpercent, Staging.dbo.StoreFact.Alert, Staging.dbo.StoreFact.LimitedServices, 
                         Staging.dbo.StoreFact.COD, Staging.dbo.StoreFact.Operational, Staging.dbo.StoreFact.Pacesetter, Staging.dbo.StoreFact.VanityName, 
                         Staging.dbo.StoreFact.StoreOpenDate, Staging.dbo.StoreFact.Email, Staging.dbo.StoreFact.Reportable, Staging.dbo.StoreFact.STBLevel, Staging.dbo.StoreFact.ASI, 
                         Staging.dbo.StoreFact.EquipmentPackage, Staging.dbo.StoreFact.Router, Staging.dbo.StoreFact.LastConvention, Staging.dbo.StoreFact.OutsideSalesRep, 
                         Staging.dbo.StoreFact.Luminate, Staging.dbo.StoreFact.LocationType, Staging.dbo.StoreFact.TrafficCount, Staging.dbo.StoreFact.SingleOwner, 
                         Staging.dbo.StoreFact.OwnerCount, Staging.dbo.StoreFact.Landlord, Staging.dbo.StoreFact.FAC, Staging.dbo.StoreFact.NAC, Staging.dbo.StoreFact.TAC, 
                         Staging.dbo.StoreFact.SquareFeet, Staging.dbo.StoreFact.StoreType, Staging.dbo.StoreFact.Country, Staging.dbo.StoreFact.City, Staging.dbo.StoreFact.State, 
                         Staging.dbo.StoreFact.UpdateCheckSum, Staging.dbo.StoreFact.Zip, Staging.dbo.StoreFact.OpenStatus, Staging.dbo.StoreFact.Address, 
                         Staging.dbo.StoreFact.Region, Staging.dbo.StoreFact.Phone, Staging.dbo.StoreFact.FAX, Staging.dbo.StoreFact.FBC, Staging.dbo.StoreFact.Director, 
                         Staging.dbo.StoreFact.CloseDate, Staging.dbo.StoreFact.ResaleOpenDate, Store.OperationalDim.OperationalKey, Store.VanityNameDim.VanityNameKey, 
                         Store.STBLevelDim.STBLevelKey, Store.LocationTypeDim.LocationTypeKey, Store.StoreTypeDim.StoreTypeKey, Store.CountryDim.CountryKey, 
                         Store.CityDim.CityKey, Store.StateDim.StateKey,Staging.dbo.StoreFact.NCBC
FROM            Staging.dbo.StoreFact LEFT OUTER JOIN
                         Store.OperationalDim WITH (NOLOCK) ON Store.OperationalDim.OperationalName = Staging.dbo.StoreFact.Operational LEFT OUTER JOIN
                         Store.VanityNameDim WITH (NOLOCK) ON Store.VanityNameDim.VanityNameName = Staging.dbo.StoreFact.VanityName LEFT OUTER JOIN
                         Store.STBLevelDim WITH (NOLOCK) ON Store.STBLevelDim.STBLevelName = Staging.dbo.StoreFact.STBLevel LEFT OUTER JOIN
                         Store.LocationTypeDim WITH (NOLOCK) ON Store.LocationTypeDim.LocationTypeName = Staging.dbo.StoreFact.LocationType LEFT OUTER JOIN
                         Store.StoreTypeDim WITH (NOLOCK) ON Store.StoreTypeDim.StoreTypeName = Staging.dbo.StoreFact.StoreType LEFT OUTER JOIN
                         Store.CountryDim WITH (NOLOCK) ON Store.CountryDim.CountryName = Staging.dbo.StoreFact.Country LEFT OUTER JOIN
                         Store.CityDim WITH (NOLOCK) ON Store.CityDim.CityName = Staging.dbo.StoreFact.City LEFT OUTER JOIN
                         Store.StateDim WITH (NOLOCK) ON Store.StateDim.StateName = Staging.dbo.StoreFact.State



GO
