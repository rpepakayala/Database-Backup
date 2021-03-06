/****** Object:  Table [dbo].[quickbooks_aliases]    Script Date: 5/15/2018 12:04:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[quickbooks_aliases](
	[quickbooks_alias_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[quickbooks_account_id] [bigint] NOT NULL,
	[alias] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_quickbooks_aliases_quickbooks_alias_id] PRIMARY KEY CLUSTERED 
(
	[quickbooks_alias_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [account]    Script Date: 5/15/2018 12:04:28 PM ******/
CREATE NONCLUSTERED INDEX [account] ON [dbo].[quickbooks_aliases]
(
	[quickbooks_account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:28 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[quickbooks_aliases]
(
	[franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
