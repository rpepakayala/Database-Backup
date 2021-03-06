/****** Object:  UserDefinedFunction [dbo].[SalesAndTaxes_SDate_EDate_ReportOn_GetClosed]    Script Date: 5/15/2018 12:15:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION SalesAndTaxes_SDate_EDate_ReportOn_GetClosed (    @StartDateTime            DateTime,
    @EndDateTime              DateTime,
    @ReportOn                 Char(1),
    @GetCloseOutID            Bit)
   RETURNS TABLE
   AS
   RETURN (

select 
       -- GL Related Fields
       GL.EntryDateTime, 
       sum(case when @ReportOn <> 'P' THEN GL.Amount
                when GL.GLAccountID in (11, 12) THEN -GL.Amount
                when GLAccount.GLClassificationType in (4000, 2005) THEN GL.Amount
                else 0 end
            ) as GLAmount,
       GL.GLAccountID,
       GL.GLAccountClassTypeID,
       GL.Classification,
       GLAccount.GLClassificationType,
       GLAccount.AccountName,
       GL.DivisionID,
       GL.IsTaxable,
       GL.TaxClassID,
       GL.GroupID,
       Case when @GetCloseOutID=1 then
       (select top 1 Closeout.ID from CloseOut with(nolock) join Journal with(nolock)  on Closeout.ID = Journal.ID
        where CloseOutType = 1 and GL.GroupID between Journal.StartGLGroupID and Journal.EndGLGroupID)
        else 0 end as DailyCloseOutID,

        Case when @GetCloseOutID=1 then
       (select top 1 Closeout.ID from CloseOut join Journal with(nolock)  on Closeout.ID = Journal.ID
        where CloseOutType = 2 and GL.GroupID between Journal.StartGLGroupID and Journal.EndGLGroupID)
        else 0 end as MonthlyCloseOutID,

        Case when @GetCloseOutID=1 then
       (select top 1 Closeout.ID from CloseOut join Journal with(nolock)  on Closeout.ID = Journal.ID
        where CloseOutType = 3 and GL.GroupID between Journal.StartGLGroupID and Journal.EndGLGroupID)
        else 0 end as YearlyCloseOutID,

       -- TransHeader Related Fields
       GL.TransactionID, 
       TransHeader.OrderNumber,
       Coalesce( TransHeader.InvoiceNumber, TransHeader.OrderNumber) as InvoiceNumber,
       TransHeader.CreditMemoOrderID,
       TransHeader.Salesperson1ID,
       TransHeader.Salesperson2ID,
       TransHeader.Salesperson3ID,
       TransHeader.OrderOriginID,
       TransHeader.InvoiceAddressID as OrderInvoiceAddressID,
       TransHeader.PromotionID,
       TransHeader.PricingLevelID, 
	   TransHeader.ClosedDate,
	   Cast(TransHeader.Description as VarChar(30)) as OrderDescription,
		1 + Case When TransHeader.Salesperson2ID IS NULL THEN 0 ELSE 1 END + Case When TransHeader.Salesperson3ID IS NULL THEN 0 ELSE 1 END as SalesPeopleCount,

       -- TransDetail Related Fields
       GL.TransDetailID,
       TransDetail.LineItemNumber,
       TransDetail.Quantity,
       GL.GoodsItemID,
       TransDetail.GoodsItemCode,

       -- Account Related Fields
       GL.AccountID,
       Account.CompanyName,
       Account.AccountNumber,
       Account.PricingPlanTypeID,
       Account.IndustryID,
       Account.OriginID as CompanyOriginID,
       Account.Marketing3ID,
       Account.BillingAddressID as CompanyBillingAddressID

from GL with(nolock) 

left join TransHeader with(nolock) on (TransHeader.ID = GL.TransactionID)

left join Account with(nolock) on (Account.ID = GL.AccountID)

left join TransDetail with(nolock) on (TransDetail.ID = GL.TransDetailID)

left join GLAccount with(nolock) on (GLAccount.ID = GL.GLAccountID)

where 

(
@ReportOn = 'P' 
  and (GLAccount.GLClassificationType in (4000) or GL.ID in (11, 12))
  and GL.EntryDateTime between @StartDateTime and @EndDateTime
)

or 
--   'C' used for Closed Reports
(
@ReportOn='C' 
  and GLAccount.GLClassificationType in (4000, 2005) 
  and TransHeader.ClosedDate between @StartDateTime and @EndDateTime
)

or 
--   'S' used for Sales Reports (everything else so it is the default)
(
@ReportOn not in ('C','P')
  and GLAccount.GLClassificationType in (4000, 2005) 
  and GL.EntryDateTime between @StartDateTime and @EndDateTime
)

group by
       -- GL Related Fields
       GL.EntryDateTime, 
       -- Sum(GL.Amount) as GLAmount,
       GL.GLAccountID,
       GL.GLAccountClassTypeID,
       GL.Classification,
       GLAccount.GLClassificationType,
       GLAccount.AccountName,
       GL.DivisionID,
       GL.IsTaxable,
       GL.TaxClassID,
       GL.GroupID,

       -- TransHeader Related Fields
         GL.TransactionID, 
       TransHeader.OrderNumber,
       Coalesce( TransHeader.InvoiceNumber, TransHeader.OrderNumber),
       TransHeader.CreditMemoOrderID,
       TransHeader.Salesperson1ID,
       TransHeader.Salesperson2ID,
       TransHeader.Salesperson3ID,
       TransHeader.OrderOriginID,
       TransHeader.InvoiceAddressID,
       TransHeader.PromotionID,
       TransHeader.PricingLevelID, 
       TransHeader.ClosedDate,
	     Cast(TransHeader.Description as VarChar(30)),

       -- TransDetail Related Fields
       GL.TransDetailID,
       TransDetail.LineItemNumber,
       TransDetail.Quantity,
       GL.GoodsItemID,
       TransDetail.GoodsItemCode,

       -- Account Related Fields
       GL.AccountID,
       Account.CompanyName,
       Account.AccountNumber,
       Account.PricingPlanTypeID,
       Account.IndustryID,
       Account.OriginID,
       Account.Marketing3ID,
       Account.BillingAddressID

having
       sum(case when @ReportOn <> 'P' THEN GL.Amount
                when GL.GLAccountID in (11, 12) THEN -GL.Amount
        when GLAccount.GLClassificationType in (4000, 2005) THEN GL.Amount
        else 0 end) <> 0)

GO
