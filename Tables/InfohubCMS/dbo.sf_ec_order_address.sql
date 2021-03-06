/****** Object:  Table [dbo].[sf_ec_order_address]    Script Date: 5/15/2018 12:01:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_order_address](
	[state_region] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[postal_code] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[phone_extension] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[phone] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[order_id] [uniqueidentifier] NULL,
	[last_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[first_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[fax] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[county] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[country] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[company] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[city] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[address_type] [int] NOT NULL,
	[address2] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[address] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ec_order_address] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [idx_sf_c_rder_address_order_id]    Script Date: 5/15/2018 12:01:33 PM ******/
CREATE NONCLUSTERED INDEX [idx_sf_c_rder_address_order_id] ON [dbo].[sf_ec_order_address]
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
