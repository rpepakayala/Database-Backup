/****** Object:  Table [dbo].[sf_ec_tax]    Script Date: 5/15/2018 12:01:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_tax](
	[use_zip_range] [tinyint] NOT NULL,
	[to_zip] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_rates] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tax_rate] [numeric](20, 10) NOT NULL,
	[stte] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_modified] [datetime] NOT NULL,
	[include_tax_in_price] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[from_zip] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[county] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[country] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[city] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[apply_tax_to_shipping] [tinyint] NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[address_type] [int] NOT NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_ec_tax] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
