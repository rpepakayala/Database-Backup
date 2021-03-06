/****** Object:  View [dbo].[vw_InvoiceVoid]    Script Date: 5/15/2018 12:14:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_InvoiceVoid
AS
    SELECT
        invoice_void.invoice_void_id ,
        invoice_void.job_id ,
        invoice_void.invoice_id ,
        invoice_void.subtotal ,
        invoice_void.discount ,
        invoice_void.taxes ,
        invoice_void.amount_due ,
        invoice_void.created_by ,
        invoice_void.created_on ,
        invoice_void.notes ,
        invoice_void.royalty_impact ,
        invoice_void.invoiced_on ,
        jobs.franchise_id
    FROM
        invoice_void
        INNER JOIN jobs ON invoice_void.job_id = jobs.job_id
GO
