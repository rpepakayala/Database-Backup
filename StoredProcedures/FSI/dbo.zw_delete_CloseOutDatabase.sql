/****** Object:  StoredProcedure [dbo].[zw_delete_CloseOutDatabase]    Script Date: 5/15/2018 12:09:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_delete_CloseOutDatabase ( 
@Date datetime  = NULL , 
@StoreID int  = NULL , 
@CloseOutType varchar(1)   = NULL , 
@SignSales float  = NULL , 
@AVISales float  = NULL , 
@InstallSales float  = NULL , 
@ProductionCat1Sales float  = NULL , 
@ProductionCat2Sales float  = NULL , 
@ProductionCat3Sales float  = NULL , 
@SalesSubtotal float  = NULL , 
@TaxExemptAmount float  = NULL , 
@CountySalesTax float  = NULL , 
@StateSalesTax float  = NULL , 
@TaxTotal float  = NULL , 
@DiscountAmount float  = NULL , 
@ShippingCharge float  = NULL , 
@InterestAmount float  = NULL , 
@SalesTotal float  = NULL , 
@WriteOffAmount float  = NULL , 
@OrderPayments float  = NULL , 
@OtherPayments float  = NULL , 
@CloseOutPersonID int  = NULL , 
@ModifiedByComputer varchar(25)   = NULL , 
@ModifiedDate datetime  = NULL , 
@zw_franchise_id varchar(10)
)
AS
SET NOCOUNT ON
 
	 UPDATE [CloseOut Database] 
	 SET 
		[zw_active] = 0, 
		[sys_du] = getdate() 
	 WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [Date] = @Date
		AND [StoreID] = @StoreID
		AND [CloseOutType] = @CloseOutType

GO
