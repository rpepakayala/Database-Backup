/****** Object:  Table [dbo].[sf_ec_order_payment]    Script Date: 5/15/2018 12:01:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_order_payment](
	[successful_payment] [tinyint] NOT NULL,
	[payment_processor_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[payment_method_type] [int] NOT NULL,
	[payment_method_id] [uniqueidentifier] NULL,
	[order_id] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[gateway_transaction_type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_transaction_id] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_token] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_result] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_response] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[gateway_profile_id] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_payment_profile_id] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_fraud_response] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_duplicate] [tinyint] NOT NULL,
	[gateway_c_s_c_response] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_c_s_c] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_avs_zip] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gtwy_avs_address_international] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_avs_address] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_avs] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_auth_code] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_alt_transaction_id] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_additional_result] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_additional_response] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[gateway_a_p_i_version] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[fraud_score] [int] NOT NULL,
	[credit_card_type] [int] NOT NULL,
	[credit_card_number_last_four] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[credit_card_number] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[credit_card_issue_number] [int] NOT NULL,
	[credit_card_expire_year] [int] NOT NULL,
	[credit_card_expire_month] [int] NOT NULL,
	[credit_card_expire_day] [int] NOT NULL,
	[credit_card_customer_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[credit_card_bank_phone] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[attempt_number] [int] NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ec_order_payment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [idx_sf_c_rder_payment_order_id]    Script Date: 5/15/2018 12:01:34 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_rder_payment_order_id] ON [dbo].[sf_ec_order_payment]
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
