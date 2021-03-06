/****** Object:  View [dbo].[vw_Job_Line_Item]    Script Date: 5/15/2018 12:14:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



CREATE VIEW [dbo].[vw_Job_Line_Item]
AS
Select
  sj.franchise_id As franchise_id,
  s.job_line_item_service_id As job_line_id,
  svc.revenue_location_id As revenue_location_id,
  sj.job_id As job_id,
  sj.sequence As job_sequence,
  sjli.sequence As line_item,
  sj.description As description,
  s.job_line_item_id As job_line_item_id,
  s.service_id As service_id,
  s.invoice_line_item_id As invoice_line_item_id,
  s.quantity As quantity,
  sjli.phase_id As phase_id,
  sp.parent_id As phase_parent_id,
  sp.name As name,
  s.unit_cost As unit_cost,
  s.[desc] As [desc],
  s.created_by As created_by,
  s.created_on As created_on,
  s.last_modified_on As last_modified_on,
  s.last_modified_by As last_modified_by,
  N'SERVICE' As SERVICE,
  sj.ecommerce As ecommerce,
  sj.repeat_job_flag As repeat_job_flag,
  sj.created_on As job_created,
  sj.last_modified_on As job_last_modified,
  sj.completed_date As completed_date,
  sili.invoice_id As invoice_id,
  sili.tax As tax,
  sili.amount_due As amount_due,
  sili.amount_paid As amount_paid,
  sili.discount As discount,
  sili.date_paid
From
  ((((job_line_items_services As s
  Inner Join job_line_items As sjli On s.job_line_item_id =
    sjli.job_line_item_id)
  Inner Join jobs As sj On sjli.job_id = sj.job_id)
  Inner Join phases As sp On sjli.phase_id = sp.phase_id)
  Inner Join invoice_line_items As sili On s.invoice_line_item_id =
    sili.invoice_line_item_id)
  Inner Join services As svc On s.service_id = svc.service_id
Union
Select
  mj.franchise_id As franchise_id,
  m.job_line_item_modifier_id As job_line_item_modifier_id,
  p.revenue_location_id As revenue_location_id,
  mj.job_id As job_id,
  mj.sequence As job_sequence,
  mjli.sequence As line_item,
  mj.description As description,
  m.job_line_item_id As job_line_item_id,
  m.modifier_id As modifier_id,
  m.invoice_line_item_id As invoice_line_item_id,
  1 As [1],
  mjli.phase_id As phase_id,
  mp.parent_id As parent_id,
  mp.name As name,
  m.unit_cost As unit_cost,
  m.[desc] As [desc],
  m.created_by As created_by,
  m.created_on As created_on,
  m.last_modified_on As last_modified_on,
  m.last_modified_by As last_modified_by,
  N'MODIFIER' As MODIFIER,
  mj.ecommerce As ecommerce,
  mj.repeat_job_flag As repeat_job_flag,
  mj.created_on As created_on,
  mj.last_modified_on As job_last_modified,
  mj.completed_date As completed_date,
  mili.invoice_id As invoice_id,
  mili.tax As tax,
  mili.amount_due As amount_due,
  mili.amount_paid As amount_paid,
  mili.discount As discount,
  mili.date_paid
From
  ((((job_line_items_modifiers As m
  Inner Join job_line_items As mjli On m.job_line_item_id =
    mjli.job_line_item_id)
  Inner Join jobs As mj On mjli.job_id = mj.job_id)
  Inner Join phases As mp On mjli.phase_id = mp.phase_id)
  Inner Join invoice_line_items As mili On m.invoice_line_item_id =
    mili.invoice_line_item_id)
  Inner Join products As p On mjli.product_id = p.product_id
Union
Select
  j.franchise_id As franchise_id,
  jl.job_line_item_id As job_line_item_id,
  pr.revenue_location_id As revenue_location_id,
  jl.job_id As job_id,
  j.sequence As job_sequence,
  jl.sequence As line_item,
  j.description As description,
  jl.job_line_item_id As job_line_item_id,
  jl.product_id As product_id,
  jl.invoice_line_item_id As invoice_line_item_id,
  jl.quantity As quantity,
  jl.phase_id As phase_id,
  p.parent_id As parent_id,
  p.name As name,
  jl.unit_cost As unit_cost,
  jl.name As name,
  jl.created_by As created_by,
  jl.created_on As created_on,
  jl.last_modified_on As last_modified_on,
  jl.last_modified_by As last_modified_by,
  N'PRODUCT' As PRODUCT,
  j.ecommerce As ecommerce,
  j.repeat_job_flag As repeat_job_flag,
  j.created_on As created_on,
  j.last_modified_on As job_last_modified,
  j.completed_date As completed_date,
  ili.invoice_id As invoice_id,
  ili.tax As tax,
  ili.amount_due As amount_due,
  ili.amount_paid As amount_paid,
  ili.discount As discount,
  ili.date_paid
From
  (((job_line_items As jl
  Inner Join jobs As j On jl.job_id = j.job_id)
  Inner Join phases As p On jl.phase_id = p.phase_id)
  Inner Join invoice_line_items As ili On jl.invoice_line_item_id =
    ili.invoice_line_item_id)
  Left Join products As pr On jl.product_id = pr.product_id
Union
Select
  *
From
  (Select
    invoices.franchise_id As franchise_id,
    jl.job_line_item_id As job_line_item_id,
    products.revenue_location_id As revenue_location_id,
    j.job_id As job_id,
    j.sequence As job_sequence,
    invoices.sequence As line_item,
    j.description As description,
    jl.job_line_item_id As job_line_item_id1,
    jl.product_id As product_id,
    ili.invoice_line_item_id As invoice_line_item_id,
    ili.quantity As quantity,
    jl.phase_id As phase_id,
    p.parent_id As parent_id,
    p.name As name,
    jl.unit_cost As unit_cost,
    'MOD' As [desc],
    ili.created_by As created_by,
    ili.created_on As created_on,
    ili.last_modified_on As last_modified_on,
    ili.last_modified_by As last_modified_by,
    N'Modifier' As Modifier,
    j.ecommerce As ecommerce,
    j.repeat_job_flag As repeat_job_flag,
    j.created_on As created_on1,
    j.last_modified_on As job_last_modified,
    j.completed_date As completed_date,
    ili.invoice_id As invoice_id,
    ili.tax As tax,
    ili.amount_due As amount_due,
    ili.amount_paid As amount_paid,
    ili.discount As discount,
    ili.date_paid
  From
    invoices Right Join
    invoice_line_items As ili On ili.invoice_id = invoices.invoice_id And
      ili.type = 'modifier' Right Join
    invoice_line_items On invoice_line_items.invoice_id = invoices.invoice_id
      And invoice_line_items.type = 'job' Join
    job_line_items As jl On invoice_line_items.invoice_line_item_id =
      jl.invoice_line_item_id Left Join
    phases As p On jl.phase_id = p.phase_id Inner Join
    jobs As j On invoices.job_id = j.job_id Left Join
    products On jl.product_id = products.product_id
  Where
    ili.created_by <> 'LEGACY' And
    ili.type = 'modifier') temp1



GO
