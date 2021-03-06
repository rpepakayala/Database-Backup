/****** Object:  Table [dbo].[discounts]    Script Date: 5/15/2018 12:04:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[discounts](
	[discount_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[discount_type_id] [int] NOT NULL,
	[name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[value] [decimal](6, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[effective_on] [datetime2](0) NULL,
	[expires_on] [date] NULL,
	[corporate_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_discounts_discount_id] PRIMARY KEY CLUSTERED 
(
	[discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [corporate_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [corporate_id] ON [dbo].[discounts]
(
	[corporate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [discount_type_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [discount_type_id] ON [dbo].[discounts]
(
	[discount_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:02 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[discounts]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[discounts] ADD  DEFAULT (N'0') FOR [franchise_id]
ALTER TABLE [dbo].[discounts] ADD  DEFAULT (NULL) FOR [effective_on]
ALTER TABLE [dbo].[discounts] ADD  DEFAULT (NULL) FOR [expires_on]
ALTER TABLE [dbo].[discounts] ADD  DEFAULT (NULL) FOR [corporate_id]
GO
