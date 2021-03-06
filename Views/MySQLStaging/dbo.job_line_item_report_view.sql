/****** Object:  View [dbo].[job_line_item_report_view]    Script Date: 5/15/2018 12:14:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW dbo.job_line_item_report_view
    (
      [franchise_id] ,
      [job_line_id] ,
      [revenue_location_id] ,
      [job_id] ,
      [job_sequence] ,
      [description] ,
      [job_line_item_id] ,
      [service_id] ,
      [invoice_line_item_id] ,
      [quantity] ,
      [phase_id] ,
      [phase_parent_id] ,
      [name] ,
      [unit_cost] ,
      [desc] ,
      [created_by] ,
      [created_on] ,
      [last_modified_on] ,
      [last_modified_by] ,
      [SERVICE] ,
      [ecommerce] ,
      [repeat_job_flag] ,
      [job_created] ,
      [job_last_modified] ,
      [completed_date] ,
      [invoice_id] ,
      [tax] ,
      [amount_due] ,
      [amount_paid] ,
      [discount]
    )
AS
    SELECT
        sj.franchise_id AS franchise_id ,
        s.job_line_item_service_id AS job_line_id ,
        svc.revenue_location_id AS revenue_location_id ,
        sj.job_id AS job_id ,
        sj.sequence AS job_sequence ,
        sj.description AS description ,
        s.job_line_item_id AS job_line_item_id ,
        s.service_id AS service_id ,
        s.invoice_line_item_id AS invoice_line_item_id ,
        s.quantity AS quantity ,
        sjli.phase_id AS phase_id ,
        sp.parent_id AS phase_parent_id ,
        sp.name AS name ,
        s.unit_cost AS unit_cost ,
        s.[desc] AS [desc] ,
        s.created_by AS created_by ,
        s.created_on AS created_on ,
        s.last_modified_on AS last_modified_on ,
        s.last_modified_by AS last_modified_by ,
        N'SERVICE' AS SERVICE ,
        sj.ecommerce AS ecommerce ,
        sj.repeat_job_flag AS repeat_job_flag ,
        sj.created_on AS job_created ,
        sj.last_modified_on AS job_last_modified ,
        sj.completed_date AS completed_date ,
        sili.invoice_id AS invoice_id ,
        sili.tax AS tax ,
        sili.amount_due AS amount_due ,
        sili.amount_paid AS amount_paid ,
        sili.discount AS discount
    FROM
        ( ( ( ( ( dbo.job_line_items_services AS s
                  INNER JOIN dbo.job_line_items AS sjli ON ( (s.job_line_item_id = sjli.job_line_item_id) )
                )
                INNER JOIN dbo.jobs AS sj ON ( (sjli.job_id = sj.job_id) )
              )
              INNER JOIN dbo.phases AS sp ON ( (sjli.phase_id = sp.phase_id) )
            )
            INNER JOIN dbo.invoice_line_items AS sili ON ( (s.invoice_line_item_id = sili.invoice_line_item_id) )
          )
          INNER JOIN dbo.services AS svc ON ( (s.service_id = svc.service_id) )
        )
    UNION ALL
    SELECT
        mj.franchise_id AS franchise_id ,
        m.job_line_item_modifier_id AS job_line_item_modifier_id ,
        p.revenue_location_id AS revenue_location_id ,
        mj.job_id AS job_id ,
        mj.sequence AS job_sequence ,
        mj.description AS description ,
        m.job_line_item_id AS job_line_item_id ,
        m.modifier_id AS modifier_id ,
        m.invoice_line_item_id AS invoice_line_item_id ,
        1 AS [1] ,
        mjli.phase_id AS phase_id ,
        mp.parent_id AS parent_id ,
        mp.name AS name ,
        m.unit_cost AS unit_cost ,
        m.[desc] AS [desc] ,
        m.created_by AS created_by ,
        m.created_on AS created_on ,
        m.last_modified_on AS last_modified_on ,
        m.last_modified_by AS last_modified_by ,
        N'MODIFIER' AS MODIFIER ,
        mj.ecommerce AS ecommerce ,
        mj.repeat_job_flag AS repeat_job_flag ,
        mj.created_on AS created_on ,
        mj.last_modified_on AS job_last_modified ,
        mj.completed_date AS completed_date ,
        mili.invoice_id AS invoice_id ,
        mili.tax AS tax ,
        mili.amount_due AS amount_due ,
        mili.amount_paid AS amount_paid ,
        mili.discount AS discount
    FROM
        ( ( ( ( ( dbo.job_line_items_modifiers AS m
                  INNER JOIN dbo.job_line_items AS mjli ON ( (m.job_line_item_id = mjli.job_line_item_id) )
                )
                INNER JOIN dbo.jobs AS mj ON ( (mjli.job_id = mj.job_id) )
              )
              INNER JOIN dbo.phases AS mp ON ( (mjli.phase_id = mp.phase_id) )
            )
            INNER JOIN dbo.invoice_line_items AS mili ON ( (m.invoice_line_item_id = mili.invoice_line_item_id) )
          )
          INNER JOIN dbo.products AS p ON ( (mjli.product_id = p.product_id) )
        )
    UNION all
    SELECT
        j.franchise_id AS franchise_id ,
        jl.job_line_item_id AS job_line_item_id ,
        pr.revenue_location_id AS revenue_location_id ,
        jl.job_id AS job_id ,
        j.sequence AS job_sequence ,
        j.description AS description ,
        jl.job_line_item_id AS job_line_item_id ,
        jl.product_id AS product_id ,
        jl.invoice_line_item_id AS invoice_line_item_id ,
        jl.quantity AS quantity ,
        jl.phase_id AS phase_id ,
        p.parent_id AS parent_id ,
        p.name AS name ,
        jl.unit_cost AS unit_cost ,
        jl.name AS name ,
        jl.created_by AS created_by ,
        jl.created_on AS created_on ,
        jl.last_modified_on AS last_modified_on ,
        jl.last_modified_by AS last_modified_by ,
        N'PRODUCT' AS PRODUCT ,
        j.ecommerce AS ecommerce ,
        j.repeat_job_flag AS repeat_job_flag ,
        j.created_on AS created_on ,
        j.last_modified_on AS job_last_modified ,
        j.completed_date AS completed_date ,
        ili.invoice_id AS invoice_id ,
        ili.tax AS tax ,
        ili.amount_due AS amount_due ,
        ili.amount_paid AS amount_paid ,
        ili.discount AS discount
    FROM
        ( ( ( ( dbo.job_line_items AS jl
                INNER JOIN dbo.jobs AS j ON ( (jl.job_id = j.job_id) )
              )
              INNER JOIN dbo.phases AS p ON ( (jl.phase_id = p.phase_id) )
            )
            INNER JOIN dbo.invoice_line_items AS ili ON ( (jl.invoice_line_item_id = ili.invoice_line_item_id) )
          )
          INNER JOIN dbo.products AS pr ON ( (jl.product_id = pr.product_id) )
        )

GO
