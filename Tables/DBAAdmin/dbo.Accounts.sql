/****** Object:  Table [dbo].[Accounts]    Script Date: 5/15/2018 11:59:08 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Accounts](
	[___c_ID] [float] NULL,
	[___d_account_manager] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___d_account_referrer] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[___d_address_hq] [float] NULL,
	[___d_contact_billing] [float] NULL,
	[___d_contact_primary] [float] NULL,
	[___d_phone_hq] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_filter_date] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_filter_date_end] [datetime] NULL,
	[_filter_date_start] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_filter_invoiced] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_include_in_Sales_Report] [float] NULL,
	[_is_active] [float] NULL,
	[_report_4200] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_report_adjusted_sales] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_report_adjusted_sales_TOTAL] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_report_sales] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_SUM_report_4200] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_SUM_report_adjusted_sales] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_SUM_report_sales] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Accounting_ID] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[billing_central] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[billing_taxable] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[status_activity] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[status_credit] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
