/****** Object:  Table [dbo].[accounts]    Script Date: 5/15/2018 12:03:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[accounts](
	[accounts_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[display_id] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[parent_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[company_name] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_id_number] [nvarchar](45) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_id_expiry_date] [date] NULL,
	[tax_exempt] [smallint] NULL,
	[nap] [smallint] NULL,
	[default_payment_terms] [nchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[approved_for_credit_status] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[approved_for_credit_date] [date] NULL,
	[credit_amount_approved] [decimal](10, 2) NULL,
	[traditional] [smallint] NULL,
	[select_jobs_to_store] [smallint] NULL,
	[url] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[credits_on_acct_balance] [decimal](11, 2) NOT NULL,
	[active] [smallint] NULL,
	[repeat_customer_flag] [smallint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified_on] [datetime2](0) NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[group_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[default_tax_service] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ecomm_po_approved_flag] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_accounts_accounts_id] PRIMARY KEY CLUSTERED 
(
	[accounts_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [accounts$display_id] UNIQUE NONCLUSTERED 
(
	[display_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [default_tax_service]    Script Date: 5/15/2018 12:03:56 PM ******/
CREATE NONCLUSTERED INDEX [default_tax_service] ON [dbo].[accounts]
(
	[default_tax_service] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:03:56 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[accounts]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [group_id]    Script Date: 5/15/2018 12:03:56 PM ******/
CREATE NONCLUSTERED INDEX [group_id] ON [dbo].[accounts]
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_accounts_company_name_includes]    Script Date: 5/15/2018 12:03:56 PM ******/
CREATE NONCLUSTERED INDEX [idx_accounts_company_name_includes] ON [dbo].[accounts]
(
	[company_name] ASC
)
INCLUDE ( 	[accounts_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [idx_accounts_created_on_includes]    Script Date: 5/15/2018 12:03:56 PM ******/
CREATE NONCLUSTERED INDEX [idx_accounts_created_on_includes] ON [dbo].[accounts]
(
	[created_on] ASC
)
INCLUDE ( 	[accounts_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [display_id]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [parent_id]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [company_name]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [tax_id_number]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [tax_id_expiry_date]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [tax_exempt]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [nap]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [default_payment_terms]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [approved_for_credit_date]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [credit_amount_approved]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [traditional]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [select_jobs_to_store]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [url]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT ((0.00)) FOR [credits_on_acct_balance]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [active]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT ((0)) FOR [repeat_customer_flag]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [last_modified_on]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [last_modified_by]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [group_id]
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (NULL) FOR [default_tax_service]
GO
