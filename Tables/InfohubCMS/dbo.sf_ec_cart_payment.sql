/****** Object:  Table [dbo].[sf_ec_cart_payment]    Script Date: 5/15/2018 12:01:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_cart_payment](
	[payment_method_type] [int] NOT NULL,
	[payment_method_id] [uniqueidentifier] NULL,
	[cart_order_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[credit_card_type] [int] NOT NULL,
	[credit_card_number_last_four] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[credit_card_number] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[credit_card_issue_number] [int] NOT NULL,
	[credit_card_expire_year] [int] NOT NULL,
	[credit_card_expire_month] [int] NOT NULL,
	[credit_card_expire_day] [int] NOT NULL,
	[credit_card_customer_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[credit_card_bank_phone] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ec_cart_payment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_c_crt_pymnt_crt_rder_id]    Script Date: 5/15/2018 12:01:31 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_crt_pymnt_crt_rder_id] ON [dbo].[sf_ec_cart_payment]
(
	[cart_order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
