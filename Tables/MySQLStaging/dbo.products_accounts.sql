/****** Object:  Table [dbo].[products_accounts]    Script Date: 5/15/2018 12:04:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[products_accounts](
	[product_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[account_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[active] [smallint] NULL,
 CONSTRAINT [PK_products_accounts_product_id] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[products_accounts] ADD  DEFAULT ((1)) FOR [active]
GO
