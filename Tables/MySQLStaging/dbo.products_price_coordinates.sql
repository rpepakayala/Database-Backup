/****** Object:  Table [dbo].[products_price_coordinates]    Script Date: 5/15/2018 12:04:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[products_price_coordinates](
	[product_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[x] [decimal](10, 2) NOT NULL,
	[y] [decimal](10, 2) NOT NULL,
	[height] [decimal](10, 2) NOT NULL,
	[width] [decimal](10, 2) NOT NULL,
	[unit_id] [bigint] NOT NULL,
	[per_piece_min] [decimal](10, 2) NULL,
	[per_line_item_min] [decimal](10, 2) NULL,
 CONSTRAINT [PK_products_price_coordinates_product_id] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[x] ASC,
	[y] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[products_price_coordinates] ADD  DEFAULT (NULL) FOR [per_piece_min]
ALTER TABLE [dbo].[products_price_coordinates] ADD  DEFAULT (NULL) FOR [per_line_item_min]
GO
