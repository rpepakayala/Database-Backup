/****** Object:  Table [dbo].[invoices]    Script Date: 5/15/2018 12:04:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[invoices](
	[invoice_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[job_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sequence] [int] NOT NULL,
	[print_sequence] [int] NULL,
	[roll_up_method] [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[invoice_type] [int] NOT NULL,
	[discount_roll_up] [int] NOT NULL,
	[terms] [smallint] NOT NULL,
	[contact_entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[account_entity_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[historical] [smallint] NOT NULL,
	[created_on] [datetime2](0) NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[invoiced_on] [datetime2](0) NULL,
	[paid_on] [datetime2](0) NULL,
	[last_modified_on] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_tax_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_transaction_cd] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sales_person] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_invoices_invoice_id] PRIMARY KEY CLUSTERED 
(
	[invoice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [account_entity_id]    Script Date: 5/15/2018 12:04:13 PM ******/
CREATE NONCLUSTERED INDEX [account_entity_id] ON [dbo].[invoices]
(
	[account_entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [contact_entity_id]    Script Date: 5/15/2018 12:04:13 PM ******/
CREATE NONCLUSTERED INDEX [contact_entity_id] ON [dbo].[invoices]
(
	[contact_entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_invoices_invoiced_on_includes]    Script Date: 5/15/2018 12:04:13 PM ******/
CREATE NONCLUSTERED INDEX [idx_invoices_invoiced_on_includes] ON [dbo].[invoices]
(
	[invoiced_on] ASC
)
INCLUDE ( 	[invoice_id],
	[job_id],
	[sequence],
	[contact_entity_id],
	[account_entity_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [ix_invoices_franchise_id_includes]    Script Date: 5/15/2018 12:04:13 PM ******/
CREATE NONCLUSTERED INDEX [ix_invoices_franchise_id_includes] ON [dbo].[invoices]
(
	[franchise_id] ASC
)
INCLUDE ( 	[invoice_id],
	[job_id],
	[sequence]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [job_id]    Script Date: 5/15/2018 12:04:13 PM ******/
CREATE NONCLUSTERED INDEX [job_id] ON [dbo].[invoices]
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [parent_id]    Script Date: 5/15/2018 12:04:13 PM ******/
CREATE NONCLUSTERED INDEX [parent_id] ON [dbo].[invoices]
(
	[parent_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__parent__361203C5]  DEFAULT (NULL) FOR [parent_id]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__roll_u__370627FE]  DEFAULT (N'default') FOR [roll_up_method]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__invoic__37FA4C37]  DEFAULT ((-1)) FOR [invoice_type]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__discou__38EE7070]  DEFAULT ((-1)) FOR [discount_roll_up]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__terms__39E294A9]  DEFAULT ((15)) FOR [terms]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__histor__3AD6B8E2]  DEFAULT ((0)) FOR [historical]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__create__3BCADD1B]  DEFAULT (NULL) FOR [created_on]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__create__3CBF0154]  DEFAULT (NULL) FOR [created_by]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__invoic__3DB3258D]  DEFAULT (NULL) FOR [invoiced_on]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__paid_o__3EA749C6]  DEFAULT (NULL) FOR [paid_on]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__last_m__3F9B6DFF]  DEFAULT (NULL) FOR [last_modified_on]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__last_m__408F9238]  DEFAULT (NULL) FOR [last_modified_by]
ALTER TABLE [dbo].[invoices] ADD  CONSTRAINT [DF__invoices__franch__4183B671]  DEFAULT (NULL) FOR [franchise_tax_id]
GO
