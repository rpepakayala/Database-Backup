/****** Object:  StoredProcedure [dbo].[zw_upsert_CloseOutDatabase]    Script Date: 5/15/2018 12:09:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 
 
CREATE PROCEDURE zw_upsert_CloseOutDatabase ( 
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
 
	exec [dbo].[zw_collection_meta_last_collection] @zw_franchise_id, 'CloseOut Database'
 
	 UPDATE [CloseOut Database] 
	 SET   
		[SignSales] = @SignSales, 
		[AVISales] = @AVISales, 
		[InstallSales] = @InstallSales, 
		[ProductionCat1Sales] = @ProductionCat1Sales, 
		[ProductionCat2Sales] = @ProductionCat2Sales, 
		[ProductionCat3Sales] = @ProductionCat3Sales, 
		[SalesSubtotal] = @SalesSubtotal, 
		[TaxExemptAmount] = @TaxExemptAmount, 
		[CountySalesTax] = @CountySalesTax, 
		[StateSalesTax] = @StateSalesTax, 
		[TaxTotal] = @TaxTotal, 
		[DiscountAmount] = @DiscountAmount, 
		[ShippingCharge] = @ShippingCharge, 
		[InterestAmount] = @InterestAmount, 
		[SalesTotal] = @SalesTotal, 
		[WriteOffAmount] = @WriteOffAmount, 
		[OrderPayments] = @OrderPayments, 
		[OtherPayments] = @OtherPayments, 
		[CloseOutPersonID] = @CloseOutPersonID, 
		[ModifiedByComputer] = @ModifiedByComputer, 
		[ModifiedDate] = @ModifiedDate, 
		[sys_du] = getdate(), 
		[zw_active] = 1 
		WHERE [zw_franchise_id] = @zw_franchise_id 
		AND [Date] = @Date
		AND [StoreID] = @StoreID
		AND [CloseOutType] = @CloseOutType
 
	IF @@ROWCOUNT = 0 
	BEGIN 
		INSERT INTO [CloseOut Database]( [Date], [StoreID], [CloseOutType], [SignSales], [AVISales], [InstallSales], [ProductionCat1Sales], [ProductionCat2Sales], [ProductionCat3Sales], [SalesSubtotal], [TaxExemptAmount], [CountySalesTax], [StateSalesTax], [TaxTotal], [DiscountAmount], [ShippingCharge], [InterestAmount], [SalesTotal], [WriteOffAmount], [OrderPayments], [OtherPayments], [CloseOutPersonID], [ModifiedByComputer], [ModifiedDate], [zw_franchise_id], [sys_di], [sys_du], [zw_active] ) 
		VALUES( @Date, @StoreID, @CloseOutType, @SignSales, @AVISales, @InstallSales, @ProductionCat1Sales, @ProductionCat2Sales, @ProductionCat3Sales, @SalesSubtotal, @TaxExemptAmount, @CountySalesTax, @StateSalesTax, @TaxTotal, @DiscountAmount, @ShippingCharge, @InterestAmount, @SalesTotal, @WriteOffAmount, @OrderPayments, @OtherPayments, @CloseOutPersonID, @ModifiedByComputer, @ModifiedDate, @zw_franchise_id, getdate(), getdate(), 1 ) 
	END 

GO
