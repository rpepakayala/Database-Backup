/****** Object:  Table [dbo].[shopping_carts]    Script Date: 5/15/2018 12:04:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[shopping_carts](
	[shopping_cart_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[date_created] [datetime2](0) NOT NULL,
	[date_modified] [datetime2](0) NOT NULL,
	[ip_address] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_shopping_carts_shopping_cart_id] PRIMARY KEY CLUSTERED 
(
	[shopping_cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [date_created]    Script Date: 5/15/2018 12:04:31 PM ******/
CREATE NONCLUSTERED INDEX [date_created] ON [dbo].[shopping_carts]
(
	[date_created] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
