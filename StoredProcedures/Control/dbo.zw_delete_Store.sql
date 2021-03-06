/****** Object:  StoredProcedure [dbo].[zw_delete_Store]    Script Date: 5/15/2018 12:09:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
CREATE PROCEDURE zw_delete_Store ( 
@ID int  = NULL , 
@StoreID int  = NULL , 
@ClassTypeID int  = NULL , 
@ModifiedByUser [nvarchar](25)   = NULL , 
@ModifiedByComputer [nvarchar](25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@SeqID int  = NULL , 
@IsSystem bit  = NULL , 
@IsActive bit  = NULL , 
@CompanyName [nvarchar](60)   = NULL , 
@StoreNumber [nvarchar](25)   = NULL , 
@AddressID int  = NULL , 
@EmailAddress [nvarchar](50)   = NULL , 
@TagLine [nvarchar](75)   = NULL , 
@InvoicePrefix [nvarchar](10)   = NULL , 
@TaxIdentifier [nvarchar](25)   = NULL , 
@DefaultAreaCode [nvarchar](10)   = NULL , 
@DefaultDueTime datetime  = NULL , 
@DepositPercentage [decimal](18,0)  = NULL , 
@OrderMinimum [decimal](18,0)  = NULL , 
@PhoneNumberID int  = NULL , 
@FaxNumberID int  = NULL , 
@LogoID int  = NULL , 
@ManagerID int  = NULL , 
@ScreenTemplateID int  = NULL , 
@WebInputTemplateID int  = NULL , 
@InvoiceTemplateID int  = NULL , 
@EstimateTemplateID int  = NULL , 
@WorkOrderTemplateID int  = NULL , 
@EmployeeWebOutputTemplateID int  = NULL , 
@CustomerWebOutputTemplateID int  = NULL , 
@DefaultTaxClassID int  = NULL , 
@AutoDecLunch bit  = NULL , 
@HoursBeforeLunch int  = NULL , 
@LunchMinutes int  = NULL , 
@MinClockInTime datetime  = NULL , 
@MaxClockOutTime datetime  = NULL , 
@DefaultpaymentTermID int  = NULL , 
@MktgListCode1Name [nvarchar](25)   = NULL , 
@MktgListCode2Name [nvarchar](25)   = NULL , 
@RoundingOption int  = NULL , 
@RoundingDigits int  = NULL , 
@RoyaltyFee1Name [nvarchar](25)   = NULL , 
@RoyaltyFee1 float  = NULL , 
@RoyaltyFee2Name [nvarchar](25)   = NULL , 
@RoyaltyFee2 float  = NULL , 
@DepositMinimum float  = NULL , 
@WebAddress varchar(50)  = NULL , 
@DefaultCountryCode varchar(10)  = NULL , 
@StarShipProductID int  = NULL , 
@StarShipProductStoreID int  = NULL , 
@StarShipProductClassTypeID int  = NULL , 
@EquipmentCostMultiplier [nvarchar](MAX)   = NULL , 
@LaborCostMultiplier [nvarchar](MAX)   = NULL , 
@MaterialCostMultiplier [nvarchar](MAX)   = NULL , 
@OutsourceCostMultiplier [nvarchar](MAX)   = NULL , 
@OtherCostMultiplier [nvarchar](MAX)   = NULL , 
@UseTaxLookup bit  = NULL , 
@InvoiceAsOrderNumber bit  = NULL , 
@QPHomeListID int  = NULL , 
@QPHomeListStoreID int  = NULL , 
@QPTransListID int  = NULL , 
@QPTransListStoreID int  = NULL , 
@QPServiceListID int  = NULL , 
@QPServiceListStoreID int  = NULL , 
@FreightCostMultiplier [nvarchar](MAX)   = NULL , 
@ParamToVarList [nvarchar](MAX)   = NULL , 
@BillingAddressID int  = NULL , 
@ShippingAddressID int  = NULL , 
@zw_franchise_id char(7)
)
AS
SET NOCOUNT ON
 
	 UPDATE [Store] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [ID] = @ID
		AND [StoreID] = @StoreID
		AND [ClassTypeID] = @ClassTypeID

GO
