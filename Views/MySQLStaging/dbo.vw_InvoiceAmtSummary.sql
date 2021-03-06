/****** Object:  View [dbo].[vw_InvoiceAmtSummary]    Script Date: 5/15/2018 12:14:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON




CREATE VIEW [dbo].[vw_InvoiceAmtSummary]
AS

Select
  Inv_Line.franchise_id As Franchise_ID,
  Inv_Line.job_sequence As Job,
  Inv_Line.job_id,
  Inv_Line.description As Description,
  Sum(Case
    When Inv_Line.Type = 'In-House' Then Inv_Line.ext_price
    Else 0 End) As InHouse,
  Sum(Case
    When Inv_Line.Type = 'Subcontract' Then Inv_Line.ext_price
    Else 0 End) As Subcontract,
  Sum(Case When Inv_Line.Type = 'Rental' Then Inv_Line.ext_price
    Else 0 End) As Rental,
  Sum(Inv_Line.discount) As Discount,
  Sum(Inv_Line.amount_due) As SalesSubTotal,
  Sum(Inv_Line.tax) As Tax,
  Sum(Inv_Line.amount_due + Inv_Line.tax) As InvoiceTotal,
  Sum(Inv_Line.amount_paid) As Payments,
  Sum(Inv_Line.amount_due + Inv_Line.tax - Inv_Line.amount_paid) As BalDue
From
  (Select
    job_line_item_report_view.franchise_id,
    job_line_item_report_view.job_sequence,
	job_line_item_report_view.job_id,
    job_line_item_report_view.description,
    job_line_item_report_view.name,
    Case When job_line_item_report_view.SERVICE = 'Product' Then 'In-House'
      Else revenue_locations.name End As Type,
    job_line_item_report_view.SERVICE,
  invoice_line_items.quantity,
  invoice_line_items.price,
  invoice_line_items.ext_price,
  invoice_line_items.discount,
  invoice_line_items.tax ,
  invoice_line_items.tax_rate,
  invoice_line_items.amount_due,
  invoice_line_items.amount_paid,
  invoice_line_items.date_paid
From
  job_line_item_report_view
  Left Join services On job_line_item_report_view.service_id =
    services.service_id
  Left Join revenue_locations On services.revenue_location_id =
    revenue_locations.revenue_location_id
  Inner Join invoice_line_items
    On job_line_item_report_view.invoice_line_item_id =
    invoice_line_items.invoice_line_item_id ) Inv_line
Group By
  Inv_Line.franchise_id, Inv_Line.job_sequence, Inv_Line.job_id,Inv_Line.description

    --SELECT
    --    Inv_Line.franchise_id AS Franchise_ID ,
    --    Inv_Line.job_sequence AS Job ,
    --    Inv_Line.description AS Description ,
    --    SUM(CASE WHEN Inv_Line.Type = 'In-House'
    --             THEN Inv_Line.amount_due + Inv_Line.tax
    --             ELSE 0
    --        END) AS InHouse ,
    --    SUM(CASE WHEN Inv_Line.Type = 'Subcontract'
    --             THEN Inv_Line.amount_due + Inv_Line.tax
    --             ELSE 0
    --        END) AS Subcontract ,
    --    SUM(CASE WHEN Inv_Line.Type = 'Rental'
    --             THEN Inv_Line.amount_due + Inv_Line.tax
    --             ELSE 0
    --        END) AS Rental ,
    --    SUM(Inv_Line.discount) AS Discout ,
    --    SUM(Inv_Line.amount_due) AS SalesSubTotal ,
    --    SUM(Inv_Line.tax) AS Tax ,
    --    SUM(Inv_Line.amount_due + Inv_Line.tax) AS InvoiceTotal ,
    --    SUM(Inv_Line.amount_paid) AS Payments ,
    --    SUM(Inv_Line.amount_due + Inv_Line.tax - Inv_Line.amount_paid) AS BalDue
    --FROM
    --    ( SELECT
    --        job_line_item_report_view.franchise_id ,
    --        job_line_item_report_view.job_sequence ,
    --        job_line_item_report_view.description ,
    --        job_line_item_report_view.name ,
    --        CASE WHEN job_line_item_report_view.SERVICE = 'Product'
    --             THEN 'In-House'
    --             ELSE revenue_locations.name
    --        END AS Type ,
    --        job_line_item_report_view.tax ,
    --        job_line_item_report_view.amount_due ,
    --        job_line_item_report_view.amount_paid ,
    --        job_line_item_report_view.discount ,
    --        job_line_item_report_view.SERVICE
    --      FROM
    --        job_line_item_report_view
    --        LEFT JOIN services ON job_line_item_report_view.service_id = services.service_id
    --        LEFT JOIN revenue_locations ON services.revenue_location_id = revenue_locations.revenue_location_id
    --    ) Inv_Line
    --GROUP BY
    --    Inv_Line.franchise_id ,
    --    Inv_Line.job_sequence ,
    --    Inv_Line.description




GO
