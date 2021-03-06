/****** Object:  Table [dbo].[sf_ec_discount]    Script Date: 5/15/2018 12:01:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_discount](
	[usge] [int] NOT NULL,
	[title_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[start_date] [datetime] NOT NULL,
	[minimum_subtotal] [numeric](20, 10) NOT NULL,
	[maximum_subtotal] [numeric](20, 10) NULL,
	[last_modified] [datetime] NOT NULL,
	[is_coupon_code_required] [tinyint] NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[end_date] [datetime] NULL,
	[discount_used] [int] NOT NULL,
	[discount_type] [int] NOT NULL,
	[discount_amount_type] [int] NOT NULL,
	[discount_amount] [numeric](20, 10) NOT NULL,
	[coupon_code] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[apply_for] [int] NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ec_discount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
