/****** Object:  Table [dbo].[sf_ec_wishlist]    Script Date: 5/15/2018 12:01:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_ec_wishlist](
	[wishlist_date] [datetime] NOT NULL,
	[user_id] [uniqueidentifier] NOT NULL,
	[ttal] [numeric](20, 10) NOT NULL,
	[title_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[privacy_option] [int] NOT NULL,
	[last_modified] [datetime] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[exchange_rate_total] [numeric](20, 10) NOT NULL,
	[currency] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_ec_wishlist] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
