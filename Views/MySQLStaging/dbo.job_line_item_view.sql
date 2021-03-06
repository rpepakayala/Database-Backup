/****** Object:  View [dbo].[job_line_item_view]    Script Date: 5/15/2018 12:14:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW job_line_item_view  AS 
SELECT  sj.franchise_id AS franchise_id
      , s.job_line_item_service_id AS job_line_id
      , sj.job_id AS job_id
      , s.job_line_item_id AS job_line_item_id
      , s.service_id AS service_id
      , s.invoice_line_item_id AS invoice_line_item_id
      , s.quantity AS quantity
      , sjli.phase_id AS phase_id
      , sp.parent_id AS phase_parent_id
      , sp.name AS NAME
      , s.unit_cost AS unit_cost
      , s.[desc] AS [desc]
      , s.created_by AS created_by
      , s.created_on AS created_on
      , s.last_modified_on AS last_modified_on
      , s.last_modified_by AS last_modified_by
      , 'SERVICE' AS [SERVICE]
      , sj.ecommerce AS ecommerce
      , sj.repeat_job_flag AS repeat_job_flag
      , sj.created_on AS job_created
      , sj.last_modified_on AS job_last_modified
      , sj.completed_date AS completed_date
      , sili.invoice_id AS invoice_id
      , sili.tax AS tax
      , sili.amount_due AS amount_due
      , sili.amount_paid AS amount_paid
      , sili.discount AS discount
FROM    job_line_items_services s
        JOIN job_line_items sjli ON s.job_line_item_id = sjli.job_line_item_id
        JOIN jobs sj ON sjli.job_id = sj.job_id
        JOIN phases sp ON sjli.phase_id = sp.phase_id
        JOIN invoice_line_items sili ON s.invoice_line_item_id = sili.invoice_line_item_id

UNION
SELECT  mj.franchise_id AS franchise_id
      , m.job_line_item_modifier_id AS job_line_item_modifier_id
      , mj.job_id AS job_id
      , m.job_line_item_id AS job_line_item_id
      , m.modifier_id AS modifier_id
      , m.invoice_line_item_id AS invoice_line_item_id
      , 1 AS [1]
      , mjli.phase_id AS phase_id
      , mp.parent_id AS parent_id
      , mp.name AS name
      , m.unit_cost AS unit_cost
      , m.[desc] AS [desc]
      , m.created_by AS created_by
      , m.created_on AS created_on
      , m.last_modified_on AS last_modified_on
      , m.last_modified_by AS last_modified_by
      , 'MODIFIER' AS MODIFIER
      , mj.ecommerce AS ecommerce
      , mj.repeat_job_flag AS repeat_job_flag
      , mj.created_on AS created_on
      , mj.last_modified_on AS job_last_modified
      , mj.completed_date AS completed_date
      , mili.invoice_id AS invoice_id
      , mili.tax AS tax
      , mili.amount_due AS amount_due
      , mili.amount_paid AS amount_paid
      , mili.discount AS discount
FROM    ( ( ( ( job_line_items_modifiers m
                JOIN job_line_items mjli ON ( (m.job_line_item_id = mjli.job_line_item_id) )
              )
              JOIN jobs mj ON ( (mjli.job_id = mj.job_id) )
            )
            JOIN phases mp ON ( (mjli.phase_id = mp.phase_id) )
          )
          JOIN invoice_line_items mili ON ( (m.invoice_line_item_id = mili.invoice_line_item_id) )
        )

UNION
SELECT  j.franchise_id AS franchise_id
      , jl.job_line_item_id AS job_line_item_id
      , jl.job_id AS job_id
      , jl.job_line_item_id AS job_line_item_id
      , jl.product_id AS product_id
      , jl.invoice_line_item_id AS invoice_line_item_id
      , jl.quantity AS quantity
      , jl.phase_id AS phase_id
      , p.parent_id AS parent_id
      , p.name AS name
      , jl.unit_cost AS unit_cost
      , jl.name AS name
      , jl.created_by AS created_by
      , jl.created_on AS created_on
      , jl.last_modified_on AS last_modified_on
      , jl.last_modified_by AS last_modified_by
      , 'PRODUCT' AS PRODUCT
      , j.ecommerce AS ecommerce
      , j.repeat_job_flag AS repeat_job_flag
      , j.created_on AS created_on
      , j.last_modified_on AS job_last_modified
      , j.completed_date AS completed_date
      , ili.invoice_id AS invoice_id
      , ili.tax AS tax
      , ili.amount_due AS amount_due
      , ili.amount_paid AS amount_paid
      , ili.discount AS discount
FROM    ( ( ( job_line_items jl
              JOIN jobs j ON ( (jl.job_id = j.job_id) )
            )
            JOIN phases p ON ( (jl.phase_id = p.phase_id) )
          )
          JOIN invoice_line_items ili ON ( (jl.invoice_line_item_id = ili.invoice_line_item_id) )
        )
;





GO
