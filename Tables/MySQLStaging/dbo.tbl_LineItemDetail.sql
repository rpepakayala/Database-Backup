/****** Object:  Table [dbo].[tbl_LineItemDetail]    Script Date: 5/15/2018 12:04:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[tbl_LineItemDetail](
	[job_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[invoice_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Job] [int] NULL,
	[JobDesc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[phase_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InvoiceSequence] [int] NULL,
	[type] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[JobCreatedOn] [datetime] NULL,
	[JobExpiresOn] [date] NULL,
	[JobCompletedDate] [datetime] NULL,
	[JobAccountsID] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[job_line_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[JobLineLabel] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductName] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DisplayName] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SubProductName] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MailProductID] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SubProductID] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[productid] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoice_line_item_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[usage_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[unit_cost] [numeric](8, 2) NULL,
	[due_date] [datetime] NULL,
	[proofs_due] [datetime] NULL,
	[production_due_date] [datetime] NULL,
	[production_order] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[shipping_package_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[company_po] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sign_text] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LineDesc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[production_minutes] [int] NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime] NULL,
	[last_modified_on] [datetime] NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoice_line_item_id_link] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[quantity] [int] NULL,
	[price] [decimal](12, 2) NULL,
	[ext_price] [decimal](12, 2) NULL,
	[discount] [decimal](12, 2) NOT NULL,
	[tax] [decimal](12, 2) NULL,
	[tax_rate] [decimal](6, 3) NULL,
	[amount_due] [decimal](12, 2) NULL,
	[amount_paid] [decimal](12, 2) NOT NULL,
	[date_paid] [datetime2](0) NULL,
	[SalesSubTotal] [decimal](13, 2) NULL,
	[contact_entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[account_entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoiced_on] [datetime2](0) NULL,
	[paid_on] [datetime2](0) NULL,
	[po_number] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RevenueLocation] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[company_name] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date_placed] [datetime2](0) NULL,
	[date_unplaced] [datetime2](0) NULL,
	[Job_Line_Prod_Desc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Job_Line_Desc] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ServiceName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ServiceCategory] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[display_name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lookup_name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Width] [numeric](12, 4) NULL,
	[WidthUOM] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Height] [numeric](12, 4) NULL,
	[HeightUOM] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[royalty_exempt] [smallint] NULL,
	[salesperson] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[terms] [smallint] NULL,
	[ProductUsageIDAttribute] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[JobContactID] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[taxable] [smallint] NULL,
	[tax_code_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LineItem] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [idx_tbl_LineItemDetail_franchise_id]    Script Date: 5/15/2018 12:04:31 PM ******/
CREATE CLUSTERED INDEX [idx_tbl_LineItemDetail_franchise_id] ON [dbo].[tbl_LineItemDetail]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_franchise_id_unplaced]    Script Date: 5/15/2018 12:04:31 PM ******/
CREATE NONCLUSTERED INDEX [IDX_franchise_id_unplaced] ON [dbo].[tbl_LineItemDetail]
(
	[franchise_id] ASC,
	[date_unplaced] ASC
)
INCLUDE ( 	[ext_price],
	[discount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_tbl_LineItemDetail_franchise_id_includes]    Script Date: 5/15/2018 12:04:31 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_LineItemDetail_franchise_id_includes] ON [dbo].[tbl_LineItemDetail]
(
	[franchise_id] ASC
)
INCLUDE ( 	[job_id],
	[Job],
	[JobDesc],
	[phase_id],
	[type],
	[JobCreatedOn],
	[job_line_item_id],
	[JobLineLabel],
	[ProductName],
	[due_date],
	[proofs_due],
	[production_due_date],
	[shipping_package_id],
	[created_on],
	[ext_price],
	[discount],
	[amount_due],
	[SalesSubTotal],
	[contact_entity_id],
	[RevenueLocation],
	[company_name],
	[date_placed],
	[Job_Line_Desc]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_tbl_LineItemDetail_franchise_id_phase_id_company_name_includes]    Script Date: 5/15/2018 12:04:31 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_LineItemDetail_franchise_id_phase_id_company_name_includes] ON [dbo].[tbl_LineItemDetail]
(
	[franchise_id] ASC,
	[phase_id] ASC,
	[company_name] ASC
)
INCLUDE ( 	[job_id],
	[Job],
	[job_line_item_id],
	[contact_entity_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_tbl_LineItemDetail_franchise_id_phase_id_includes]    Script Date: 5/15/2018 12:04:31 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_LineItemDetail_franchise_id_phase_id_includes] ON [dbo].[tbl_LineItemDetail]
(
	[franchise_id] ASC,
	[phase_id] ASC
)
INCLUDE ( 	[job_id],
	[account_entity_id],
	[invoiced_on],
	[paid_on]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_tbl_LineItemDetail_franchise_id_phase_id_JobCreatedOn_includes]    Script Date: 5/15/2018 12:04:31 PM ******/
CREATE NONCLUSTERED INDEX [idx_tbl_LineItemDetail_franchise_id_phase_id_JobCreatedOn_includes] ON [dbo].[tbl_LineItemDetail]
(
	[franchise_id] ASC,
	[phase_id] ASC,
	[JobCreatedOn] ASC
)
INCLUDE ( 	[job_id],
	[JobAccountsID],
	[contact_entity_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
GO
