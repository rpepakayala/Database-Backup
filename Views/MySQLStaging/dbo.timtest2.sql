/****** Object:  View [dbo].[timtest2]    Script Date: 5/15/2018 12:14:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW timtest2 
AS
Select Distinct
  jobs.job_id,
  jobs.franchise_id,
  CAST(jobs.sequence AS INT) As Job,
  jobs.description As JobDesc,
  IsNull(job_line_items.phase_id, IsNull(Serv.phase_id, IsNull(Modi.phase_id,
  ServiceOnly.phase_id))) As phase_id,
  invoices.sequence As InvoiceSequence,
  invoice_line_items.type,
  jobs.created_on As JobCreatedOn,
  jobs.expires_on As JobExpiresOn,
  jobs.completed_date As JobCompletedDate,
  jobs.accounts_id As JobAccountsID,
  job_line_items.job_line_item_id,
  job_line_items.parent_id,
  Convert(varchar(6),jobs.sequence) + '-' + Case
    When sub.sequence Is Null Then (Case
      When invoice_line_items.type = 'service' Then Serv.letter
      When invoice_line_items.type = 'modifier' Then Modi.letter
      When job_line_items.name = 'Service Only' Then ServiceOnly.letter
      Else system.linenumbertoletter.letter End)
    Else Convert(VARCHAR(4),system.linenumbertoletter.letter + IsNull('-' +
    Convert(VARCHAR(2),job_line_items.sequence), '')) End As JobLineLabel,
  job_line_items.name As ProductName,
  sub.name As SubProductName,
  job_line_items.product_id As MailProductID,
  sub.product_id As SubProductID,
  Case When job_line_items.parent_id Is Not Null Then sub.product_id
    Else job_line_items.product_id End As productid,
  Case When job_line_items.parent_id Is Not Null Then sub.invoice_line_item_id
    Else invoice_line_items.invoice_line_item_id End As invoice_line_item_id,
  Case When job_line_items.parent_id Is Not Null Then sub.usage_id
    Else job_line_items.usage_id End As usage_id,
  Case When job_line_items.parent_id Is Not Null Then sub.unit_cost
    Else job_line_items.unit_cost End As unit_cost,
  Case When job_line_items.parent_id Is Not Null Then sub.due_date
    Else job_line_items.due_date End As due_date,
  Case When job_line_items.parent_id Is Not Null Then sub.proofs_due
    Else job_line_items.proofs_due End As proofs_due,
  Case When job_line_items.parent_id Is Not Null Then sub.production_due_date
    Else job_line_items.production_due_date End As production_due_date,
  Case When job_line_items.parent_id Is Not Null Then sub.production_order
    Else job_line_items.production_order End As production_order,
  Case When job_line_items.parent_id Is Not Null Then sub.shipping_package_id
    Else job_line_items.shipping_package_id End As shipping_package_id,
  Case When job_line_items.parent_id Is Not Null Then sub.company_po
    Else job_line_items.company_po End As company_po,
  Case When job_line_items.parent_id Is Not Null Then sub.sign_text
    Else job_line_items.sign_text End As sign_text,
  Case When job_line_items.parent_id Is Not Null Then sub.[desc]
    Else job_line_items.[desc] End As LineDesc,
  Case When job_line_items.parent_id Is Not Null Then sub.production_minutes
    Else job_line_items.production_minutes End As production_minutes,
  Case When job_line_items.parent_id Is Not Null Then sub.created_by
    Else job_line_items.created_by End As created_by,
  Case When job_line_items.parent_id Is Not Null Then sub.created_on
    Else job_line_items.created_on End As created_on,
  Case When job_line_items.parent_id Is Not Null Then sub.last_modified_on
    Else job_line_items.last_modified_on End As last_modified_on,
  Case When job_line_items.parent_id Is Not Null Then sub.last_modified_by
    Else job_line_items.last_modified_by End As last_modified_by,
  Case When job_line_items.parent_id Is Not Null Then sub.invoice_line_item_id
    Else job_line_items.invoice_line_item_id End As invoice_line_item_id_link,
  invoice_line_items.quantity,
  invoice_line_items.price,
  invoice_line_items.ext_price,
  invoice_line_items.discount,
  invoice_line_items.tax,
  invoice_line_items.tax_rate,
  invoice_line_items.amount_due,
  invoice_line_items.amount_paid,
  invoice_line_items.date_paid,
  SalesSubTotal = invoice_line_items.amount_due - invoice_line_items.tax,
  invoices.contact_entity_id,
  invoices.account_entity_id,
  invoices.invoiced_on,
  invoices.paid_on,
  jobs.po_number,
  Case When invoice_line_items.type = 'service' Then Serv.revenue_location
    When invoice_line_items.type = 'modifier' Then Modi.RevenueLocation
    When job_line_items.name = 'Service Only' Then ServiceOnly.ServiceRevLoc
    Else revenue_locations.name End As RevenueLocation,
  accounts.company_name,
  invoice_line_items.date_placed,
  invoice_line_items.date_unplaced,
  IsNull(job_line_items.prod_desc, Upper(invoice_line_items.type)) As
  Job_Line_Prod_Desc,
  IsNull(job_line_items.[desc], Upper(invoice_line_items.type)) As
  Job_Line_Desc,
  system.linenumbertoletter.letter
From
  invoice_line_items
  Left Join invoices On invoices.invoice_id = invoice_line_items.invoice_id
  Inner Join jobs On jobs.job_id = invoices.job_id
  Left Join job_line_items On invoice_line_items.invoice_line_item_id =
    job_line_items.invoice_line_item_id
  Left Join job_line_items sub On job_line_items.parent_id =
    sub.job_line_item_id
  Left Join (Select
    ili.invoice_line_item_id,
    services.name,
    services.description,
    revenue_locations.name As revenue_location,
    job_line_items_services.job_line_item_id,
    job_line_items.sequence,
    job_line_items.phase_id,
    system.linenumbertoletter.letter
  From
    invoice_line_items ili Join
    job_line_items_services On ili.invoice_line_item_id =
      job_line_items_services.invoice_line_item_id Inner Join
    services On job_line_items_services.service_id = services.service_id
    Inner Join
    revenue_locations On services.revenue_location_id =
      revenue_locations.revenue_location_id Left Join
    job_line_items On job_line_items_services.job_line_item_id =
      job_line_items.job_line_item_id Left Join
    system.linenumbertoletter On job_line_items.sequence =
      system.linenumbertoletter.linenumber) Serv
    On invoice_line_items.invoice_line_item_id = Serv.invoice_line_item_id
  Left Join (Select
    ili.invoice_line_item_id,
    products.display_name,
    revenue_locations.name As RevenueLocation,
    job_line_items.sequence,
    job_line_items.phase_id,
    system.linenumbertoletter.letter
  From
    invoice_line_items ili Join
    job_line_items_modifiers On ili.invoice_line_item_id =
      job_line_items_modifiers.invoice_line_item_id Left Join
    job_line_items On job_line_items_modifiers.job_line_item_id =
      job_line_items.job_line_item_id Left Join
    products On job_line_items.product_id = products.product_id Left Join
    revenue_locations On products.revenue_location_id =
      revenue_locations.revenue_location_id Left Join
    system.linenumbertoletter On job_line_items.sequence =
      system.linenumbertoletter.linenumber) Modi
    On invoice_line_items.invoice_line_item_id = Modi.invoice_line_item_id
  Left Join products On job_line_items.product_id = products.product_id
  Left Join revenue_locations On products.revenue_location_id =
    revenue_locations.revenue_location_id
  Left Join accounts On jobs.accounts_id = accounts.accounts_id
  Left Join (Select
    job_line_items.job_line_item_id,
    services.revenue_location_id,
    revenue_locations.name As ServiceRevLoc,
    job_line_items.sequence,
    job_line_items.phase_id,
    system.linenumbertoletter.letter
  From
    job_line_items Join
    job_line_items_services jlis On job_line_items.job_line_item_id =
      jlis.job_line_item_id Left Join
    services On jlis.service_id = services.service_id Left Join
    revenue_locations On services.revenue_location_id =
      revenue_locations.revenue_location_id Left Join
    system.linenumbertoletter On job_line_items.sequence =
      system.linenumbertoletter.linenumber) ServiceOnly
    On job_line_items.job_line_item_id = ServiceOnly.job_line_item_id
  Left Join system.linenumbertoletter On job_line_items.sequence =
    system.linenumbertoletter.linenumber


GO
