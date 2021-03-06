/****** Object:  Table [dbo].[products_sizes]    Script Date: 5/15/2018 12:04:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[products_sizes](
	[products_sizes_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[product_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[width] [numeric](10, 2) NOT NULL,
	[height] [numeric](10, 2) NOT NULL,
	[ecommerce_size_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_products_sizes_products_sizes_id] PRIMARY KEY CLUSTERED 
(
	[products_sizes_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [product_id]    Script Date: 5/15/2018 12:04:26 PM ******/
CREATE NONCLUSTERED INDEX [product_id] ON [dbo].[products_sizes]
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[products_sizes] ADD  DEFAULT (NULL) FOR [ecommerce_size_id]
GO
