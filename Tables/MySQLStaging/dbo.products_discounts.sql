/****** Object:  Table [dbo].[products_discounts]    Script Date: 5/15/2018 12:04:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[products_discounts](
	[product_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[discount_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[products_discounts_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[discount_usage_id] [int] NULL,
 CONSTRAINT [PK_products_discounts_products_discounts_id] PRIMARY KEY CLUSTERED 
(
	[products_discounts_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [product_id]    Script Date: 5/15/2018 12:04:25 PM ******/
CREATE NONCLUSTERED INDEX [product_id] ON [dbo].[products_discounts]
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[products_discounts] ADD  DEFAULT (N'') FOR [products_discounts_id]
ALTER TABLE [dbo].[products_discounts] ADD  DEFAULT (NULL) FOR [discount_usage_id]
GO
