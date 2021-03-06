/****** Object:  View [dbo].[timtest]    Script Date: 5/15/2018 12:14:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON




CREATE VIEW [dbo].[timtest]
AS
    SELECT
        jobs.job_id ,
        jobs.franchise_id ,
        jobs.sequence AS Job ,
        jobs.description AS JobDesc ,
        ISNULL(job_line_items.phase_id,
               ISNULL(Serv.phase_id,
                      ISNULL(Modi.phase_id, ServiceOnly.phase_id))) AS phase_id ,
        invoices.sequence AS InvoiceSequence ,
        invoice_line_items.type ,
        jobs.created_on AS JobCreatedOn ,
        jobs.completed_date AS JobCompletedDate ,
        jobs.accounts_id AS JobAccountsID ,
        job_line_items.job_line_item_id ,
        job_line_items.parent_id ,
        CASE WHEN sub.sequence IS NULL
             THEN dbo.LineItemNumberToLetter(CASE WHEN invoice_line_items.type = 'service'
                                                  THEN Serv.sequence
                                                  WHEN invoice_line_items.type = 'modifier'
                                                  THEN Modi.sequence
                                                  WHEN job_line_items.name = 'Service Only'
                                                  THEN ServiceOnly.sequence
                                                  ELSE job_line_items.sequence
                                             END)
             ELSE CONVERT(VARCHAR(4), dbo.LineItemNumberToLetter(sub.sequence)
                  + ISNULL('-' + CONVERT(VARCHAR(2), job_line_items.sequence),
                           ''))
        END AS JobLineLabel ,
        job_line_items.name AS ProductName ,
        sub.name AS SubProductName ,
        job_line_items.product_id AS MailProductID ,
        sub.product_id AS SubProductID ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.product_id
             ELSE job_line_items.product_id
        END AS productid ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.invoice_line_item_id
             ELSE invoice_line_items.invoice_line_item_id
        END AS invoice_line_item_id ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.usage_id
             ELSE job_line_items.usage_id
        END AS usage_id ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.unit_cost
             ELSE job_line_items.unit_cost
        END AS unit_cost ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.due_date
             ELSE job_line_items.due_date
        END AS due_date ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.proofs_due
             ELSE job_line_items.proofs_due
        END AS proofs_due ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.production_due_date
             ELSE job_line_items.production_due_date
        END AS production_due_date ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.production_order
             ELSE job_line_items.production_order
        END AS production_order ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.shipping_package_id
             ELSE job_line_items.shipping_package_id
        END AS shipping_package_id ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.company_po
             ELSE job_line_items.company_po
        END AS company_po ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.sign_text
             ELSE job_line_items.sign_text
        END AS sign_text ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.[desc]
             ELSE job_line_items.[desc]
        END AS LineDesc ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.production_minutes
             ELSE job_line_items.production_minutes
        END AS production_minutes ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.created_by
             ELSE job_line_items.created_by
        END AS created_by ,
        CASE WHEN job_line_items.parent_id IS NOT NULL THEN sub.created_on
             ELSE job_line_items.created_on
        END AS created_on ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.last_modified_on
             ELSE job_line_items.last_modified_on
        END AS last_modified_on ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.last_modified_by
             ELSE job_line_items.last_modified_by
        END AS last_modified_by ,
        CASE WHEN job_line_items.parent_id IS NOT NULL
             THEN sub.invoice_line_item_id
             ELSE job_line_items.invoice_line_item_id
        END AS invoice_line_item_id_link ,
        invoice_line_items.quantity ,
        invoice_line_items.price ,
        invoice_line_items.ext_price ,
        invoice_line_items.discount ,
        invoice_line_items.tax ,
        invoice_line_items.tax_rate ,
        invoice_line_items.amount_due ,
        invoice_line_items.amount_paid ,
        invoice_line_items.date_paid ,
        invoices.contact_entity_id ,
        invoices.account_entity_id ,
        invoices.invoiced_on ,
        invoices.paid_on ,
        jobs.po_number ,
        CASE WHEN invoice_line_items.type = 'service'
             THEN Serv.revenue_location
             WHEN invoice_line_items.type = 'modifier'
             THEN Modi.RevenueLocation
             WHEN job_line_items.name = 'Service Only'
             THEN ServiceOnly.ServiceRevLoc
             ELSE revenue_locations.name
        END AS RevenueLocation ,
        accounts.company_name
    FROM
        invoice_line_items
        LEFT JOIN invoices ON invoices.invoice_id = invoice_line_items.invoice_id
        INNER JOIN jobs ON jobs.job_id = invoices.job_id
        LEFT JOIN job_line_items ON invoice_line_items.invoice_line_item_id = job_line_items.invoice_line_item_id
        LEFT JOIN job_line_items sub ON job_line_items.parent_id = sub.job_line_item_id
        LEFT JOIN ( SELECT
                        ili.invoice_line_item_id ,
                        services.name ,
                        services.description ,
                        revenue_locations.name AS revenue_location ,
                        job_line_items_services.job_line_item_id ,
                        job_line_items.sequence ,
                        job_line_items.phase_id
                    FROM
                        invoice_line_items ili
                        INNER JOIN job_line_items_services ON ili.invoice_line_item_id = job_line_items_services.invoice_line_item_id
                        INNER JOIN services ON job_line_items_services.service_id = services.service_id
                        INNER JOIN revenue_locations ON services.revenue_location_id = revenue_locations.revenue_location_id
                        LEFT JOIN job_line_items ON job_line_items_services.job_line_item_id = job_line_items.job_line_item_id
                  ) Serv ON invoice_line_items.invoice_line_item_id = Serv.invoice_line_item_id
        LEFT JOIN ( SELECT
                        ili.invoice_line_item_id ,
                        products.display_name ,
                        revenue_locations.name AS RevenueLocation ,
                        job_line_items.sequence ,
                        job_line_items.phase_id
                    FROM
                        invoice_line_items ili
                        LEFT JOIN job_line_items_modifiers ON ili.invoice_line_item_id = job_line_items_modifiers.invoice_line_item_id
                        LEFT JOIN job_line_items ON job_line_items_modifiers.job_line_item_id = job_line_items.job_line_item_id
                        LEFT JOIN products ON job_line_items.product_id = products.product_id
                        LEFT JOIN revenue_locations ON products.revenue_location_id = revenue_locations.revenue_location_id
                  ) Modi ON invoice_line_items.invoice_line_item_id = Modi.invoice_line_item_id
        LEFT JOIN products ON job_line_items.product_id = products.product_id
        LEFT JOIN revenue_locations ON products.revenue_location_id = revenue_locations.revenue_location_id
        LEFT JOIN accounts ON jobs.accounts_id = accounts.accounts_id
        LEFT JOIN ( SELECT
                        job_line_items.job_line_item_id ,
                        services.revenue_location_id ,
                        revenue_locations.name AS ServiceRevLoc ,
                        job_line_items.sequence ,
                        job_line_items.phase_id
                    FROM
                        job_line_items
                        LEFT JOIN job_line_items_services jlis ON job_line_items.job_line_item_id = jlis.job_line_item_id
                        LEFT JOIN services ON jlis.service_id = services.service_id
                        LEFT JOIN revenue_locations ON services.revenue_location_id = revenue_locations.revenue_location_id
                  ) ServiceOnly ON job_line_items.job_line_item_id = ServiceOnly.job_line_item_id
GO
